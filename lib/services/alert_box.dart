import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/widgets/custom_alert_dialog.dart';

import '../const/color.dart';
import '../models/quality_check_questions.dart';
import '../models/quality_value.dart';
import '../screens/PickOrder/scanSerial.dart';
import '../screens/Receive/receive_orders_line.dart';
import 'api/recive_api.dart';
import 'bar_code_scanner_alert.dart';

String? value;

List<QualityQuestions?> questionDetailis = [];

class QuestionGet {
  Future<List<QualityQuestions>?> questionGet() async {
    for (var i = 0; i < questionDetailis.length; i++) {
      print("questionidlength--->${questionDetailis.length}");

      questionId = questionDetailis[i]!.id.toString();
      question = questionDetailis[i]!.questions.toString();
      questionValue = questionDetailis[i]!.value.toString();
    }
  }
}

String? questionValue;
String? questionId = '';
String? chooseValue;
// String feedBackValueText = '';
String? question;
int selectindex = 0;

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: value.toString(),
        child: Text(
          value.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )),
    // const DropdownMenuItem(
    //     enabled: true,
    //     value: "Average",
    //     child: Text(
    //       "Average",
    //       textAlign: TextAlign.center,
    //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //     )),
    // const DropdownMenuItem(
    //     value: "Bad",
    //     child: Text(
    //       "Bad",
    //       textAlign: TextAlign.center,
    //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //     )),
    // const DropdownMenuItem(
    //     value: "Yes",
    //     child: Text(
    //       "Yes",
    //       textAlign: TextAlign.center,
    //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //     )),
    // const DropdownMenuItem(
    //     value: "No",
    //     child: Text(
    //       "No",
    //       textAlign: TextAlign.center,
    //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //     )),
  ];
  return menuItems;
}

