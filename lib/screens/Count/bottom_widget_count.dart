import 'package:flutter/material.dart';
import 'package:warehouse/screens/Count/scanner_count.dart';
import '../../const/color.dart';
import '../home_page.dart';

class BottomCountOrder extends StatefulWidget {
  String? barcode;
  BottomCountOrder({super.key, required this.barcode});

  @override
  State<BottomCountOrder> createState() => _BottomCountOrderState();
}

class _BottomCountOrderState extends State<BottomCountOrder> {
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
                    builder: (context) => CountOrderScanner(
                          barcode: widget.barcode,
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

class BottomCountOrderLine extends StatefulWidget {
  String? barcode;
  BottomCountOrderLine({super.key, required this.barcode});

  @override
  State<BottomCountOrderLine> createState() => _BottomCountOrderLineState();
}

class _BottomCountOrderLineState extends State<BottomCountOrderLine> {
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
                    builder: (context) => CountOrderLineScanner(
                          barcode: widget.barcode,
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
