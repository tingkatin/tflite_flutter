import 'package:cocoa/components/action_button.dart';
import 'package:cocoa/components/image_preview.dart';
import 'package:cocoa/components/info_tile.dart';
import 'package:cocoa/components/result.dart';
import 'package:cocoa/helpers/constants.dart';
import 'package:cocoa/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Constants.padding),
          child: ListView(
            children: [
              const ImagePreview(),
              const SizedBox(height: Constants.distance),
              const Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ActionButton(
                        icon: Icon(Icons.camera_alt),
                        text: "Ambil Foto",
                        type: ActionType.camera),
                  ),
                  SizedBox(width: Constants.distance),
                  Expanded(
                    flex: 1,
                    child: ActionButton(
                        icon: Icon(Icons.photo),
                        text: "Buka Galeri",
                        type: ActionType.gallery),
                  ),
                ],
              ),
              const SizedBox(height: Constants.distance),
              Container(
                padding: EdgeInsets.all(Constants.padding),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(Constants.borderRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline_rounded,
                            color: Theme.of(context).colorScheme.outline),
                        SizedBox(width: 5),
                        Text("Informasi Varietas",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w900,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                      ],
                    ),
                    SizedBox(height: Constants.distance),
                    InfoTile(title: "Kakao Criollo"),
                    InfoTile(title: "Kakao Forastero"),
                    InfoTile(title: "Kakao Trinitario"),
                  ],
                ),
              ),
              if (appState.classification != null) const Result()
            ],
          ),
        ),
      ),
    );
  }
}
