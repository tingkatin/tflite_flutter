import 'package:cocoa/helpers/constants.dart';
import 'package:cocoa/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ActionType {
  camera,
  gallery,
}

class ActionButton extends StatefulWidget {
  const ActionButton(
      {super.key, required this.icon, required this.text, required this.type});

  final Icon icon;
  final String text;
  final ActionType type;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    void setActionType() async {
      if (widget.type == ActionType.camera) {
        appState.pickImageFromCamera();
      } else {
        appState.pickImageFromGallery();
      }
    }

    return FilledButton.tonal(
        onPressed: () async => setActionType(),
        style: TextButton.styleFrom(
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
