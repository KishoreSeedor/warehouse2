import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/screens/PutAway/put_away_model/putaway_orderline_model.dart';
import 'package:warehouse/screens/PutAway/put_away_provider/put_away_orderline_provider.dart';
import 'package:warehouse/screens/PutAway/put_away_provider/put_away_provider.dart';
import 'package:warehouse/screens/PutAway/put_away_ui_design/scan_location_screen.dart';
import 'package:warehouse/screens/PutAway/put_away_widget/custom_putaway_button.dart';
import 'package:warehouse/screens/PutAway/utilites/empty_screen.dart';
import 'package:warehouse/screens/PutAway/utilites/error_screen.dart';
import 'package:warehouse/screens/PutAway/utilites/loading_screen.dart';
import 'package:warehouse/screens/PutAway/utilites/putaway_camra_scan.dart';

import '../../../const/color.dart';

class PutAwayOrdersLineScreen extends StatefulWidget {
  final String id;
  final String name;
  const PutAwayOrdersLineScreen(
      {super.key, required this.id, required this.name});

  @override
  State<PutAwayOrdersLineScreen> createState() =>
      _PutAwayOrdersLineScreenState();
}

class _PutAwayOrdersLineScreenState extends State<PutAwayOrdersLineScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PutAwayOrderLineProvid>(context, listen: false)
        .getAllorderLineProduct(context: context, id: widget.id);
  }

  String? barcode;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final orderLine = Provider.of<PutAwayOrderLineProvid>(context);
    final data = Provider.of<PutAwayProvider>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: CustomColor.darkwhite,
            leading: Padding(
              padding: EdgeInsets.only(left: width * 0.02),
              child: IconButton(
                icon: Image.asset(
                  "assets/images/putawaylogo.png",
                  scale: 0.9,
                ),
                onPressed: () {},
              ),
            ),
            title: const Text(
              "Put Away Order Lines",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              Center(
                  //   child: Padding(
                  //     padding: EdgeInsets.only(right: width * 0.05),
                  //     child: Row(
                  //       // ignore: prefer_const_literals_to_create_immutables
                  //       children: [
                  //         // ignore: unrelated_type_equality_checks

                  //         Text(
                  //           "1",
                  //           style: const TextStyle(
                  //               color: CustomColor.blackcolor,
                  //               fontSize: 23,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //         Text(
                  //           "/2",
                  //           style: TextStyle(
                  //               color: CustomColor.blackcolor,
                  //               fontSize: 23,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  ),
            ]),
        body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.04, left: width * 0.06),
              child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Order No :",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            widget.id,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.01),
                        child: Row(
                          children: [
                            const Text(
                              "Sender    :",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                widget.name,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: width,
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.yellow)),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) =>
                                        PutawayScanLocationScreen()));
                              },
                              child: Text(
                                'Scan Location',
                                style: TextStyle(color: Colors.black),
                              ))),
                      //  Container(
                      //   width: width,
                      //   alignment: Alignment.centerRight,
                      //    child: PutAwayCustomButton(
                      //        title: "Scan Location",
                      //        onTap: () {
                      //          Navigator.of(context).push(MaterialPageRoute(
                      //              builder: (ctx) => PutAwayBarCodeScanner(
                      //                    scanValue: 'Location',
                      //                  )));
                      //        }),
                      //  ),
                    ]),
              ),
            ),
            const Divider(
              thickness: 3,
              color: CustomColor.yellow,
            ),
            Expanded(
              child: orderLine.orderlineLoading == true
                  ? const Center(
                      child:
                          CircularProgressIndicator(color: CustomColor.yellow),
                    )
                  : orderLine.orderlineErrorLoading == true
                      ? ErrorScreenPutAway(
                          title: orderLine.orderlIneErrorMessage.toString())
                      : orderLine.orderlineArrangement.isEmpty
                          ? EmptyScreenPutAway(title: 'No Product Found')
                          : ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return PutAwayOrderLineProductWidget(
                                  id: widget.id,
                                  orderlineData:
                                      orderLine.orderlineArrangement[index],
                                  destination: orderLine.locationDestination
                                      .toSet()
                                      .toList()[index],
                                  locationId: orderLine.setLocationData[index],
                                );
                              },
                              itemCount: orderLine.orderlineArrangement.length,
                              separatorBuilder:
                                  (BuildContext context, int itemCount) {
                                return const Divider(
                                  thickness: 3,
                                  color: CustomColor.yellow,
                                );
                              },
                            ),
            ),
          ]),
        ),
        backgroundColor: CustomColor.backgroundColor,
        floatingActionButton: PutAwayCustomButton(
            title: 'validate',
            onTap: () {
              data.validateApi(context: context, lineId: widget.id);
            }));
  }
}

