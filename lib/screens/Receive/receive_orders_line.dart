import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/screens/PutAway/utilites/empty_screen.dart';
import 'package:warehouse/screens/PutAway/utilites/error_screen.dart';
import 'package:warehouse/screens/PutAway/utilites/loading_screen.dart';
import 'package:warehouse/widgets/custom_alert_dialog.dart';
import '../../const/color.dart';
import '../../models/orders_line_model.dart';
import '../../models/recived_details_model.dart';
import '../../services/api/recive_api.dart';
import '../../services/barcode_scanner2.dart';
import '../home_page.dart';
import 'received_order_line2.dart';

List<OrderLine> globalorderLine = [];

class OrdersLinePage1 extends StatefulWidget {
  final String barcode;
  final String id;

  const OrdersLinePage1({super.key, required this.barcode, required this.id});

  @override
  State<OrdersLinePage1> createState() => _OrdersLinePage1State();
}

class _OrdersLinePage1State extends State<OrdersLinePage1> {
  List<RecieveAPI> stopCall = [];
  late Future<List<OrderLine>> quantity;
  late Future<List<OrderLine>>? filder;
  late Future<RecievedDetails?> particular;

  @override
  void initState() {
    stopCall;

    // particular =
    // RecieveAPI().particularOrders(context: context, domain: widget.barcode);
    // filder = Provider.of<RecieveAPI>(context, listen: false).orderLine(
    //     context: context, domain: widget.barcode, pickingId: widget.id);

    Provider.of<RecieveAPI>(context, listen: false)
        .orderLine(context: context, pickingId: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var data = true;

    List<int> quantityChecker = [];

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final recive = Provider.of<RecieveAPI>(context).findById(widget.id);
    final orderLine = Provider.of<RecieveAPI>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: CustomColor.darkwhite,
            leading: Padding(
              padding: EdgeInsets.only(left: width * 0.02),
              child: IconButton(
                icon: Image.asset(
                  "assets/images/recivedbox.png",
                  scale: 0.9,
                ),
                onPressed: () {},
              ),
            ),
            title: const Text(
              "Receive Order Lines",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              // FutureBuilder<List<OrderLine>>(
              //     future: Provider.of<RecieveAPI>(context, listen: false)
              //         .orderLine(
              //             context: context,
              //             domain: widget.barcode,
              //             pickingId: widget.id),
              //     builder: (context, snapshot) {
              //       switch (snapshot.connectionState) {
              //         case ConnectionState.waiting:
              //           return Container();
              //         case ConnectionState.done:
              //         default:
              //           if (snapshot.hasData) {
              //             print(
              //                 "row length--> ${int.parse(snapshot.data!.length.toString()).toString()}");
              //             return Center(
              //               child: Padding(
              //                 padding: EdgeInsets.only(right: width * 0.05),
              //                 child: Row(
              //                   // ignore: prefer_const_literals_to_create_immutables
              //                   children: [
              //                     // ignore: unrelated_type_equality_checks

              //                     Text(
              //                       int.parse(quantityChecker.length.toString())
              //                           .toString(),
              //                       style: const TextStyle(
              //                           color: CustomColor.blackcolor,
              //                           fontSize: 23,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                     Text(
              //                       "/${int.parse(snapshot.data!.length.toString()).toString()}",
              //                       style: TextStyle(
              //                           color: CustomColor.blackcolor,
              //                           fontSize: 23,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             );
              //           } else {
              //             return Container();
              //           }
              //       }
              //     })
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
                            recive.displayName,
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
                                recive.companyName,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
            const Divider(
              thickness: 3,
              color: CustomColor.yellow,
            ),
            orderLine.reciveLoading
                ? Flexible(
                    child: LoadingScreenPutAway(
                    title: "Loading...",
                  ))
                : orderLine.recicveErrorLoading
                    ? Flexible(
                        child: ErrorScreenPutAway(
                            title: orderLine.errorMessage.toString()),
                      )
                    : orderLine.reciveOrderLineData.isEmpty
                        ? Flexible(
                            child: EmptyScreenPutAway(title: 'No data found'))
                        : Flexible(
                            // child: FutureBuilder<List<OrderLine>>(
                            //     future: quantity,
                            //     builder: (context, snapshot) {
                            //       if (snapshot.hasData) {
                            // globalorderLine = snapshot.data!;
                            // print("snapLength ${snapshot.data!.length}");
                            child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              // print(snapshot.data!.length);
                              // print("global orderline + $globalorderLine");
                              // print(
                              //     "quantityDone+ ${snapshot.data![index].quantityDone.toString()}");
                              // print(
                              //     "productonquantity + ${snapshot.data![index].productOnQty.toString()}");

                              // if (snapshot.data![index].quantityDone.toString() ==
                              //     snapshot.data![index].productOnQty.toString()) {
                              //   quantityChecker += [1];
                              // }
                              // }
                              // print(
                              //     "quantityChecker + ${int.parse(quantityChecker.length.toString()).toString()}");
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.pop(context);
                                      setState(() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OrederLinePage2(
                                              barcode: widget.barcode,
                                              value: orderLine
                                                  .reciveOrderLineData[index],
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(17),
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: CustomColor.gray200,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.03),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    orderLine
                                                        .reciveOrderLineData[
                                                            index]
                                                        .productId,
                                                    style: const TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: CustomColor
                                                            .blackcolor2),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      vertical: height * 0.04,
                                                    ),
                                                    child: Text(
                                                      orderLine
                                                          .reciveOrderLineData[
                                                              index]
                                                          .productName,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: CustomColor
                                                              .blackcolor2),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      orderLine
                                                          .reciveOrderLineData[
                                                              index]
                                                          .quantityDone,
                                                      style: const TextStyle(
                                                          color: CustomColor
                                                              .blackcolor2,
                                                          fontSize: 23,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "/${orderLine.reciveOrderLineData[index].productOnQty}",
                                                      style: const TextStyle(
                                                          color: CustomColor
                                                              .blackcolor2,
                                                          fontSize: 23,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: height * 0.02,
                                                ),
                                                const Text(
                                                  "PCS",
                                                  style: TextStyle(
                                                      color: CustomColor
                                                          .blackcolor2,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.03,
                                          ),
                                          Container(
                                            height: height * 0.015,
                                            width: width * 0.05,
                                            decoration: BoxDecoration(
                                                color: int.parse(orderLine
                                                            .reciveOrderLineData[
                                                                index]
                                                            .quantityDone) ==
                                                        0
                                                    ? CustomColor.yellow
                                                    : int.parse(orderLine
                                                                .reciveOrderLineData[
                                                                    index]
                                                                .quantityDone) <
                                                            int.parse(orderLine
                                                                .reciveOrderLineData[
                                                                    index]
                                                                .productOnQty)
                                                        ? CustomColor
                                                            .orangecolor
                                                        : int.parse(orderLine.reciveOrderLineData[index].quantityDone) ==
                                                                int.parse(orderLine
                                                                    .reciveOrderLineData[
                                                                        index]
                                                                    .productOnQty)
                                                            ? CustomColor.greencolor
                                                            : CustomColor.yellow,
                                                borderRadius: BorderRadius.circular(3)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            itemCount: orderLine.reciveOrderLineData.length,
                            separatorBuilder:
                                (BuildContext context, int itemCount) {
                              return const Divider(
                                thickness: 3,
                                color: CustomColor.yellow,
                              );
                            },
                          )
                            //   } else {
                            //     return const Center(
                            //       child: CircularProgressIndicator(
                            //           color: CustomColor.yellow),
                            //     );
                            //   }
                            // }),
                            ),
          ]),
        ),
        //   } else {
        //     return const Center(
        //       child: CircularProgressIndicator(color: CustomColor.yellow),
        //     );
        //   }
        // }),
        backgroundColor: CustomColor.backgroundColor,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Expanded(
            //   flex: 3,
            //   child: Padding(
            //     padding:
            //         EdgeInsets.only(left: width * 0.07, right: width * 0.3),
            //     child: SizedBox(
            //       height: height * 0.04,
            //       width: width * 0.01,
            //       child: FloatingActionButton.extended(
            //         heroTag: null,
            //         onPressed: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) =>
            //                       BarcodeScanner2(barcode: widget.barcode)));
            //         },
            //         backgroundColor: CustomColor.yellow,
            //         foregroundColor: Colors.black,
            //         label: Column(
            //           children: [
            //             Image.asset(
            //               "assets/images/scanner.png",
            //               width: width * 0.09,
            //               height: height * 0.06,
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.all(10),
              height: height * 0.04,
              child: FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {
                  var data = "";
                  for (var i = 0;
                      i < orderLine.reciveOrderLineData.length;
                      i++) {
                    if (orderLine.reciveOrderLineData[i].doneQuantity == 0.0) {
                      data = "val";
                    }
                  }
                  if (data != "val") {
                    RecieveAPI().receivedFinalValitation(
                        context: context, userId: widget.id);
                  } else {
                    MyCustomAlertDialog().showCustomAlertdialog(
                        context: context,
                        title: "Note",
                        subtitle: "Ensure whether all the products are quantity/quality checked before validating",
                        onTapOkButt: () {
                          Navigator.of(context).pop();
                        });
                  }
                },
                backgroundColor: CustomColor.yellow,
                foregroundColor: Colors.black,
                label: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/validate.png",
                          scale: 30,
                        ),
                        const Text(
                          "Validate",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Padding(
            //     padding: EdgeInsets.only(left: width * 0.08),
            //     child: FloatingActionButton(
            //       heroTag: null,
            //       onPressed: () {},
            //       backgroundColor: CustomColor.darkwhite,
            //       foregroundColor: Colors.black,
            //       child: Column(
            //         children: [
            //           InkWell(
            //             onTap: (() {
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => const MyHomePage()));
            //             }),
            //             child: Padding(
            //               padding: EdgeInsets.only(left: width * 0.02),
            //               child: Image.asset(
            //                 "assets/images/Category.png",
            //                 width: width * 0.08,
            //                 height: height * 0.05,
            //               ),
            //             ),
            //           ),
            //           const Text(
            //             "Menu",
            //             style: TextStyle(fontSize: 8),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

OrderLine? globallineDateTwo;
