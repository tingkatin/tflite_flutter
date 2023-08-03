import 'package:cocoa/components/prediction.dart';
import 'package:cocoa/components/prediction_tile.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result({super.key, required this.classification});
  final Map<String, double>? classification;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...?classification?.entries
            .take(1)
            .map((entry) => Prediction(entry: entry)),
        ...?classification?.entries.skip(1).map(
              (entry) => PredictionTile(entry: entry),
            )
      ],
    );
  }
}
