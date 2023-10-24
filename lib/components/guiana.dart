import 'package:flutter/material.dart';
import 'package:cocoa/components/inline_images.dart';
import 'package:cocoa/helpers/constants.dart';

class Guiana extends StatelessWidget {
  const Guiana({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "    Guiana adalah varietas kakao yang kurang dikenal dan endemik dari Guyana Prancis. Kakao Guiana berbeda dari pohon kakao lainnya dengan karakteristiknya seperti alur yang agak dalam dan permukaan yang kasar. Gambar (A) merupakan contoh Guiana mentah dan (B) merupakan Guiana matang.",
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: Constants.distance),
        InlineImages(
          image1: 'assets/images/guiana_unmature.jpg',
          image2: 'assets/images/guiana_mature.jpg',
        )
      ],
    );
  }
}
