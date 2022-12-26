import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:warehouse/screens/PutAway/put_away_orders_select.dart';
import 'package:warehouse/screens/PutAway/put_away_provider/put_away_provider.dart';
import 'package:warehouse/screens/PutAway/put_away_widget/bottom_widget_putaway.dart';
import 'package:warehouse/screens/PutAway/put_away_widget/put_away_order_prod_widget.dart';
import 'package:warehouse/screens/PutAway/utilites/empty_screen.dart';
import 'package:warehouse/screens/PutAway/utilites/error_screen.dart';
import 'package:warehouse/screens/PutAway/utilites/loading_screen.dart';

import '../../../const/color.dart';
import '../../../models/reciveorders_model.dart';
import '../../../services/api/recive_api.dart';
import '../../Receive/received_page_container.dart';
import '../put_away_widget/custom_appbar_putAway.dart';

class PutAwayOrdersScreen extends StatefulWidget {
  const PutAwayOrdersScreen({super.key});

  @override
  State<PutAwayOrdersScreen> createState() => _PutAwayOrdersScreenState();
}

bool _visible = false;

class _PutAwayOrdersScreenState extends State<PutAwayOrdersScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  // Future<List<RecivedOrdersModel>>? orders;
  @override
  void initState() {
    Provider.of<PutAwayProvider>(context, listen: false)
        .putAwayLineApi(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final data = Provider.of<PutAwayProvider>(context);

    String? barcode;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: _visible ? const Size(0, 400) : const Size(0, 0),
            child: CustomAppBarPutAway(
              height: height,
              width: width,
              visible: _visible,
            ),
          ),
          backgroundColor: CustomColor.darkwhite,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: Image.asset(
                "assets/images/putawaylogo.png",
              ),
              onPressed: () {},
            ),
          ),
          title: const Text(
            "Put Away Orders",
            style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontFamily: "Nunito",
                fontWeight: FontWeight.bold),
          ),
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    data.putAwayOrderLine.length.toString(),
                    style: const TextStyle(
                        color: CustomColor.blackcolor2,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
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
        body: data.orderlineLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: CustomColor.yellow,
                ),
              )
            : data.orderlineErrorLoading
                ? ErrorScreenPutAway(title: data.orderlIneErrorMessage)
                : data.putAwayOrderLine.isEmpty
                    ? EmptyScreenPutAway(
                        title: 'No Products avalible',
                      )
                    : ListView.separated(
                        reverse: true,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: data.putAwayOrderLine.length,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                            value: data.putAwayOrderLine[index],
                            child: Column(
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
                                    child: const PutAwayOrderProdWidget()),
                              ],
                            ),
                          );
                        },
                        separatorBuilder:
                            (BuildContext context, int itemCount) {
                          return const Divider(
                            thickness: 2,
                            color: CustomColor.yellow,
                          );
                        },
                      ),
        // floatingActionButton: BottomWidget2(
        //   barcode: barcode,
        // )
      ),
    );
  }
}
