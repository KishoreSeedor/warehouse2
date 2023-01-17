import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/screens/PickOrder/pick_model/pick_order_lines_model.dart';
import 'package:warehouse/screens/PickOrder/pick_order_provider/pickorder_line_provider.dart';

class PickProductConfirmation extends StatefulWidget {
  final PickLinesModel pickLinesModel;
  final String pickingId;
  const PickProductConfirmation(
      {super.key, required this.pickLinesModel, required this.pickingId});

  @override
  State<PickProductConfirmation> createState() =>
      _PickProductConfirmationState();
}

class _PickProductConfirmationState extends State<PickProductConfirmation> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(
          "Product Details",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: size.width,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  "Product Details",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                expandedWidget(
                    title: "Product Name",
                    subtitle: widget.pickLinesModel.productname),
                expandedWidget(
                    title: "Product Qty",
                    subtitle: widget.pickLinesModel.quantity),
                expandedWidget(
                    title: "Company Name",
                    subtitle: widget.pickLinesModel.companyName),
                expandedWidget(
                    title: "Location Name",
                    subtitle: widget.pickLinesModel.locationDestinationName),
                expandedWidget(
                    title: "Reference",
                    subtitle: widget.pickLinesModel.reference),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.yellow)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.black),
                              )),
                        )),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Consumer<PickOrderLineProvider>(
                              builder: (context, fun, child) {
                            return ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.yellow)),
                                onPressed: () {
                                  if (fun.updateLoading) {
                                  } else {
                                    fun.updateProductTopick(
                                        context: context,
                                        pickingId: widget.pickingId,
                                        id: widget.pickLinesModel.id,
                                        locationid:
                                            widget.pickLinesModel.locationId);
                                  }
                                },
                                child: Text(
                                  fun.updateLoading ? "Loading" : "Confirm",
                                  style: TextStyle(color: Colors.black),
                                ));
                          }),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget expandedWidget({required String title, required String subtitle}) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            )),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
              ),
            ))
      ],
    );
  }
}