class PutAwayOrderLineProductWidget extends StatefulWidget {
  final List<PutawayOrderLineModel> orderlineData;
  final String destination;
  final String locationId;
  final String id;

  const PutAwayOrderLineProductWidget(
      {Key? key,
      required this.orderlineData,
      required this.destination,
      required this.locationId,
      required this.id})
      : super(key: key);

  @override
  State<PutAwayOrderLineProductWidget> createState() =>
      _PutAwayOrderLineProductWidgetState();
}

class _PutAwayOrderLineProductWidgetState
    extends State<PutAwayOrderLineProductWidget> {
  double totalCBM = 0.0;
  int quantity = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < widget.orderlineData.length; i++) {
      double calculation = widget.orderlineData[i].prodBreath *
          widget.orderlineData[i].prodHeight *
          widget.orderlineData[i].prodlength;
      print(
          "${widget.orderlineData[i].prodBreath} ---  ${widget.orderlineData[i].prodHeight} ----  ${widget.orderlineData[i].prodlength}");
      totalCBM += double.parse(calculation.toString()) *
          double.parse(widget.orderlineData[i].quantity);

      quantity += double.parse(widget.orderlineData[i].quantity).floor();
    }
    print(totalCBM.toString() + '------->>> total CBM');
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 3,
                  child: Text(
                    'Pallet : ${widget.destination}',
                    textAlign: TextAlign.left,
                  )),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.yellow)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Pallet Name : ${widget.destination}"),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Total CBM : ${double.parse(totalCBM.toString()).toStringAsFixed(3)}"),
                SizedBox(
                  height: 10,
                ),
                Text("Total Product Qty : $quantity")
              ],
            ),
          )
          // ...List.generate(
          //   widget.orderlineData.length,
          //   (index) => GestureDetector(
          //     onTap: () {},
          //     child: Container(
          //       padding: const EdgeInsets.all(17),
          //       margin: const EdgeInsets.all(10),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20),
          //         color: CustomColor.gray200,
          //       ),
          //       child: Row(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Expanded(
          //             flex: 2,
          //             child: Padding(
          //               padding: EdgeInsets.only(left: width * 0.03),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     widget.orderlineData[index].palletDestinationName,
          //                     style: const TextStyle(
          //                         fontSize: 24,
          //                         fontWeight: FontWeight.bold,
          //                         color: CustomColor.blackcolor2),
          //                   ),
          //                   Padding(
          //                     padding: EdgeInsets.symmetric(
          //                       vertical: height * 0.04,
          //                     ),
          //                     child: Text(
          //                       widget.orderlineData[index].productname,
          //                       overflow: TextOverflow.fade,
          //                       textAlign: TextAlign.start,
          //                       style: const TextStyle(
          //                           fontSize: 15,
          //                           fontWeight: FontWeight.w500,
          //                           color: CustomColor.blackcolor2),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //           Expanded(
          //             flex: 1,
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.end,
          //               mainAxisAlignment: MainAxisAlignment.end,
          //               children: [
          //                 Row(
          //                   crossAxisAlignment: CrossAxisAlignment.end,
          //                   mainAxisAlignment: MainAxisAlignment.end,
          //                   children: [
          //                     Text(
          //                       widget.orderlineData[index].quantity,
          //                       style: const TextStyle(
          //                           color: CustomColor.blackcolor2,
          //                           fontSize: 23,
          //                           fontWeight: FontWeight.bold),
          //                     ),
          //                     // Text(
          //                     //   "3",
          //                     //   style: const TextStyle(
          //                     //       color: CustomColor.blackcolor2,
          //                     //       fontSize: 23,
          //                     //       fontWeight: FontWeight.bold),
          //                     // ),
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: height * 0.02,
          //                 ),
          //                 const Text(
          //                   "PCS",
          //                   style: TextStyle(
          //                       color: CustomColor.blackcolor2,
          //                       fontSize: 20,
          //                       fontWeight: FontWeight.w500),
          //                 )
          //               ],
          //             ),
          //           ),
          //           SizedBox(
          //             width: width * 0.03,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
