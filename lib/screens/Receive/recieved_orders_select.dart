import 'package:flutter/material.dart';
import '../../const/color.dart';
import '../../models/recived_details_model.dart';
import '../../services/api/recive_api.dart';
import 'receive_orders_line.dart';
import 'received_page_container.dart';

class OrdersSelectPage extends StatefulWidget {
  final String barcode;

  const OrdersSelectPage({super.key, required this.barcode});

  static const routename = "orders_page";

  @override
  State<OrdersSelectPage> createState() => _OrdersSelectPageState();
}

bool _visible = false;

class _OrdersSelectPageState extends State<OrdersSelectPage> {
  @override
  Widget build(BuildContext context) {
    String userId = '';
    // user provider is now not used in this page
    // final user = Provider.of<RecieveAPI>(context, listen: false);
    // final users = user.par;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2)),
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
                              color: CustomColor.homepageBgColor, width: 2)),
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
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2)),
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
                        child: Image.asset("assets/images/dropdown.png"),
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
                    padding:
                        EdgeInsets.only(top: height * 0.03, left: width * 0.42),
                    child: SizedBox(
                      height: height * 0.035,
                      width: width * 0.26,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
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
                                borderRadius: BorderRadius.circular(15)),
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
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Image.asset(
              "assets/images/recivedbox.png",
            ),
            onPressed: () {},
          ),
        ),
        title: const Text(
          "Receive Orders",
          style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontFamily: "Nunito",
              fontWeight: FontWeight.bold),
        ),
        actions: [
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
      body: FutureBuilder<RecievedDetails?>(
          future: RecieveAPI()
              .particularOrders(context: context, domain: widget.barcode),
          builder: (context, snapshot) {
            debugPrint("new Value --> ${snapshot.data}");

            if (snapshot.hasData) {
              userId = snapshot.data!.id.toString();
              print('${snapshot.data!}hellos hellos');
              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.04,
                          bottom: height * 0.02,
                          left: width * 0.04),
                      child: SizedBox(
                        height: height * 0.06,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset("assets/images/Barcode2.png"),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                snapshot.data!.id.toString(),
                                style: const TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.2,
                            ),
                            Expanded(
                              flex: 5,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Padding(
                                    padding: EdgeInsets.all(height * 0.004),
                                    child:
                                        Image.asset("assets/images/close.png"),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 3,
                      color: CustomColor.yellow,
                    ),
                    Container(
                      padding: const EdgeInsets.all(18),
                      margin: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColor.lightPink,
                      ),
                      child: ReceivedContainer(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrdersLinePage1(
                                          barcode: widget.barcode,
                                          id: snapshot.data!.id,
                                        )));
                            _visible = false;
                          });
                        },
                        companyName: snapshot.data!.companyName,
                        createDate: snapshot.data!.createDate.toString(),
                        displayName: snapshot.data!.displayName.toString(),
                        height: height,
                        origin: snapshot.data!.origin.toString(),
                        width: width,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: CustomColor.yellow,
                ),
              );
            }
          }),
      // floatingActionButton: SizedBox(
      //   height: height * 0.06,
      //   width: width * 0.3,
      //   child: FloatingActionButton.extended(
      //     heroTag: null,
      //     onPressed: () {
      //       RecieveAPI()
      //           .receivedFinalValitation(context: context, userId: userId);
      //     },
      //     backgroundColor: CustomColor.yellow,
      //     foregroundColor: Colors.black,
      //     label: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Row(
      //           children: [
      //             Image.asset(
      //               "assets/images/validate.png",
      //               scale: 23,
      //             ),
      //             const Text(
      //               "Validate",
      //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      //             )
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
