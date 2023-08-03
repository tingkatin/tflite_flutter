import 'package:cocoa/helpers/constants.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  const ActionButton({
    super.key,
    required this.icon,
    required this.text,
    required this.pickImage,
  });

  final Icon icon;
  final String text;
  final VoidCallback pickImage;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
        onPressed: widget.pickImage,
        style: FilledButton.styleFrom(
            padding: const EdgeInsets.all(Constants.padding),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constants.borderRadius))),
        child: Column(
          children: [
            widget.icon,
            const SizedBox(height: 5),
            Text(widget.text),
          ],
        ));
  }
}
