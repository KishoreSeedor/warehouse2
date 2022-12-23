import 'package:flutter/material.dart';
import 'package:warehouse/screens/PickOrder/scanner_pick.dart';

import '../../const/color.dart';
import '../../widgets/menu_widget.dart';
import '../home_page.dart';

class PickOrderBottom extends StatefulWidget {
  String? barcode;
  PickOrderBottom({super.key, required this.barcode});

  @override
  State<PickOrderBottom> createState() => _PickOrderBottomState();
}

class _PickOrderBottomState extends State<PickOrderBottom> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        // Padding(
        //   padding: EdgeInsets.only(left: width * 0.09),
        //   child: SizedBox(
        //     height: height * 0.04,
        //     child: FloatingActionButton.extended(
        //       heroTag: null,
        //       onPressed: () {
        //         Navigator.of(context).push(MaterialPageRoute(
        //             builder: (context) => PickOrderScanner(
        //                   scannerValue: widget.barcode,
        //                 )));
        //       },
        //       backgroundColor: CustomColor.yellow,
        //       foregroundColor: Colors.black,
        //       label: Column(
        //         children: [
        //           Image.asset(
        //             "assets/images/scanner.png",
        //             width: width * 0.09,
        //             height: height * 0.06,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   width: width * 0.55,
        // ),
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

class PickOrderLineBottom extends StatefulWidget {
  String? barcode;
  PickOrderLineBottom({super.key, required this.barcode});

  @override
  State<PickOrderLineBottom> createState() => _PickOrderLineBottomState();
}

class _PickOrderLineBottomState extends State<PickOrderLineBottom> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    PageRouteBuilder opaquePage(Widget page) => PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) => page,
        );
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
                    builder: (context) => PickOrderLineScanner(
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
            Navigator.push(context, opaquePage(const ReceivedMenu()));
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
