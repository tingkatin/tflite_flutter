/*
 * Copyright 2023 The TensorFlow Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *             http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cocoa/components/result_detection.dart';
import 'package:cocoa/helpers/constants.dart';
import 'package:cocoa/helpers/process_result.dart';
import 'package:flutter/material.dart';
import 'package:cocoa/lib/tflite/image_classification_helper.dart';
import 'package:resource_usage/resource_usage.dart';

class Live extends StatefulWidget {
  const Live({
    super.key,
    required this.camera,
    required this.threshold,
  });

  final CameraDescription camera;
  final double threshold;

  @override
  State<StatefulWidget> createState() => LiveState();
}

class LiveState extends State<Live> with WidgetsBindingObserver {
  late CameraController cameraController;
  late ImageClassificationHelper imageClassificationHelper;
  Map<String, double>? classification;
  bool _isProcessing = false;
  int? inferenceTime;
  double cpuDifference = 0.0;
  double memoryDifference = 0.0;

  // init camera
  initCamera() {
    cameraController = CameraController(widget.camera, ResolutionPreset.medium,
        imageFormatGroup: Platform.isIOS
            ? ImageFormatGroup.bgra8888
            : ImageFormatGroup.yuv420);
    cameraController.initialize().then((value) {
      cameraController.startImageStream(imageAnalysis);
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<double> getMemoryUsage() async {
    var resource = ResourceUsage();
    double memory = await resource.getMemoryUsage() ?? 0.0;
    return memory;
  }

  Future<List<double>> getCpuStart() async {
    var resource = ResourceUsage();
    List<double> cpuAndProcessTimes = await resource.getCpuStart() ?? [];
    return cpuAndProcessTimes;
  }

  Future<double> getCpuEnd(double cpuTimeSec, double processTimeSec) async {
    var resource = ResourceUsage();
    double avgLoad =
        await resource.getCpuEnd(cpuTimeSec, processTimeSec) ?? 0.0;
    return avgLoad;
  }

  Future<void> imageAnalysis(CameraImage cameraImage) async {
    // if image is still analyze, skip this frame
    if (_isProcessing) {
      return;
    }
    _isProcessing = true;
    double memBefore = await getMemoryUsage();
    List<double> timesStart = await getCpuStart();

    classification =
        await imageClassificationHelper.inferenceCameraFrame(cameraImage);

    double cpuDiff = await getCpuEnd(timesStart[0], timesStart[1]);
    double memAfter = await getMemoryUsage();

    double memoryDiff = (memAfter - memBefore).abs();

    inferenceTime = classification?["inference_time"]?.toInt();
    classification?.remove("inference_time");

    var processed = processOutput(classification, widget.threshold);

    _isProcessing = false;

    if (mounted) {
      setState(() {
        classification = processed;
        inferenceTime = inferenceTime;
        cpuDifference = cpuDiff;
        memoryDifference = memoryDiff;
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    initCamera();
    imageClassificationHelper = ImageClassificationHelper();
    imageClassificationHelper.initHelper();
    super.initState();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        cameraController.stopImageStream();
        break;
      case AppLifecycleState.resumed:
        if (!cameraController.value.isStreamingImages) {
          await cameraController.startImageStream(imageAnalysis);
        }
        break;
      default:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController.dispose();
    imageClassificationHelper.close();
    super.dispose();
  }

  Widget cameraWidget(context) {
    var camera = cameraController.value;
    // fetch screen size
    final size = MediaQuery.of(context).size;

    // calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = size.aspectRatio * camera.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    return Transform.scale(
      scale: scale,
      child: Center(
        child: CameraPreview(cameraController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    List<Widget> list = [];

    list.add(
      SizedBox(
        height: 420,
        child: (!cameraController.value.isInitialized)
            ? Container()
            : cameraWidget(context),
      ),
    );
    list.add(Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 400,
        width: double.infinity,
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(Constants.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (classification != null && classification!.isNotEmpty)
                  ResultDetection(
                      classification: classification,
                      inferenceTime: inferenceTime,
                      cpuUsage: cpuDifference,
                      memoryUsage: memoryDifference)
                else
                  Center(child: Text("Objek tidak dikenali")),
              ],
            ),
          ),
        ),
      ),
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Live Capture',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      body: ListView(
        children: list,
      ),
    );
  }
}
