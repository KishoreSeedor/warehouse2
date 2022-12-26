import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const/color.dart';
import '../../models/reciveorders_model.dart';
import '../../services/api/recive_api.dart';
import 'bottom_widget_recevie.dart';
import 'received_page_container.dart';
import 'recieved_orders_select.dart';

class ReceiveOrders extends StatefulWidget {
  final String barcode;
  const ReceiveOrders({super.key, required this.barcode});
  static const routname = 'recieve_page';

  @override
  State<ReceiveOrders> createState() => _ReceiveOrdersState();
}

bool _visible = false;

class _ReceiveOrdersState extends State<ReceiveOrders> {
  AudioPlayer audioPlayer = AudioPlayer();
  late bool hideFilder;
  String? userId;
  // late Future<List<RecivedOrdersModel>> orders;
  // @override
  // void initState() {
  //   orders = Provider.of<RecieveAPI>(context, listen: false)
  //       .recievedoders(context: context);

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                          padding: EdgeInsets.only(
                              top: height * 0.03, left: width * 0.42),
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
          actions: const [
            // FutureBuilder<List<RecivedOrdersModel>>(
            //     future: orders,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         print('new length -->${snapshot.data!.length.toString()}');
            //         return Row(
            //           children: [
            //             Text(
            //               snapshot.data!.length.toString(),
            //               style: const TextStyle(
            //                   color: CustomColor.blackcolor2,
            //                   fontSize: 23,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //             IconButton(
            //               icon: Image.asset(
            //                 "assets/images/fillter.png",
            //               ),
            //               onPressed: () {
            //                 setState(() {
            //                   _visible = !_visible;
            //                 });
            //               },
            //             ),
            //           ],
            //         );
            //       } else {
            //         return Container();
            //       }
            //     })
          ],
        ),
        body: FutureBuilder<List<RecivedOrdersModel>?>(
          future: Provider.of<RecieveAPI>(context, listen: false)
              .recievedoders(context: context),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: CustomColor.yellow),
              );
            } else if (snapshot.hasError) {
              Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              print('' + snapshot.data.toString());
              return snapshot.requireData!.isEmpty
                  ? Center(
                      child: Text(
                        "No Data is Available",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.separated(
                      reverse: true,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        userId = snapshot.data![index].id;
                        // print("uservali-->${userId}");
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
                                                OrdersSelectPage(
                                                    barcode: snapshot
                                                        .data![index].id)));
                                    setState(() {
                                      _visible = false;
                                    });
                                  },
                                  height: height,
                                  width: width,
                                  companyName:
                                      snapshot.data![index].companyName,
                                  createDate: snapshot.data![index].createDate
                                      .toString(),
                                  origin:
                                      snapshot.data![index].origin.toString(),
                                  displayName: snapshot.data![index].displayName
                                      .toString(),
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
                    );
            }
            return Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
        floatingActionButton: BottomWidgets(
          width: width,
          height: height,
          barcode: widget.barcode,
          userId: userId.toString(),
        ),
      ),
    );
  }
}