class GlobalAlertBox {
  topAlertBox({required BuildContext context, required String text}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: CustomColor.yellow,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                            color: CustomColor.blackcolor2,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  void confirmBox({
    required BuildContext context,
  }) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (
          BuildContext context,
        ) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SafeArea(
                child: Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: CustomColor.white,
                  insetPadding: const EdgeInsets.all(10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.22,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Text(
                            "Confirmation Required",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 18),
                          child: Text(
                            "You have completed registrations on all orderlines. Do you want to post the order?",
                            style: TextStyle(
                                color: CustomColor.grayword,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: CustomColor.buttonBrown,
                                    borderRadius: BorderRadius.circular(12)),
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "No",
                                      style: TextStyle(
                                          color: CustomColor.white,
                                          fontSize: 18),
                                    )),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: CustomColor.buttonBrown,
                                    borderRadius: BorderRadius.circular(12)),
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      globalAlertBox.successBox(
                                          context: context);
                                    },
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(
                                          color: CustomColor.white,
                                          fontSize: 18),
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void successBox({required BuildContext context}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SafeArea(
                child: Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: CustomColor.white,
                  insetPadding: const EdgeInsets.all(10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 30, horizontal: 18),
                            child: Text(
                              "Order posted succssfully",
                              style: TextStyle(
                                  color: CustomColor.grayword,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: CustomColor.buttonBrown,
                                      borderRadius: BorderRadius.circular(12)),
                                  height:
                                      MediaQuery.of(context).size.height * 0.18,
                                  width:
                                      MediaQuery.of(context).size.width * 0.23,
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Center(
                                        child: Text(
                                          "CLOSE",
                                          style: TextStyle(
                                              color: CustomColor.white,
                                              fontSize: 20),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void scanBox({required BuildContext context, required String barcode}) {
    bool show = false;
    String adding = 1 as String;

    late final TextEditingController controller = TextEditingController();

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SafeArea(
                  child: Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: CustomColor.white,
                    insetPadding: const EdgeInsets.all(10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: CustomColor.graybox,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Enter delivery note number",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColor.blackcolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Image.asset(
                                        "assets/images/close.png",
                                      )),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 50, left: 20, right: 20),
                              child: TextField(
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    show = true;
                                  } else {
                                    show = false;
                                  }
                                },
                                controller: controller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    suffixText: "Scan Barcode",
                                    labelText: "Type or scan barcode",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    suffixIcon: show
                                        ? IconButton(
                                            iconSize: 50,
                                            icon: Image.asset(
                                                "assets/images/Barcode2.png"),
                                            onPressed: () {
                                              AlertBarcodeScanner(
                                                barcode: barcode,
                                              );
                                            },
                                          )
                                        : null,
                                    prefixIcon: show
                                        ? null
                                        : IconButton(
                                            iconSize: 50,
                                            icon: Image.asset(
                                                "assets/images/Barcode2.png"),
                                            onPressed: () {
                                              AlertBarcodeScanner(
                                                barcode: barcode,
                                              );
                                            },
                                          )),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                  const Text(
                                    ".",
                                    style: TextStyle(fontSize: 50),
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    width: MediaQuery.of(context).size.width *
                                        0.18,
                                    decoration: BoxDecoration(
                                        color: CustomColor.boxGreen,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
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
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> scanSerialNumber(
      {required BuildContext context,
      required String barcode,
      required String text,
      required String subTitleText}) async {
    bool show = false;

    final TextEditingController controller = TextEditingController();
    return WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SafeArea(
                        child: Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: CustomColor.white,
                          insetPadding: const EdgeInsets.all(10),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: CustomColor.graybox,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        text,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: CustomColor.blackcolor),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(10),
                                      //   child: IconButton(
                                      //       onPressed: () {
                                      //         Navigator.pop(context);
                                      //       },
                                      //       icon: Image.asset(
                                      //         "assets/images/close.png",
                                      //       )),
                                      // )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50, left: 20, right: 20),
                                    child: TextField(
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          show = true;
                                        } else {
                                          show = false;
                                        }
                                      },
                                      controller: controller,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          suffixText: "Scan Barcode",
                                          labelText: "Type or scan barcode",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          suffixIcon: show
                                              ? IconButton(
                                                  iconSize: 50,
                                                  icon: Image.asset(
                                                      "assets/images/Barcode2.png"),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AlertBarcodeScanner(
                                                          barcode: barcode,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : null,
                                          prefixIcon: show
                                              ? null
                                              : IconButton(
                                                  iconSize: 50,
                                                  icon: Image.asset(
                                                      "assets/images/Barcode2.png"),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AlertBarcodeScanner(
                                                          barcode: barcode,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 18),
                                  child: Text(
                                    subTitleText,
                                    style: TextStyle(
                                        color: CustomColor.grayword,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.18,
                                            decoration: BoxDecoration(
                                                color: CustomColor.graybox,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                "assets/images/back_image.png",
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          ".",
                                          style: TextStyle(fontSize: 50),
                                          textAlign: TextAlign.center,
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.18,
                                          decoration: BoxDecoration(
                                              color: CustomColor.boxGreen,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }

  Future<void> qualityChecker({
    required BuildContext context,
    required Future<List<QualityQuestionsValue?>> qualityFuture,
    required String barcode,
    required TextEditingController? feedBackValue,
    required String userId,
  }) async {
    bool show = false;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final question = Provider.of<RecieveAPI>(context, listen: false);

    return WidgetsBinding.instance.addPostFrameCallback((_) {
      String? questionId;

      print("questionId---> ${questionId.toString}");
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: CustomColor.white,
                    insetPadding: const EdgeInsets.all(10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: double.infinity,
                      child: FutureBuilder<List<QualityQuestions?>>(
                          future: RecieveAPI()
                              .qualityCheck(context: context, userId: userId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              questionDetailis = snapshot.data!;
                              print(questionDetailis.toString() +
                                  'questionsssss');
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: CustomColor.graybox,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))),
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.05),
                                          child: const Text(
                                            "Quality Check",
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: CustomColor.blackcolor),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Padding(
                                            padding:
                                                EdgeInsets.all(height * 0.004),
                                            child: Image.asset(
                                                "assets/images/close.png"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Expanded(
                                  //   flex: 4,
                                  //   child: ListView.builder(
                                  //     scrollDirection: Axis.vertical,
                                  //     shrinkWrap: true,
                                  //     itemCount: snapshot.data!.length,
                                  //     itemBuilder: (context, index) {
                                  //       questionId = snapshot.data![index]!.id;
                                  //       return Padding(
                                  //         padding: EdgeInsets.only(
                                  //             top: height * 0.03,
                                  //             left: width * 0.03,
                                  //             right: width * 0.03),
                                  //         child: Container(
                                  //           height: height * 0.13,
                                  //           child: Column(
                                  //             children: [
                                  //               Row(
                                  //                 mainAxisAlignment:
                                  //                     MainAxisAlignment.start,
                                  //                 crossAxisAlignment:
                                  //                     CrossAxisAlignment.start,
                                  //                 children: [
                                  //                   Text(
                                  //                     '${index.toString().replaceFirst(0.toString(), 1.toString())}.',
                                  //                     style: TextStyle(
                                  //                         fontSize: 18),
                                  //                   ),
                                  //                   Expanded(
                                  //                     flex: 3,
                                  //                     child: Text(
                                  //                       snapshot.data![index]!
                                  //                           .questions
                                  //                           .toString(),
                                  //                       style: const TextStyle(
                                  //                           fontSize: 18,
                                  //                           fontWeight:
                                  //                               FontWeight
                                  //                                   .bold),
                                  //                       overflow: TextOverflow
                                  //                           .visible,
                                  //                     ),
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //               Padding(
                                  //                 padding: EdgeInsets.only(
                                  //                     left: width * 0.5,
                                  //                     right: width * 0.08),
                                  //                 child: DropdownItemState(
                                  //                   feedBack: feedBackValueText
                                  //                       .toString(),
                                  //                   questionId:
                                  //                       questionId.toString(),
                                  //                   answerId:
                                  //                       chooseValue.toString(),
                                  //                   height: height,
                                  //                   userId: userId,
                                  //                   data: qualityFuture,
                                  //                 ),
                                  //               )
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       );
                                  //     },
                                  //   ),
                                  // ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          question.ques[selectindex].questions,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: CustomColor.blackcolor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: height * 0.05,
                                              vertical: width * 0.1),
                                          child: DropdownItemState(
                                              userId: userId,
                                              data: qualityFuture,
                                              questionId:
                                                  questionId.toString()),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Feedback",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: height * 0.01),
                                          child: SizedBox(
                                            //height: cann't be changeable,
                                            width: width * 0.85,
                                            child: TextField(
                                              controller: feedBackValue,
                                              onSubmitted: (e) {
                                                feedBackValue!.text = e;
                                                // feedBackValueText =
                                                //     feedBackValue.text;
                                              },
                                              textAlign: TextAlign.start,
                                              keyboardType: TextInputType.name,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  filled: true,
                                                  hintStyle: const TextStyle(
                                                      color: CustomColor
                                                          .dimensionColor,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  hintText: 'Feedback',
                                                  fillColor: Colors.white70),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  NextScreen(
                                    quesuionId: question.ques[selectindex].id,
                                    questions:
                                        question.ques[selectindex].questions,
                                    selectedIndex: selectindex,
                                    userId: userId,
                                    barcode: barcode,
                                    feedBackValue: feedBackValue,
                                    qualityFuture: qualityFuture,
                                  )
                                ],
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: CustomColor.yellow,
                                ),
                              );
                            }
                          }),
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}

class NextScreen extends StatefulWidget {
  String? userId;
  int selectedIndex;
  final String quesuionId;
  final String questions;
  final Future<List<QualityQuestionsValue?>> qualityFuture;
  final String barcode;
  final TextEditingController? feedBackValue;

  NextScreen(
      {Key? key,
      required this.userId,
      required this.quesuionId,
      required this.qualityFuture,
      required this.barcode,
      required this.feedBackValue,
      required this.questions,
      required this.selectedIndex})
      : super(key: key);

  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  final TextEditingController feedbackController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.18,
                decoration: BoxDecoration(
                    color: CustomColor.graybox,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/back_image.png",
                  ),
                ),
              ),
            ),
            const Text(
              ".",
              style: TextStyle(fontSize: 50),
              textAlign: TextAlign.center,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.18,
              decoration: BoxDecoration(
                  color: CustomColor.boxGreen,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {
                      print("select-->${selectindex += 1}");
                      setState(() {
                        selectindex += 1;
                      });
                      RecieveAPI()
                          .qualityValueGet(
                            context: context,
                            feedBack: feedbackController.text,
                            questionId: widget.quesuionId,
                            answerId: chooseValue.toString(),
                            userId: widget.userId.toString(),
                          )
                          .then((value) {});

                      feedbackController.text = "";
                    },
                    child: widget.questions.length == selectindex
                        ? Image.asset(
                            "assets/images/front.png",
                          )
                        : Image.asset(
                            "assets/images/tick.png",
                          )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownItemState extends StatefulWidget {
  String userId;

  String questionId;
  Future<List<QualityQuestionsValue?>>? data;
  DropdownItemState({
    super.key,
    required this.userId,
    required this.data,
    required this.questionId,
  });

  @override
  State<DropdownItemState> createState() => _DropdownItemStateState();
}

class _DropdownItemStateState extends State<DropdownItemState> {
  // _DropdownItemStateState() {
  //   selectedValue = prodectList[0].toString();
  // }
  TextEditingController? qualityValueController;

  String? selectedValue;

  String? qualityValue;
  // List<QualityQuestionsValue?> prodectList = [];
  final _dropdownFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    qualityValueController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    qualityValueController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Form(
      key: _dropdownFormKey,
      child: FutureBuilder<List<QualityQuestionsValue?>>(
          future: widget.data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DropdownButtonFormField(
                  isExpanded: true,
                  icon: const Visibility(
                      visible: false, child: Icon(Icons.arrow_downward)),
                  hint: const Text(
                    "choose",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.blackcolor),
                  ),
                  alignment: Alignment.center,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      fillColor: CustomColor.appbarColor,
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: height * 0.001),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18))),

                  // value: snapshot.data![index]!.questions,
                  items: snapshot.data!
                      .map((e) => DropdownMenuItem<String>(
                            enabled: true,
                            value: e!.id,
                            child: Center(
                              child: Text(
                                e.questions,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (newValue) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      selectedValue = newValue;

                      chooseValue = selectedValue.toString();
                      print("new selectedValue-->${chooseValue}");
                    });
                  });
            } else {
              return Container();
            }
          }),
    );
  }
}

class QualityContainer extends StatefulWidget {
  final String barcode;
  final String userId;
  final TextEditingController? feedBackvalue;

  QualityContainer({
    super.key,
    required BuildContext context,
    required this.barcode,
    required this.feedBackvalue,
    required this.userId,
  });

  @override
  State<QualityContainer> createState() => _QualityContainerState();
}

class _QualityContainerState extends State<QualityContainer> {
  TextEditingController? qualityValueController;
  final TextEditingController feedbackController = TextEditingController();

  String? selectedValue;

  String? qualityValue;

  // List<QualityQuestionsValue?> prodectList = [];
  final _dropdownFormKey = GlobalKey<FormState>();
  Future<List<QualityQuestions?>>? qualityFuture;
  Future<List<QualityQuestionsValue?>>? qualityFuture2;
  @override
  void initState() {
    qualityFuture = RecieveAPI()
        .qualityCheck(context: context, userId: widget.userId)
        .then((value) {
      final question = Provider.of<RecieveAPI>(context, listen: false);

      if (question.ques.isEmpty) {
        Text("No questions founded");
      } else {
        qualityFuture2 = RecieveAPI().qualityCheckValue(
            context: context,
            userId: widget.userId,
            valuesId: question.ques[selectindex].value);
      }
      // if(question.ques[selectindex].value)

      return value;
    });

    super.initState();
  }

  int selectindex = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final question = Provider.of<RecieveAPI>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor: CustomColor.white,
              insetPadding: const EdgeInsets.all(10),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.infinity,
                  child: FutureBuilder<List<QualityQuestions?>>(
                      future: RecieveAPI().qualityCheck(
                          context: context, userId: widget.userId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isEmpty) {
                            print('print data hello world');
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'No Question in This Prodect',
                                    style: TextStyle(
                                        color: CustomColor.blueColor,
                                        fontSize: 20),
                                  ),
                                )
                              ],
                            );
                          } else {
                            if (selectindex < snapshot.data!.length) {
                              questionDetailis = snapshot.data!;
                              print(
                                  'questionsssss ${selectindex < snapshot.data!.length}');
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: CustomColor.graybox,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))),
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: const Text(
                                            "Quality Check",
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: CustomColor.blackcolor),
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
                                            padding:
                                                EdgeInsets.all(height * 0.004),
                                            child: Image.asset(
                                                "assets/images/close.png"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          question.ques[selectindex].questions,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: CustomColor.blackcolor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: height * 0.05,
                                              vertical: width * 0.1),
                                          child: Form(
                                            key: _dropdownFormKey,
                                            child: FutureBuilder<
                                                    List<
                                                        QualityQuestionsValue?>>(
                                                future: qualityFuture2,
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color:
                                                            CustomColor.yellow,
                                                      ),
                                                    );
                                                  } else if (snapshot.hasData) {
                                                    return DropdownButtonFormField(
                                                        isExpanded: true,
                                                        icon: const Visibility(
                                                            visible: false,
                                                            child: Icon(Icons
                                                                .arrow_downward)),
                                                        hint: const Text(
                                                          "choose",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: CustomColor
                                                                  .blackcolor),
                                                        ),
                                                        alignment: Alignment
                                                            .center,
                                                        decoration:
                                                            InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                ),
                                                                fillColor:
                                                                    CustomColor
                                                                        .appbarColor,
                                                                filled: true,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        vertical: height *
                                                                            0.001),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            18))),

                                                        // value: snapshot.data![index]!.questions,
                                                        items: snapshot.data!
                                                            .map((e) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  enabled: true,
                                                                  value: e!.id,
                                                                  child: Center(
                                                                    child: Text(
                                                                      e.questions,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ))
                                                            .toList(),
                                                        value: selectedValue,
                                                        onChanged: (newValue) {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  FocusNode());
                                                          setState(() {
                                                            selectedValue =
                                                                newValue;
                                                            chooseValue =
                                                                selectedValue
                                                                    .toString();
                                                            print(
                                                                "choosevalue--> $chooseValue");
                                                          });
                                                        });
                                                  } else {
                                                    return SizedBox(
                                                      height: height * 0.05,
                                                      width: width * 0.1,
                                                      child: TextButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<Color>(CustomColor
                                                                      .graybox),
                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          18.0),
                                                                  side: BorderSide(
                                                                      color: Colors
                                                                          .black)))),
                                                          onPressed: () {
                                                            setState(() {});
                                                            RecieveAPI().qualityCheckValue(
                                                                context:
                                                                    context,
                                                                userId: widget
                                                                    .userId,
                                                                valuesId: question
                                                                    .ques[
                                                                        selectindex]
                                                                    .value);
                                                          },
                                                          child: Image.asset(
                                                              "assets/images/reload.png")),
                                                    );
                                                  }
                                                }),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Feedback",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: height * 0.01),
                                          child: SizedBox(
                                            //height: cann't be changeable,
                                            width: width * 0.85,
                                            child: TextField(
                                              controller: feedbackController,
                                              onSubmitted: (e) {
                                                feedbackController.text = e;
                                                // feedBackValueText =
                                                //     feedbackController.text;
                                              },
                                              textAlign: TextAlign.start,
                                              keyboardType: TextInputType.name,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),

                                                  // hintStyle: const TextStyle(
                                                  //     color: CustomColor
                                                  //         .dimensionColor,
                                                  //     fontSize: 18,
                                                  //     fontWeight:
                                                  //         FontWeight.bold),
                                                  // hintText:
                                                  //     feedBackValueText.isEmpty
                                                  //         ? ""
                                                  //         : feedBackValueText,
                                                  fillColor: Colors.white70),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (selectindex == 0) {
                                                Navigator.pop(context);
                                              } else {
                                                setState(() {
                                                  selectindex -= 1;
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.18,
                                              decoration: BoxDecoration(
                                                  color: selectindex == 0
                                                      ? CustomColor.graybox
                                                      : CustomColor.greencolor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  "assets/images/back_image.png",
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            ".",
                                            style: TextStyle(fontSize: 50),
                                            textAlign: TextAlign.center,
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.18,
                                            decoration: BoxDecoration(
                                                color: CustomColor.boxGreen,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: TextButton(
                                                onPressed: () {
                                                  print(
                                                      "select-->${selectindex + 1}");
                                                  if (selectindex ==
                                                      question.ques.length) {
                                                    print(
                                                        "question length-->${question.ques.length}");
                                                    RecieveAPI()
                                                        .qualityValueGet(
                                                      context: context,
                                                      feedBack:
                                                          feedbackController
                                                              .text
                                                              .toString(),
                                                      questionId: question
                                                          .ques[selectindex].id,
                                                      answerId: chooseValue
                                                          .toString(),
                                                      userId: widget.userId
                                                          .toString(),
                                                    )
                                                        .then((value) {
                                                      chooseValue = null;
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  OrdersLinePage1(
                                                                      barcode:
                                                                          widget
                                                                              .barcode,
                                                                      id: widget
                                                                          .userId)));
                                                    });
                                                  } else {
                                                    if (chooseValue == null) {
                                                      MyCustomAlertDialog()
                                                          .showCustomAlertdialog(
                                                              context: context,
                                                              title: 'Question',
                                                              subtitle:
                                                                  'Please select any answer given Dropdown',
                                                              onTapOkButt: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              });
                                                    } else {
                                                      print(
                                                          '------->>>>page change');

                                                      RecieveAPI()
                                                          .qualityValueGet(
                                                        context: context,
                                                        feedBack:
                                                            feedbackController
                                                                .text
                                                                .toString(),
                                                        questionId: question
                                                            .ques[selectindex]
                                                            .id,
                                                        answerId: chooseValue
                                                            .toString(),
                                                        userId: widget.userId
                                                            .toString(),
                                                      )
                                                          .then((value) {
                                                        print(
                                                            '$chooseValue------->>>> then function');
                                                        if (value == 200) {
                                                          setState(() {
                                                            selectindex += 1;
                                                          });
                                                          feedbackController
                                                              .text = '';
                                                          chooseValue = null;
                                                          selectedValue = null;
                                                          widget.feedBackvalue!
                                                              .text = '';
                                                          print(selectedValue
                                                                  .toString() +
                                                              '----->>> choosen value');
                                                          print(chooseValue
                                                                  .toString() +
                                                              '----->>> choosen value');
                                                          setState(() {});
                                                        } else {
                                                          MyCustomAlertDialog()
                                                              .showCustomAlertdialog(
                                                                  context:
                                                                      context,
                                                                  title:
                                                                      'Question',
                                                                  subtitle:
                                                                      'Something went wrong',
                                                                  onTapOkButt:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  });
                                                        }
                                                      });
                                                    }
                                                  }
                                                },
                                                child:
                                                    question.ques.length - 1 ==
                                                            selectindex
                                                        ? Image.asset(
                                                            "assets/images/tick.png",
                                                          )
                                                        : Image.asset(
                                                            "assets/images/front.png",
                                                          )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              // Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          }
                        }
                        return Center(
                            child: CircularProgressIndicator(
                          color: CustomColor.yellow,
                        ));
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
