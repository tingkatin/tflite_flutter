import 'package:cocoa/helpers/constants.dart';
import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({super.key, required this.title, required this.image});

  final Image image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadius)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Constants.borderRadius),
                color: Theme.of(context).colorScheme.surfaceVariant,
              ),
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Constants.borderRadius),
                child: image,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Constants.padding),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
