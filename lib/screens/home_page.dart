import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse/screens/Count/Count_Ui_desgin/count_company_screen.dart';
import 'package:warehouse/screens/Count/customerCountScreen/Customercountscreen/customer_count_screen.dart';
import 'package:warehouse/screens/Count/inventryProductScreen/inventry_order_screen.dart';
import 'package:warehouse/screens/PickOrder/pick_model/pick_oder_model.dart';
import 'package:warehouse/screens/login_page.dart';
import 'package:warehouse/widgets/custom_alert_dialog.dart';

import '../const/color.dart';
import '../provider/login_details.provider.dart';
import '../services/api/recive_api.dart';
import 'Count/count_orders.dart';
import 'PickOrder/pick_ui_design/pick_orders_screen.dart';

import 'PutAway/put_away_ui_design/put_away_orders.dart';
import 'Receive/receive_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime timePressedBack = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDetails>(context, listen: false);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        final diffrence = DateTime.now().difference(timePressedBack);
        final warning = diffrence >= const Duration(seconds: 2);

        timePressedBack = DateTime.now();
        if (warning) {
          const message = 'press Back again to exit';
          Fluttertoast.showToast(msg: message, fontSize: 18);

          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColor.appbarColor,
          // leading: Padding(
          //   padding: const EdgeInsets.only(left: 10),
          //   child: IconButton(
          //     icon: Image.asset(
          //       "assets/images/logout.png",
          //     ),
          //     onPressed: () {},
          //   ),
          // ),
          title: const Text(
            "Mobile WMS",
            style: TextStyle(
                fontSize: 18,
                color: CustomColor.homepageBgColor,
                fontFamily: "Nunito",
                fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Image.asset(
                  "assets/images/logout.png",
                ),
                onPressed: () {
                  MyCustomAlertDialog().showCustomAlertdialog(
                      context: context,
                      title: "Logout",
                      subtitle: "Do You Want Logout",
                      onTapOkButt: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.clear();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (ctx) => LoginPage()),
                            (route) => false);
                      },
                      button: true,
                      onTapCancelButt: () {
                        Navigator.of(context).pop();
                      });
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: height * 0.1,
                          width: width * 0.2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 3),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/DP.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: CustomColor.homepageBgColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              user.email,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: CustomColor.homepageBgColor,
                                  fontWeight: FontWeight.normal),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: height * 0.050,
                                  width: width * 0.050,
                                  child: Image.asset(
                                    'assets/images/Location.png',
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  "In Dubai Office",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: CustomColor.homepageBgColor,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: GestureDetector(
                          onTap: () {
                            RecieveAPI().recievedoders(context: context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ReceiveOrders(
                                          barcode: "",
                                        )));
                            ChangeNotifier();
                          },
                          child: Container(
                            height: height * 0.2,
                            width: height * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColor.white,
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Receive",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColor.customgray),
                                  ),
                                  Container(
                                      height: height * 0.04,
                                      child: Image.asset(
                                          "assets/images/Receive.png")),
                                  Container(
                                      height: height * 0.1,
                                      child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                              "assets/images/receivebox.png"))),
                                ]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PutAwayOrdersScreen()));
                        },
                        child: Card(
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            height: height * 0.2,
                            width: height * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColor.white,
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Put Away",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColor.customgray),
                                  ),
                                  Container(
                                      height: height * 0.04,
                                      child: Image.asset(
                                          "assets/images/putaway.png")),
                                  Container(
                                      height: height * 0.1,
                                      child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                              "assets/images/receivebox.png"))),
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PickOrdersScreen()));
                          },
                          child: Container(
                            height: height * 0.2,
                            width: height * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColor.white,
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Pick",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColor.customgray),
                                  ),
                                  Container(
                                    height: height * 0.11,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                          "assets/images/pick_logo.png"),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const InventryOrderScreen()));
                        },
                        child: Card(
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            height: height * 0.2,
                            width: height * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColor.white,
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Count",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColor.customgray),
                                  ),
                                  Container(
                                    height: height * 0.11,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                          "assets/images/count_logo.png"),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 200),
                    child: Text(
                      "Recent Activities",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: height * 0.16,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CustomColor.yellow,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: width * 0.2,
                                  height: height * 0.2,
                                  decoration: const BoxDecoration(
                                    color: CustomColor.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(26),
                                    child: Image.asset(
                                      'assets/images/checking.png',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    // ignore: prefer_const_constructors
                                    Text(
                                      "You have checked",
                                      style: TextStyle(
                                          color: CustomColor.homepageBgColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "12 Packages",
                                      style: TextStyle(
                                          color: CustomColor.homepageBgColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Image.asset(
                              "assets/images/leftarrow.png",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
