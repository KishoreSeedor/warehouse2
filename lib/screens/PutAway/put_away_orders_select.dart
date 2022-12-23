import 'package:flutter/material.dart';
import 'package:warehouse/screens/PutAway/put_away_model/put_away_orderline_model.dart';


import 'package:warehouse/screens/PutAway/put_away_ui_design/put_away_orders_line.dart';
import 'package:warehouse/screens/PutAway/put_away_widget/custom_appbar_putAway.dart';

import '../../const/color.dart';
import '../Receive/received_page_container.dart';


class PutAwayOrdersSelect extends StatefulWidget {
  final PutAwayOrdersModel putawayOrder;
  const PutAwayOrdersSelect({super.key,required this.putawayOrder});

  @override
  State<PutAwayOrdersSelect> createState() => _PutAwayOrdersSelectState();
}

bool _visible = false;

class _PutAwayOrdersSelectState extends State<PutAwayOrdersSelect> {
  String? barcode;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: _visible ? const Size(0, 400) : const Size(0, 0),
            child: CustomAppBarPutAway(
              height: height,
              width: width,
              visible: _visible,
            )),
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
      body: SafeArea(
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
                       widget.putawayOrder.id,
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
                            child: Image.asset("assets/images/close.png"),
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
                            builder: (context) =>  PutAwayOrdersLineScreen(id: widget.putawayOrder.id,name: widget.putawayOrder.displayName,)));
                    _visible = false;
                  });
                },
                height: height,
                width: width,
                companyName:  widget.putawayOrder.companyName,
                createDate: widget.putawayOrder.createDate,
                origin: widget.putawayOrder.origin,
                displayName: widget.putawayOrder.displayName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
