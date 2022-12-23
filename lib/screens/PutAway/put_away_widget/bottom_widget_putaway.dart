import 'package:flutter/material.dart';

import 'package:warehouse/services/scanner/put_away_orders_scanner.dart';

import '../../../const/color.dart';
import '../../home_page.dart';

class BottomWidget2 extends StatefulWidget {
  String? barcode;

  BottomWidget2({
    super.key,
    required this.barcode,
  });

  @override
  State<BottomWidget2> createState() => _BottomWidget2State();
}

class _BottomWidget2State extends State<BottomWidget2> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: width * 0.09),
          child: SizedBox(
            height: height * 0.04,
            child: FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PutAwayOrdersScanner(scannerValue: widget.barcode)));
              },
              backgroundColor: CustomColor.yellow,
              foregroundColor: Colors.black,
              label: Column(
                children: [
                  Image.asset(
                    "assets/images/scanner.png",
                    width: width * 0.09,
                    height: height * 0.06,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: width * 0.55,
        ),
        FloatingActionButton(
          heroTag: null,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyHomePage()));
          },
          backgroundColor: CustomColor.darkwhite,
          foregroundColor: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.02),
                child: Image.asset(
                  "assets/images/Category.png",
                  width: width * 0.08,
                  height: height * 0.05,
                ),
              ),
              const Text(
                "Menu",
                style: TextStyle(fontSize: 8),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class PutAwayOrderLineScannerCamera extends StatefulWidget {
  String? barcode;

  PutAwayOrderLineScannerCamera({
    super.key,
    required this.barcode,
  });

  @override
  State<PutAwayOrderLineScannerCamera> createState() =>
      _PutAwayOrderLineScannerCameraState();
}

class _PutAwayOrderLineScannerCameraState
    extends State<PutAwayOrderLineScannerCamera> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: width * 0.09),
          child: SizedBox(
            height: height * 0.04,
            child: FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PutAwayOrderLineScanner(
                          scannerValue: widget.barcode,
                        )));
              },
              backgroundColor: CustomColor.yellow,
              foregroundColor: Colors.black,
              label: Column(
                children: [
                  Image.asset(
                    "assets/images/scanner.png",
                    width: width * 0.09,
                    height: height * 0.06,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: width * 0.55,
        ),
        FloatingActionButton(
          heroTag: null,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyHomePage()));
          },
          backgroundColor: CustomColor.darkwhite,
          foregroundColor: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.02),
                child: Image.asset(
                  "assets/images/Category.png",
                  width: width * 0.08,
                  height: height * 0.05,
                ),
              ),
              const Text(
                "Menu",
                style: TextStyle(fontSize: 8),
              )
            ],
          ),
        ),
      ],
    );
  }
}
