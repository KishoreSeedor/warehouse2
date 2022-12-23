import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/screens/PickOrder/bottom_widget_pick.dart';
import 'package:warehouse/screens/PickOrder/pick_order_provider/pick_order_provider.dart';
import 'package:warehouse/screens/PickOrder/scanSerial.dart';
import 'package:warehouse/screens/PutAway/utilites/empty_screen.dart';
import 'package:warehouse/screens/PutAway/utilites/error_screen.dart';
import 'package:warehouse/screens/PutAway/utilites/loading_screen.dart';

import '../../../const/color.dart';
import '../pick_order_provider/pickorder_line_provider.dart';
import '../pick_widget/pick_orderline_prod_widget.dart';

class PickOrderLinesScreen extends StatefulWidget {
  String pickingId;

  String sender;
  PickOrderLinesScreen(
      {super.key, required this.pickingId, required this.sender});

  @override
  State<PickOrderLinesScreen> createState() => _PickOrderLinesScreenState();
}

class _PickOrderLinesScreenState extends State<PickOrderLinesScreen> {
  PageRouteBuilder opaquePage(Widget page) => PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => page,
      );
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PickOrderLineProvider>(context, listen: false)
          .pickOrderLineAPI(context: context, pickingId: widget.pickingId);
    });
    super.initState();
  }

  String? barcode;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String? _onQuantity = '';
    String? _doneQuantity = '';
    final pickData = Provider.of<PickOrderLineProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: CustomColor.darkwhite,
          leading: Padding(
            padding: EdgeInsets.only(left: width * 0.02),
            child: IconButton(
              icon: Image.asset(
                "assets/images/pick_logo2.png",
              ),
              onPressed: () {},
            ),
          ),
          title: const Text(
            "Pick Order Lines",
            style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontFamily: "Nunito",
                fontWeight: FontWeight.bold),
          ),
          actions: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: width * 0.05),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    // ignore: unrelated_type_equality_checks

                    // const Text(
                    //   "",
                    //   style: TextStyle(
                    //       color: CustomColor.blackcolor,
                    //       fontSize: 23,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    // Text(
                    //   "/${_doneQuantity.toString()}",
                    //   style: TextStyle(
                    //       color: CustomColor.blackcolor,
                    //       fontSize: 23,
                    //       fontWeight: FontWeight.bold),
                    // ),
                  ],
                ),
              ),
            ),
          ]),
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                          widget.pickingId.toString(),
                          style: TextStyle(
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
                          Text(
                            "Sender    :",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              widget.sender.toString(),
                              style: TextStyle(
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
          Expanded(
            child: pickData.pickOrderLoading == true
                ? LoadingScreenPutAway(title: "Loading")
                : pickData.pickOrderErrorLoading == true
                    ? ErrorScreenPutAway(title: pickData.pickOrderErrorMessage)
                    : pickData.orderlineArrangement.isEmpty
                        ? EmptyScreenPutAway(title: "No Product Found")
                        : ListView.separated(
                            itemCount: pickData.orderlineArrangement.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return PickProductOrderLineWidget(
                                  pickLinedata: pickData.pickLine,
                                  locationId: pickData.locationDest[index],
                                  locationName:
                                      pickData.locationDestination[index]);
                            },
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
      // floatingActionButton: PickOrderLineBottom(
      //   barcode: barcode,
      // )
    );
  }
}
