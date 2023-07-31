import 'package:cocoa/helpers/constants.dart';
import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius)),
      child: Padding(
        padding: const EdgeInsets.all(Constants.padding - 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), Icon(Icons.arrow_forward_ios_rounded)],
        ),
      ),
    );
  }
}
