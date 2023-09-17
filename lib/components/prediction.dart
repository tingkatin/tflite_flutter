import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Prediction extends StatelessWidget {
  const Prediction({super.key, required this.entry});

  final MapEntry<String, double> entry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      child: SfRadialGauge(
        enableLoadingAnimation: true,
        animationDuration: 700,
        axes: <RadialAxis>[
          RadialAxis(
              showLabels: false,
              showTicks: false,
              pointers: <GaugePointer>[
                RangePointer(
                    value: entry.value,
                    color: Theme.of(context).colorScheme.primary,
                    cornerStyle: CornerStyle.bothCurve)
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    angle: 90,
                    widget: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(
                        '${entry.value.toStringAsFixed(0)}%',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        entry.key.split("_")[0],
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        entry.key.split("_")[1],
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black.withAlpha(155)),
                      ),
                    ])),
              ])
        ],
      ),
    );
  }
}
