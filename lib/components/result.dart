import 'package:cocoa/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var classification = appState.classification;

    return Column(
      children: [
        ...classification!.entries.map((entry) => Text(entry.value.toString()))
      ],
    );
  }
}
