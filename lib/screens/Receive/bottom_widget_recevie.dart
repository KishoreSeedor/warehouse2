import 'package:flutter/material.dart';
import '../../const/color.dart';
import '../../services/api/recive_api.dart';
import '../../services/bar_code_scaner.dart';
import '../../widgets/menu_widget.dart';
import '../home_page.dart';

class BottomWidgets extends StatelessWidget {
  final double width;
  final double height;
  final String barcode;
  final String userId;

  BottomWidgets({
    Key? key,
    required this.width,
    required this.height,
    required this.barcode,
    required this.userId,
  }) : super(key: key);

  PageRouteBuilder opaquePage(Widget page) => PageRouteBuilder(
      opaque: false, pageBuilder: (BuildContext contex, _, __) => page);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width * 0.1, right: width * 0.45),
          child: SizedBox(
            height: height * 0.04,
            width: width * 0.2,
            child: FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BarcodeScannerPage(
                          id: userId,
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
        // Expanded(
        //   flex: 1,
        //   child: FloatingActionButton(
        //     heroTag: null,
        //     onPressed: () {
        //       Navigator.push(context, opaquePage(const ReceivedMenu()));
        //     },
        //     backgroundColor: CustomColor.darkwhite,
        //     foregroundColor: Colors.black,
        //     child: Column(
        //       children: [
        //         Padding(
        //           padding: EdgeInsets.only(left: width * 0.02),
        //           child: Image.asset(
        //             "assets/images/Category.png",
        //             width: width * 0.08,
        //             height: height * 0.05,
        //           ),
        //         ),
        //         const Text(
        //           "Menu",
        //           style: TextStyle(fontSize: 8),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
// static const darkword = Color.fromARGB(255, 123, 123, 123);