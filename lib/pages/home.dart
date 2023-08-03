import 'dart:io';

import 'package:cocoa/components/action_button.dart';
import 'package:cocoa/components/image_preview.dart';
import 'package:cocoa/components/info_tile.dart';
import 'package:cocoa/components/result_modal.dart';
import 'package:cocoa/helpers/constants.dart';
import 'package:cocoa/helpers/process_result.dart';
import 'package:cocoa/lib/tflite/image_classification_helper.dart';
import 'package:flutter/material.dart';
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

  void _initializeState() {
    imageClassificationHelper = ImageClassificationHelper();
    imageClassificationHelper!.initHelper();
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
            ResultModal(processImage: processImage(imagePreview)));

    if (pickedImage == null) {
      // Dismiss the modal when the image picking is canceled
      Navigator.pop(context);
      return;
    }

    setState(() {
      imagePreview = File(pickedImage.path);
    });
  }

  Future<Map<String, double>?>? processImage(File? imagePreview) async {
    if (imagePreview != null) {
      var imageData = imagePreview.readAsBytesSync();
      var image = img.decodeImage(imageData);
      Map<String, double>? classification =
          await imageClassificationHelper?.inferenceImage(image!);

      var processed = processOutput(classification);
      return processed;
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
            // INFORMASI
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
                  InfoTile(
                    title: "Varietas Criollo",
                    image: Image.asset('assets/images/cocoa.jpg',
                        fit: BoxFit.cover),
                  ),
                  InfoTile(
                    title: "Varietas Forastero",
                    image: Image.asset('assets/images/forastero.jpg',
                        fit: BoxFit.cover),
                  ),
                  InfoTile(
                    title: "Varietas Trinitario",
                    image: Image.asset('assets/images/trinitario.jpg',
                        fit: BoxFit.cover),
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
