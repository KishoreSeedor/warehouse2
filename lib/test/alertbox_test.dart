import 'package:flutter/material.dart';
import '../const/color.dart';

class AlertTest extends StatelessWidget {
  const AlertTest({super.key, required this.barcode});
  final String barcode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Center(
          child: TextButton(
              onPressed: () {
                // GlobalAlertBox().qualityChecker(
                //     context: context, barcode: barcode, userId: '');
              },
              child: Text("Enter")),
        )
      ]),
      backgroundColor: CustomColor.white,
    );
  }
}
// qualityChecker(context: context, barcode: barcode);