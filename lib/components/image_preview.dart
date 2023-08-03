import 'dart:io';

import 'package:cocoa/helpers/constants.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  const ImagePreview({super.key, required this.image});

  final File? image;

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      height: 300,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        child: widget.image == null
            ? const Center(child: Text("Tidak ada gambar"))
            : Image.file(widget.image!, fit: BoxFit.cover),
      ),
    );
  }
}
