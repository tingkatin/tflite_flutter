import 'dart:io';

import 'package:cocoa/components/action_button.dart';
import 'package:cocoa/components/image_preview.dart';
import 'package:cocoa/components/info_tile.dart';
import 'package:cocoa/components/result_modal.dart';
import 'package:cocoa/helpers/constants.dart';
import 'package:cocoa/helpers/process_result.dart';
import 'package:cocoa/lib/tflite/image_classification_helper.dart';
import 'package:cocoa/pages/amelonado_route.dart';
import 'package:cocoa/pages/angoleta_route.dart';
import 'package:cocoa/pages/guiana_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resource_usage/resource_usage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

enum PickerSource { camera, gallery }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? imagePreview;
  ImagePicker imagePicker = ImagePicker();
  ImageClassificationHelper? imageClassificationHelper;
  double threshold = 0.5;

  void _initializeState() {
    imageClassificationHelper = ImageClassificationHelper();
    imageClassificationHelper!.initHelper();
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

  void reset() {
    setState(() {
      imagePreview = null;
    });
  }

  Future<void> pickImage(PickerSource imageSource) async {
    reset();

    var source = ImageSource.camera;

    if (imageSource == PickerSource.gallery) {
      source = ImageSource.gallery;
    }

    XFile? pickedImage = await imagePicker.pickImage(source: source);

    showModalBottomSheet(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        isDismissible: true,
        showDragHandle: true,
        builder: (BuildContext context) =>
            ResultModal(processImage: processImage(imagePreview, threshold)));

    if (pickedImage == null) {
      // Dismiss the modal when the image picking is canceled
      Navigator.pop(context);
      return;
    }

    setState(() {
      imagePreview = File(pickedImage.path);
    });
  }

  Future<Map<String, dynamic>?>? processImage(
      File? imagePreview, double threshold) async {
    if (imagePreview != null) {
      var imageData = imagePreview.readAsBytesSync();
      var image = img.decodeImage(imageData);

      double memBefore = await getMemoryUsage();

      List<double> timesStart = await getCpuStart();

      // Doing Inference
      Map<String, double>? classification =
          await imageClassificationHelper?.inferenceImage(image!);

      double cpuDifference = await getCpuEnd(timesStart[0], timesStart[1]);

      double memAfter = await getMemoryUsage();

      int? inferenceTime = classification?["inference_time"]?.toInt();
      classification?.remove("inference_time");

      double memoryDifference = (memAfter - memBefore).abs();

      // Preprocess Inference Output
      var processed = processOutput(classification, threshold);

      return {
        'classification': processed,
        'inferenceTime': inferenceTime,
        'cpuUsage': cpuDifference,
        'memoryUsage': memoryDifference,
      };
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(Constants.padding,
                  Constants.padding, Constants.padding, Constants.padding - 10),
              child: Text(
                "Mulai Mendeteksi",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Constants.padding),
              child: ImagePreview(image: imagePreview),
            ),

            const SizedBox(height: Constants.distance),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Constants.padding),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ActionButton(
                      icon: const Icon(Icons.camera_alt),
                      text: "Ambil Foto",
                      pickImage: () async => pickImage(PickerSource.camera),
                    ),
                  ),
                  const SizedBox(width: Constants.distance),
                  Expanded(
                    flex: 1,
                    child: ActionButton(
                      icon: const Icon(Icons.photo),
                      text: "Buka Galeri",
                      pickImage: () async => pickImage(PickerSource.gallery),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: Constants.distance),

            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: Constants.distance),
              padding: const EdgeInsets.all(Constants.padding),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(Constants.borderRadius),
              ),
              width: double.infinity,
              child: Column(children: [
                // TITLE
                Center(
                  child: Text(
                    "Threshold: $threshold",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),

                // SLIDER
                Slider(
                  value: threshold,
                  min: 0.3,
                  max: 0.9,
                  divisions: 6,
                  label: threshold.toStringAsFixed(1),
                  onChanged: (double value) {
                    setState(() {
                      threshold = (value * 10).roundToDouble() / 10;
                    });
                  },
                ),

                // NOTICE
                Container(
                  padding: const EdgeInsets.all(Constants.padding),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    // border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(Constants.borderRadius),
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                        "Nilai Threshold dapat diatur untuk mempengaruhi sensitivitas model untuk mendeteksi kakao pada citra.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                ),
              ]),
            ),

            const SizedBox(height: Constants.distance),

            // INFORMASI
            Padding(
              padding: const EdgeInsets.fromLTRB(Constants.padding,
                  Constants.padding, Constants.padding, Constants.padding - 10),
              child: Text(
                "Informasi Varietas",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            // HORIZONTAL VIEW
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: Constants.padding),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  const SizedBox(width: Constants.padding),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AmelonadoRoute()));
                    },
                    child: InfoTile(
                      title: "Varietas Amelonado",
                      image: Image.asset('assets/images/amelonado.jpg',
                          fit: BoxFit.cover),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AngoletaRoute()));
                    },
                    child: InfoTile(
                      title: "Varietas Angoleta",
                      image: Image.asset('assets/images/angoleta.jpg',
                          fit: BoxFit.cover),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GuianaRoute()));
                    },
                    child: InfoTile(
                      title: "Varietas Guiana",
                      image: Image.asset('assets/images/guiana.jpg',
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: Constants.padding),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
