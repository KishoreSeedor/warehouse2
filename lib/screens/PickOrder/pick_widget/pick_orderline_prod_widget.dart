import 'package:flutter/material.dart';
import 'package:warehouse/screens/PickOrder/pick_model/pick_order_lines_model.dart';
import 'package:warehouse/screens/PickOrder/pick_ui_design/pick_prod_loc_scanner.dart';

import '../../../const/color.dart';
import '../../PutAway/put_away_widget/custom_putaway_button.dart';
import '../scanSerial.dart';

class PickProductOrderLineWidget extends StatefulWidget {
  final List<PickLinesModel> pickLinedata;
  final String locationName;
  final String locationId;
  const PickProductOrderLineWidget(
      {super.key,
      required this.pickLinedata,
      required this.locationName,
      required this.locationId});

  @override
  State<PickProductOrderLineWidget> createState() =>
      _PickProductOrderLineWidgetState();
}

class _PickProductOrderLineWidgetState
    extends State<PickProductOrderLineWidget> {
  PageRouteBuilder opaquePage(Widget page) => PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => page,
      );
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(flex: 3, child: Text('Location : ${widget.locationName}')),
            Expanded(
              flex: 2,
              child: PutAwayCustomButton(
                  title: "Scan Location",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => PickProdLocationScanner(
                              locationId: widget.locationId,
                            )));
                  }),
            ),
          ],
        ),
        ...List.generate(widget.pickLinedata.length, (index) {
          return GestureDetector(
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(
                context,
                opaquePage(ScanSerialBox(
                  pickId: widget.pickLinedata[index].productId,
                  productLocation: widget.pickLinedata[index].locationDest,
                )),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(17),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: CustomColor.gray200,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(left: width * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.pickLinedata[index].locationDestinationName
                                .toString(),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: CustomColor.blackcolor2),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.04,
                            ),
                            child: Text(
                              widget.pickLinedata[index].productname.toString(),
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColor.blackcolor2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Expanded(
                  //   flex: 17,
                  //   child: Container(
                  //     height: height * 0.15,
                  //     width: width * 0.001,
                  //     decoration: BoxDecoration(
                  //         border: Border.all(
                  //             color: CustomColor
                  //                 .blackcolor,
                  //             width: width *
                  //                 0.004),
                  //         borderRadius:
                  //             BorderRadius
                  //                 .circular(
                  //                     10),
                  //         color: CustomColor
                  //             .backgroundColor),
                  //     child: Image.asset(
                  //       "assets/images/speaker.png",
                  //       fit: BoxFit.contain,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: width * 0.2,
                  // ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Text(
                            //   widget.pickLinedata[index].quantityDone
                            //       .toString(),
                            //   style: TextStyle(
                            //       color: CustomColor.blackcolor2,
                            //       fontSize: 23,
                            //       fontWeight: FontWeight.bold),
                            // ),
                            Text(
                              "${widget.pickLinedata[index].quantity.toString()}",
                              style: TextStyle(
                                  color: CustomColor.blackcolor2,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        const Text(
                          "PCS",
                          style: TextStyle(
                              color: CustomColor.blackcolor2,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  // Container(
                  //   height: height * 0.015,
                  //   width: width * 0.05,
                  //   decoration: BoxDecoration(
                  //       color: int.parse(
                  //                 widget.pickLinedata[index].productOnQty
                  //                     .toString(),
                  //               ) ==
                  //               0
                  //           ? CustomColor.yellow
                  //           : int.parse(widget.pickLinedata[index].quantityDone
                  //                       .toString()) <
                  //                   int.parse(widget
                  //                       .pickLinedata[index].productOnQty
                  //                       .toString())
                  //               ? CustomColor.orangecolor
                  //               : int.parse(widget
                  //                           .pickLinedata[index].quantityDone
                  //                           .toString()) ==
                  //                       int.parse(widget
                  //                           .pickLinedata[index].productOnQty
                  //                           .toString())
                  //                   ? CustomColor.greencolor
                  //                   : CustomColor.yellow,
                  //       borderRadius: BorderRadius.circular(3)),
                  // )
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
