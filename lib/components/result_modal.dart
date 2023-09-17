import 'package:cocoa/components/result.dart';
import 'package:cocoa/helpers/constants.dart';
import 'package:flutter/material.dart';

class ResultModal extends StatelessWidget {
  const ResultModal({super.key, required this.processImage});

  final Future<Map<String, dynamic>?>? processImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(Constants.padding),
        shrinkWrap: true,
        children: [
          FutureBuilder(
              future: processImage,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var classification = snapshot.data!['classification'];
                  var inferenceTime = snapshot.data!['inferenceTime'];

                  // Data Empty
                  if (classification!.isEmpty) {
                    return const SizedBox(
                        height: 400,
                        child: Center(child: Text("Objek tidak dikenali")));
                  }

                  // Data Not Empty
                  return Result(
                      classification: classification,
                      inferenceTime: inferenceTime);

                  // If ERROR
                } else if (snapshot.hasError) {
                  return const SizedBox(
                      height: 400, child: Center(child: Text("Error")));

                  // IS LOADING OR NULL
                } else {
                  return const SizedBox(
                      height: 400,
                      child: Center(child: CircularProgressIndicator()));
                }
              }),
        ],
      ),
    );
  }
}
