import 'package:cocoa/components/inline_images.dart';
import 'package:cocoa/helpers/constants.dart';
import 'package:flutter/material.dart';

class Angoleta extends StatelessWidget {
  const Angoleta({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "    Angoleta memiliki alur di endosperma berwarna ungu muda dan memiliki kualitas superior. Bentuk Angoleta hampir mirip dengan varietas Criollo dengan permukaan yang sangat kasar, tanpa leher botol denga bentuk runcing memanjang. Varietas ini merupakan turunan Trinitario, persilangan antara Criollo dan Forastero dan banyak ditanam di Indonesia. Gambar (A) merupakan contoh Angoleta mentah dan (B) merupakan Angoleta matang.",
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: Constants.distance),
        InlineImages(
          image1: 'assets/images/angoleta_unmature.jpg',
          image2: 'assets/images/angoleta_mature.jpg',
        )
      ],
    );
  }
}
