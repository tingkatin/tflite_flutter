import 'package:cocoa/helpers/constants.dart';
import 'package:cocoa/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagePreview extends StatefulWidget {
  const ImagePreview({super.key});

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var image = appState.imagePreview;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      height: 300,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        child: image == null
            ? Center(child: Text("Tidak ada gambar"))
            : Image.file(image, fit: BoxFit.cover),
      ),
    );
  }
}
