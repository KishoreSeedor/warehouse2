import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/const/color.dart';
import 'package:warehouse/screens/Count/Count_Provider/count_total_itemcount.dart';
import 'package:warehouse/screens/Receive/received_page_container.dart';

import '../Count_widget.dart/CountAppbar_widget.dart';

class CountCompanyName extends StatefulWidget {
  const CountCompanyName({super.key});

  @override
  State<CountCompanyName> createState() => _CountCompanyNameState();
}

class _CountCompanyNameState extends State<CountCompanyName> {
  List<Map<String, dynamic>> _companyName = [
    {"id": 1, "name": "Kishore"},
    {"id": 2, "name": "Vishal"},
    {"id": 3, "name": "Jincy"},
    {"id": 4, "name": "Sushalt"},
    {"id": 5, "name": "Bruno"}
  ];

  List<Map<String, dynamic>> _searchName = [];

  @override
  void initState() {
    _searchName = _companyName;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CountTotalIdProvider>(context, listen: false)
          .countTotalIdAPI(context: context);
    });
    super.initState();
  }

  void _searchFile(String enteredKeyword) {
    List<Map<String, dynamic>> result = [];
    if (enteredKeyword.isEmpty) {
      result = _companyName;
    } else {
      result = _companyName
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _searchName = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final totalId = Provider.of<CountTotalIdProvider>(context);
    return Scaffold(
      appBar: const CountAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.13,
              width: width,
              child: Column(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: CustomColor.graybox)),
                        height: height * 0.09,
                        child: Center(
                          child: Text(
                            "ASN",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: CustomColor.graybox)),
                        height: height * 0.09,
                        child: Center(
                          child: Text(
                            "GRN",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: CustomColor.graybox)),
                        height: height * 0.09,
                        child: Center(
                          child: Text(
                            "Delivery",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: CustomColor.graybox)),
                        height: height * 0.09,
                        child: const Center(
                          child: Text(
                            "In Stock",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: height * 0.04,
                          child: Center(
                            child: Text(
                              totalId.countTotalId!.asn.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: CustomColor.graybox)),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: height * 0.04,
                          child: Center(
                            child: Text(
                              totalId.countTotalId!.grn.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: CustomColor.graybox)),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: height * 0.04,
                          child: Center(
                            child: Text(
                              totalId.countTotalId!.delivery.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: CustomColor.graybox)),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: height * 0.04,
                          child: Center(
                            child: Text(
                              totalId.countTotalId!.inStock.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: CustomColor.graybox)),
                        )),
                  ],
                ),
              ]),
            ),
            Container(
              height: height * 0.1,
              width: width,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Search :",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      width: width * 0.7,
                      child: TextField(
                        onChanged: (val) => _searchFile(val),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 3, color: CustomColor.graybox),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 3, color: CustomColor.graybox),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            SingleChildScrollView(
              child: Container(
                height: height * 0.68,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _searchName.length,
                    itemBuilder: (BuildContext context, index) {
                      return ListTile(
                        key: ValueKey(_searchName[index]["id"]),
                        title: Text(
                          _searchName[index]["name"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
