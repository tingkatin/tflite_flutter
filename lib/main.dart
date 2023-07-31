import 'dart:io';
import 'package:cocoa/lib/tflite/image_classification_helper.dart';
import 'package:cocoa/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light, seedColor: Colors.teal),
  textTheme: GoogleFonts.latoTextTheme().copyWith(
    displayLarge: GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      fontSize: 57,
      height: 64 / 57,
      letterSpacing: -0.25,
    ),
    displayMedium: GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      fontSize: 45,
      height: 52 / 45,
    ),
    displaySmall: GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      fontSize: 36,
      height: 44 / 36,
    ),
    headlineLarge: GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      fontSize: 32,
      height: 40 / 32,
    ),
    headlineMedium: GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      fontSize: 28,
      height: 36 / 28,
    ),
    headlineSmall: GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      fontSize: 24,
      height: 32 / 24,
    ),
    titleLarge: GoogleFonts.lato(
      fontWeight: FontWeight.w700,
      fontSize: 22,
      height: 28 / 22,
    ),
    titleMedium: GoogleFonts.lato(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.1,
    ),
    titleSmall: GoogleFonts.lato(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
    ),
    labelLarge: GoogleFonts.lato(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      height: 20 / 14,
    ),
    labelMedium: GoogleFonts.lato(
      fontWeight: FontWeight.w700,
      fontSize: 12,
      height: 16 / 12,
    ),
    labelSmall: GoogleFonts.lato(
      fontWeight: FontWeight.w700,
      fontSize: 11,
      height: 16 / 11,
    ),
    bodyLarge: GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 24 / 16,
    ),
    bodyMedium: GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 20 / 14,
    ),
    bodySmall: GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 16 / 12,
    ),
  ),
  useMaterial3: true,
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Cocoadetectinator',
        theme: theme,
        home: Home(),
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  File? imagePreview;
  ImageClassificationHelper? imageClassificationHelper;
  ImagePicker imagePicker = ImagePicker();
  Map<String, double>? classification;

  AppState() {
    _initializeState();
  }

  void _initializeState() {
    imageClassificationHelper = ImageClassificationHelper();
    imageClassificationHelper!.initHelper();
  }

  void pickImageFromCamera() async {
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage == null) {
      return;
    }

    imagePreview = File(pickedImage.path);
    var imageData = File(pickedImage.path).readAsBytesSync();
    var image = img.decodeImage(imageData);
    classification = await imageClassificationHelper?.inferenceImage(image!);
    print(classification);
    notifyListeners();
  }

  void pickImageFromGallery() async {
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) {
      return;
    }

    imagePreview = File(pickedImage.path);
    notifyListeners();
  }
}
