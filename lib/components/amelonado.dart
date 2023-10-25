import 'package:cocoa/components/inline_images.dart';
import 'package:cocoa/helpers/constants.dart';
import 'package:flutter/material.dart';

class Amelonado extends StatelessWidget {
  const Amelonado({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Kakao jenis ini memiliki bentuk seperti melon yang memanjang. Oleh karena itu, orang-orang Spanyol menyebutnya “Amelonado” yang artinya berbentuk melon. Amelonado memiliki cangkang buah yang tebal dan halus, dengan sedikit kutil. Amelonado juga memiliki alur yang dangkal dan ujung yang bulat. Amelonado merupakan turunan varietas Forastero. Gambar (A) adalah Amelonado mentah dan (B) adalah Amelonado matang.",
          textAlign: TextAlign.start,
        ),
        SizedBox(height: Constants.distance),
        InlineImages(
          image1: 'assets/images/amelonado_unmature.jpg',
          image2: 'assets/images/amelonado_mature.jpg',
        )
      ],
    );
  }
}
