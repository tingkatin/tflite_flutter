import 'package:cocoa/helpers/constants.dart';
import 'package:flutter/material.dart';

class InlineImages extends StatelessWidget {
  const InlineImages({super.key, required this.image1, required this.image2});

  final String image1;
  final String image2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Constants.borderRadius),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                width: double.infinity,
                height: 200,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(Constants.borderRadius),
                    child: Image.asset(image1, fit: BoxFit.cover)),
              ),
              Text('A',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(width: Constants.distance),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Constants.borderRadius),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                width: double.infinity,
                height: 200,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(Constants.borderRadius),
                    child: Image.asset(image2, fit: BoxFit.cover)),
              ),
              Text('B',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}
