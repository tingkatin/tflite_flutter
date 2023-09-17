import 'package:cocoa/components/angoleta.dart';
import 'package:cocoa/helpers/constants.dart';
import 'package:flutter/material.dart';

class AngoletaRoute extends StatelessWidget {
  const AngoletaRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Varietas Angoleta',
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
            Angoleta(),
          ],
        ),
      )),
    );
  }
}
