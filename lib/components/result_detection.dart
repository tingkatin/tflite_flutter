import 'package:cocoa/helpers/constants.dart';
import 'package:flutter/material.dart';

class ResultDetection extends StatelessWidget {
  const ResultDetection(
      {super.key,
      required this.classification,
      required this.inferenceTime,
      required this.cpuUsage,
      required this.memoryUsage});
  final Map<String, double>? classification;
  final int? inferenceTime;
  final double cpuUsage;
  final double memoryUsage;

  @override
  Widget build(BuildContext context) {
    MapEntry<String, double>? prediction = classification!.entries.first;
    return Column(
      children: [
        Center(
          child: Text("Inferensi selesai dalam $inferenceTime ms",
              style: Theme.of(context).textTheme.bodySmall),
        ),
        const SizedBox(height: Constants.distance),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(Constants.padding),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onInverseSurface,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(Constants.borderRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${prediction.value.toStringAsFixed(0)}%',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                "${prediction.key.split("_")[0]} - ${prediction.key.split("_")[1]}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        const SizedBox(height: Constants.distance),
        Row(
          children: [
            // CPU USAGE
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(Constants.padding),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(Constants.borderRadius),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${cpuUsage.toStringAsFixed(2)} %",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      "CPU Usage",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black.withAlpha(155)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: Constants.distance),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(Constants.padding),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(Constants.borderRadius),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${memoryUsage.toStringAsFixed(1)} MB",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      "RAM Usage",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black.withAlpha(155)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: Constants.distance),
      ],
    );
  }
}
