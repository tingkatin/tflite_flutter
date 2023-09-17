import 'package:cocoa/components/guiana.dart';
import 'package:cocoa/helpers/constants.dart';
import 'package:flutter/material.dart';

class GuianaRoute extends StatelessWidget {
  const GuianaRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Varietas Guiana',
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
            Guiana(),
          ],
        ),
      )),
    );
  }
}
