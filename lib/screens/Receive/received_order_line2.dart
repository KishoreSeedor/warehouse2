import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/screens/PutAway/utilites/error_screen.dart';
import 'package:warehouse/screens/Receive/pallet_allocation/pallet_allocation_screen.dart';

import '../../const/color.dart';
import '../../models/orders_line_model.dart';

import '../../services/alert_box.dart';
import '../../services/api/recive_api.dart';

// ignore: must_be_immutable
class OrederLinePage2 extends StatefulWidget {
  final String barcode;

  final OrderLine value;
  const OrederLinePage2({
    super.key,
    required this.barcode,
    required this.value,
  });

  @override
  State<OrederLinePage2> createState() => _OrederLinePage2State();
}

class _OrederLinePage2State extends State<OrederLinePage2> {
  TextEditingController quantityController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController breathController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController feedBackController = TextEditingController();
  bool isLoading = false;

  PageRouteBuilder opaquePage(Widget page) => PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => page,
      );

  @override
  void initState() {
    quantityController = TextEditingController();
    quantityController.text = widget.value.productOnQty;
    lengthController = TextEditingController();
    lengthController.text = widget.value.length;
    breathController = TextEditingController();
    breathController.text = widget.value.breadth;
    weightController = TextEditingController();
    weightController.text = widget.value.weight;
    heightController = TextEditingController();
    heightController.text = widget.value.height;
    feedBackController = TextEditingController();
    print(widget.barcode + '------>>>>>> id???');
    Provider.of<RecieveAPI>(
      context,
      listen: false,
    ).qualityCheck(context: context, userId: widget.value.userid);
    super.initState();
  }

  @override
  void dispose() {
    // feedBackController!.dispose();
    quantityController.dispose();
    lengthController.dispose();
    breathController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  String? quantity;
  String? length;
  String? breadth;
  String? weight;
  String? demensionHeight;

  @override
  Widget build(BuildContext context) {
    GlobalAlertBox globalAlertBox = GlobalAlertBox();
    final data = Provider.of<RecieveAPI>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
            actions: []),
        body: SingleChildScrollView(
          child: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(13),
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
                                    widget.value.productId,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColor.blackcolor2),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: height * 0.04,
                                    ),
                                    child: Text(
                                      widget.value.productName,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.fade,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      quantityController.text,
                                      style: const TextStyle(
                                          color: CustomColor.blackcolor2,
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "/${widget.value.productOnQty}",
                                      style: const TextStyle(
                                          color: CustomColor.blackcolor2,
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.01,
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

                          Container(
                            height: height * 0.015,
                            width: width * 0.05,
                            decoration: BoxDecoration(
                                color: int.parse(widget.value.quantityDone) == 0
                                    ? CustomColor.yellow
                                    : int.parse(widget.value.quantityDone) <
                                            int.parse(widget.value.productOnQty)
                                        ? CustomColor.orangecolor
                                        : int.parse(widget
                                                    .value.quantityDone) ==
                                                int.parse(
                                                    widget.value.productOnQty)
                                            ? CustomColor.greencolor
                                            : CustomColor.yellow,
                                borderRadius: BorderRadius.circular(3)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.all(10),
                    // margin: EdgeInsets.symmetric(horizontal: width * 0.002),
                    height: height * 0.65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: CustomColor.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          )
                        ]),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: height * 0.06,
                          width: width,

                          // ignore: sort_child_properties_last
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.01, left: width * 0.05),
                                child: const Text(
                                  "Enter Quantity",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const Expanded(
                                flex: 8,
                                child: Text(""),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Padding(
                                  padding: EdgeInsets.all(height * 0.004),
                                  child: Image.asset("assets/images/close.png"),
                                ),
                              ),
                            ],
                          ),

                          color: CustomColor.darkwhite,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.05,
                              vertical: height * 0.02),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: widget.value.productOnQty.toString(),
                              hintStyle: TextStyle(
                                  color: CustomColor.dimensionColor2,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            controller: quantityController,
                            keyboardType: TextInputType.number,
                            onSubmitted: (e) {
                              quantityController.text = e;
                            },
                          ),
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: width * 0.8,
                                child: const Text(
                                  "Enter the quantity to complete registration",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: CustomColor.grayword,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05, top: height * 0.02),
                                    child: const Text(
                                      "Length",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05, top: height * 0.01),
                                    child: SizedBox(
                                      //height: cann't be changeable,
                                      width: width * 0.35,
                                      child: TextField(
                                        controller: lengthController,
                                        onSubmitted: (e) {
                                          lengthController.text = e;
                                        },
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: CustomColor.dimensionColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle: const TextStyle(
                                                color:
                                                    CustomColor.dimensionColor2,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            hintText:
                                                widget.value.length.toString(),
                                            fillColor: Colors.white70),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, top: height * 0.02),
                                  child: const Text(
                                    "Breadth",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, top: height * 0.01),
                                  child: SizedBox(
                                    //height: cann't be changeable,
                                    width: width * 0.35,
                                    child: TextField(
                                      controller: breathController,
                                      onSubmitted: (e) {
                                        breathController.text = e;
                                      },
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: CustomColor.dimensionColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                              color:
                                                  CustomColor.dimensionColor2,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          hintText:
                                              widget.value.breadth.toString(),
                                          fillColor: Colors.white70),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05, top: height * 0.02),
                                    child: Text(
                                      "Height",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05, top: height * 0.01),
                                    child: SizedBox(
                                      //height: cann't be changeable,
                                      width: width * 0.35,
                                      child: TextField(
                                        controller: heightController,
                                        onSubmitted: (e) {
                                          heightController.text = e;
                                        },
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: CustomColor.dimensionColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            hintStyle: TextStyle(
                                                color:
                                                    CustomColor.dimensionColor2,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            hintText:
                                                widget.value.height.toString(),
                                            fillColor: Colors.white70),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, top: height * 0.02),
                                  child: Text(
                                    "Weight",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, top: height * 0.01),
                                  child: SizedBox(
                                    //height: cann't be changeable,
                                    width: width * 0.35,
                                    child: TextField(
                                      controller: weightController,
                                      onSubmitted: (e) {
                                        weightController.text = e;
                                      },
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: CustomColor.dimensionColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                              color:
                                                  CustomColor.dimensionColor2,
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal),
                                          hintText:
                                              widget.value.breadth.toString(),
                                          fillColor: Colors.white70),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                PalletAllocationScreen(
                                                  prodId:
                                                      widget.value.productId,
                                                  id: widget.barcode,
                                                )));
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             OrdersLinePage1(
                                    //               barcode: widget.barcode,
                                    //               id: widget.value.pickingId,
                                    //             )));
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    width: MediaQuery.of(context).size.width *
                                        0.18,
                                    decoration: BoxDecoration(
                                        color: CustomColor.graybox,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        "assets/images/back_image.png",
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  ".",
                                  style: TextStyle(fontSize: 50),
                                  textAlign: TextAlign.center,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  decoration: BoxDecoration(
                                      color: CustomColor.boxGreen,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextButton(
                                    onPressed: () {
                                      if (isLoading == true) {
                                        print('-----Loading');
                                      } else {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        if (int.parse(
                                                quantityController.text) <=
                                            int.parse(
                                                widget.value.productOnQty)) {
                                          print(
                                              "lengthQty--> ${int.parse(widget.value.quantityDone)}");
                                          print(
                                              "lengthDone--> ${int.parse(widget.value.productOnQty)}");

                                          // RecieveAPI().orderLine(
                                          //     context: context,
                                          //     domain: widget.barcode,
                                          //     pickingId:
                                          //         widget.value.pickingId);

                                          // Navigator.pushReplacement(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           OrdersLinePage1(
                                          //             barcode: widget.barcode,
                                          //             id: widget
                                          //                 .value.pickingId,
                                          //           )),
                                          // );
                                          RecieveAPI()
                                              .orderLineQuantity(
                                                  breadth:
                                                      breathController.text,
                                                  context: context,
                                                  height: heightController.text,
                                                  length: lengthController.text,
                                                  id: widget.value.userid,
                                                  quantity:
                                                      quantityController.text,
                                                  weight: weightController.text)
                                              .then((value) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            if (value == 200) {
                                              Navigator.pushReplacement(
                                                context,
                                                opaquePage(QualityContainer(
                                                    prodId:
                                                        widget.value.productId,
                                                    context: context,
                                                    barcode: widget.barcode,
                                                    feedBackvalue:
                                                        feedBackController,
                                                    userId:
                                                        widget.value.userid)),
                                              );
                                            } else {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              ErrorScreenPutAway(
                                                title: "No Question",
                                              );
                                            }
                                          });
                                          // RecieveAPI().qualityCheck(
                                          //     context: context,
                                          //     userId: widget.value.userid);

                                          // RecieveAPI().qualityCheckValue(
                                          //     context: context,
                                          //     userId: widget.value.userid,
                                          //     questionId:
                                          //         question);
                                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                                          // QualityCheck()
                                          // ));
                                          // Navigator.pushReplacement(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             QualityContainer(
                                          //                 context: context,
                                          //                 qualityFuture:
                                          //                     qualityFuture,
                                          //                 barcode:
                                          //                     widget.barcode,
                                          //                 feedBackvalue:
                                          //                     feedBackController,
                                          //                 userId: widget
                                          //                     .value.userid)));

                                          // Navigator.pushReplacement(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             OrdersLinePage1(
                                          //               barcode: widget.barcode,
                                          //               id: widget.value.userid,
                                          //             )));

                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             OrdersLinePage1(
                                          //                 barcode:
                                          //                     widget.barcode,
                                          //                 id: widget.value
                                          //                     .pickingId)));
                                          // Navigator.pushReplacement(
                                          //   context,
                                          //   opaquePage(QualityContainer(
                                          //       context: context,
                                          //       barcode: widget.barcode,
                                          //       feedBackvalue:
                                          //           feedBackController,
                                          //       userId: widget.value.userid)),
                                          // );
                                          // QuestionGet().questionGet();
                                        } else {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          globalAlertBox.topAlertBox(
                                              context: context,
                                              text: "Enter Valid Details");
                                        }
                                      }
                                    },
                                    child: isLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.yellow,
                                          )
                                        : Image.asset(
                                            "assets/images/tick.png",
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
        backgroundColor: CustomColor.backgroundColor,
      ),
    );
  }
}
