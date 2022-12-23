import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../const/color.dart';
import '../../services/alert_box.dart';
import '../../services/bar_code_scanner_alert.dart';
import '../PickOrder/scanSerial.dart';

class ScanCountContainer extends StatefulWidget {
  String? barcodeValue;

  ScanCountContainer({
    super.key,
    required String barcodeValue,
  });

  @override
  State<ScanCountContainer> createState() => _ScanCountContainerState();
}

GlobalAlertBox globalAlertBox = GlobalAlertBox();
bool show = false;
String? barcode;
String? barcodeValue = barcode;

class _ScanCountContainerState extends State<ScanCountContainer> {
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController barcodecontroller = TextEditingController();
  final PageController pageController = PageController();
  bool nextPage = false;

  // @override
  // void initState() {
  //   pageController;
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   pageController.dispose();

  //   super.dispose;
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        scrollBehavior: null,
        controller: pageController,
        children: [
          Container(
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
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Scan Bin(Take)",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColor.blackcolor),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: IconButton(
                                        iconSize: 1,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Image.asset(
                                          "assets/images/close.png",
                                        )),
                                  ),
                                )
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
                                controller: barcodecontroller,
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
                                                    barcode: barcode.toString(),
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : Container(),
                                    prefixIcon: show
                                        ? Container()
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
                                                    barcode: barcode.toString(),
                                                  ),
                                                ),
                                              );
                                            },
                                          )),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Scan tha Bin you are Takeing the item from.",
                              style: TextStyle(
                                  color: CustomColor.grayword,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
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
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Enter Quantity',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColor.blackcolor),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: IconButton(
                                        iconSize: 1,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Image.asset(
                                          "assets/images/close.png",
                                        )),
                                  ),
                                )
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
                                controller: quantitycontroller,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                ),
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              child: Text(
                                "Enter the quantity to complete registration",
                                style: TextStyle(
                                    color: CustomColor.grayword,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: nextPage
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.18,
                      decoration: BoxDecoration(
                          color: CustomColor.boxGreen,
                          boxShadow: [
                            BoxShadow(blurRadius: 5, spreadRadius: 0.1)
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: IconButton(
                        icon: Image.asset(
                          "assets/images/back_image.png",
                        ),
                        onPressed: () {
                          setState(() {
                            nextPage = !nextPage;
                          });
                          pageController.previousPage(
                              duration: Duration(microseconds: 500),
                              curve: Curves.easeOut);
                        },
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.18,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SmoothPageIndicator(
                controller: pageController,
                count: 2,
                effect: WormEffect(
                    dotColor: CustomColor.graybox,
                    activeDotColor: CustomColor.yellow),
              ),
            ),
            nextPage
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.18,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(blurRadius: 5, spreadRadius: 0.1)
                        ],
                        color: CustomColor.boxGreen,
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      icon: Image.asset(
                        "assets/images/tick.png",
                      ),
                      onPressed: () {
                        setState(() {
                          pageController.previousPage(
                              duration: Duration(microseconds: 500),
                              curve: Curves.easeIn);

                          Navigator.pop(context);

                          nextPage = !nextPage;
                        });
                      },
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.18,
                    decoration: BoxDecoration(
                        boxShadow: [
                          // ignore: prefer_const_constructors
                          BoxShadow(blurRadius: 5, spreadRadius: 0.1)
                        ],
                        color: CustomColor.boxGreen,
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      icon: Image.asset(
                        "assets/images/front.png",
                      ),
                      onPressed: () {
                        setState(() {
                          pageController.nextPage(
                              duration: Duration(microseconds: 500),
                              curve: Curves.easeIn);
                          nextPage = !nextPage;
                        });
                      },
                    ),
                  )
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
