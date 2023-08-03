import 'package:cocoa/helpers/constants.dart';
import 'package:flutter/material.dart';

class PredictionTile extends StatelessWidget {
  const PredictionTile({super.key, required this.entry});

  final MapEntry<String, double> entry;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius)),
      child: Padding(
        padding: const EdgeInsets.all(Constants.padding - 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              entry.key,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            Text(
              '${entry.value.toStringAsFixed(0)}%',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            )
          ],
        ),
      ),
    );
  }
}
