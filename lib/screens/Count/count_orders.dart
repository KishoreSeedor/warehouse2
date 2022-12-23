import 'package:flutter/material.dart';
import 'package:warehouse/screens/Count/bottom_widget_count.dart';
import 'package:warehouse/screens/Count/count_order_lines.dart';

import '../../const/color.dart';
import '../Receive/received_page_container.dart';

class CountOrders extends StatefulWidget {
  const CountOrders({super.key});

  @override
  State<CountOrders> createState() => _CountOrdersState();
}

bool _visible = false;

class _CountOrdersState extends State<CountOrders> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    String? barcode;
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: _visible ? const Size(0, 400) : const Size(0, 0),
              child: Container(
                height: _visible ? height * 0.48 : height * 0,
                decoration: const BoxDecoration(
                    color: Color(0xFF706E6E),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.02,
                            left: width * 0.15,
                            bottom: height * 0.005),
                        child: const Text(
                          "Location",
                          style: TextStyle(
                              color: CustomColor.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.15),
                        child: SizedBox(
                          height: height * 0.05,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: CustomColor.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.02,
                            left: width * 0.15,
                            bottom: height * 0.005),
                        child: const Text(
                          "Exp,Rec,Date",
                          style: TextStyle(
                              color: CustomColor.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.15),
                        child: SizedBox(
                          height: height * 0.05,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: CustomColor.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: CustomColor.homepageBgColor,
                                      width: 2)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.02,
                            left: width * 0.15,
                            bottom: height * 0.005),
                        child: const Text(
                          "PO Number",
                          style: TextStyle(
                              color: CustomColor.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.15),
                        child: SizedBox(
                          height: height * 0.05,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: CustomColor.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.02,
                            left: width * 0.15,
                            bottom: height * 0.005),
                        child: const Text(
                          "Assigned User ID",
                          style: TextStyle(
                              color: CustomColor.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.15),
                        child: SizedBox(
                          height: height * 0.05,
                          child: TextField(
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(15),
                                child:
                                    Image.asset("assets/images/dropdown.png"),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: CustomColor.white, width: 2)),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.03, left: width * 0.42),
                            child: SizedBox(
                              height: height * 0.035,
                              width: width * 0.26,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    backgroundColor: CustomColor.whiteGreen,
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    "RESET",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: height * 0.03,
                            ),
                            child: SizedBox(
                              height: height * 0.035,
                              width: width * 0.26,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    backgroundColor: const Color(0xFFEDFDDD),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    "APPLY",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
            backgroundColor: CustomColor.darkwhite,
            leading: IconButton(
              icon: Image.asset(
                "assets/images/count_logo.png",
              ),
              onPressed: () {},
            ),
            title: const Text(
              "Count Orders",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              Row(
                children: [
                  Text(
                    "1",
                    style: const TextStyle(
                        color: CustomColor.blackcolor2,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Image.asset(
                      "assets/images/fillter.png",
                    ),
                    onPressed: () {
                      setState(() {
                        _visible = !_visible;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          body: ListView.separated(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.all(13),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: CustomColor.gray200,
                      ),
                      child: ReceivedContainer(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CountOrederLine()));
                          setState(() {
                            _visible = false;
                          });
                        },
                        height: height,
                        width: width,
                        companyName: "Kishore",
                        createDate: "11.11.22",
                        origin: "India",
                        displayName: "Kishore",
                      )),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int itemCount) {
              return const Divider(
                thickness: 2,
                color: CustomColor.yellow,
              );
            },
          ),
          floatingActionButton: BottomCountOrder(barcode: barcode),
        ));
  }
}
