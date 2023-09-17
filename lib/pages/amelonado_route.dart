import 'package:cocoa/components/amelonado.dart';
import 'package:cocoa/helpers/constants.dart';
import 'package:flutter/material.dart';

class AmelonadoRoute extends StatelessWidget {
  const AmelonadoRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Varietas Amelonado',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(Constants.padding),
        child: ListView(
          children: [
            Amelonado(),
          ],
        ),
      )),
    );
  }
}
