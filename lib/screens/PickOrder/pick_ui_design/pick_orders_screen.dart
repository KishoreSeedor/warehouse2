import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/screens/PickOrder/bottom_widget_pick.dart';
import 'package:warehouse/screens/PickOrder/pick_order_provider/pick_order_provider.dart';
import 'package:warehouse/screens/PickOrder/pick_ui_design/pick_orders_line_screen.dart';
import 'package:warehouse/screens/PickOrder/pick_widget/fillter_widget.dart';
import 'package:warehouse/screens/PutAway/utilites/empty_screen.dart';
import 'package:warehouse/screens/PutAway/utilites/error_screen.dart';
import 'package:warehouse/services/alert_box.dart';

import '../../../const/color.dart';
import '../../../widgets/menu_widget.dart';
import '../../Receive/received_page_container.dart';
import '../../home_page.dart';

class PickOrdersScreen extends StatefulWidget {
  static const routeName = "pickOrderRoute";
  const PickOrdersScreen({super.key});

  @override
  State<PickOrdersScreen> createState() => _PickOrdersScreenState();
}

bool _visible = false;

class _PickOrdersScreenState extends State<PickOrdersScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PickOrderProvider>(context, listen: false)
          .pickOrderAPI(context: context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    PageRouteBuilder opaquePage(Widget page) => PageRouteBuilder(
        opaque: false, pageBuilder: (BuildContext contex, _, __) => page);
    String? barcode;

    bool isLoading = false;
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            // bottom: PreferredSize(
            //     preferredSize: _visible ? const Size(0, 400) : const Size(0, 0),
            //     child: Container(
            //       height: _visible ? height * 0.48 : height * 0,
            //       decoration: const BoxDecoration(
            //           color: Color(0xFF706E6E),
            //           borderRadius: BorderRadius.only(
            //               bottomRight: Radius.circular(20),
            //               bottomLeft: Radius.circular(20))),
            //       child: FillterWidget(),
            //     )),
            backgroundColor: CustomColor.darkwhite,
            leading: IconButton(
              icon: Image.asset(
                "assets/images/pick_logo2.png",
              ),
              onPressed: () {},
            ),
            title: const Text(
              "Pick Orders",
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
                    "",
                    style: const TextStyle(
                        color: CustomColor.blackcolor2,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                  // IconButton(
                  //   icon: Image.asset(
                  //     "assets/images/fillter.png",
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       _visible = !_visible;
                  //     });
                  //   },
                  // ),
                ],
              ),
            ],
          ),
          body: Consumer<PickOrderProvider>(
            builder: ((context, value, child) {
              return value.pickOrderLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: CustomColor.yellow,
                      ),
                    )
                  : value.pickOrderErrorLoading
                      ? ErrorScreenPutAway(
                          title: value.pickOrderErrorMessage.toString())
                      : value.pickOrder.isEmpty
                          ? EmptyScreenPutAway(title: 'No products')
                          : ListView.separated(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemCount: value.pickOrder.length,
                              itemBuilder: (context, index) {
                                // final picks = value.pickOrder[index];
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(13),
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: CustomColor.gray200,
                                        ),
                                        child: ReceivedContainer(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PickOrderLinesScreen(
                                                          pickingId: value
                                                              .pickOrder[index]
                                                              .id,
                                                          sender: value
                                                              .pickOrder[index]
                                                              .companyName,
                                                        )));
                                            setState(() {
                                              _visible = false;
                                            });
                                          },
                                          height: height,
                                          width: width,
                                          companyName: value
                                              .pickOrder[index].companyName
                                              .toString(),
                                          createDate: value
                                              .pickOrder[index].createDate
                                              .toString(),
                                          origin: value.pickOrder[index].origin
                                              .toString(),
                                          displayName: value
                                              .pickOrder[index].displayName
                                              .toString(),
                                        )),
                                  ],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int itemCount) {
                                return const Divider(
                                  thickness: 2,
                                  color: CustomColor.yellow,
                                );
                              },
                            );
            }),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.push(context, opaquePage(const ReceivedMenu()));
            },
            backgroundColor: CustomColor.darkwhite,
            foregroundColor: Colors.black,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width * 0.02),
                  child: Image.asset(
                    "assets/images/Category.png",
                    width: width * 0.08,
                    height: height * 0.05,
                  ),
                ),
                const Text(
                  "Menu",
                  style: TextStyle(fontSize: 8),
                )
              ],
            ),
          ),
        ));
  }
}
