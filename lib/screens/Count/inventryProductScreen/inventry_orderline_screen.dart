import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/screens/Count/inventryProductScreen/inventry_provider/inventry_provider.dart';

class InventryProductLineScreen extends StatefulWidget {
  final String inventryId;
  const InventryProductLineScreen({super.key, required this.inventryId});

  @override
  State<InventryProductLineScreen> createState() =>
      _InventryProductLineScreenState();
}

class _InventryProductLineScreenState extends State<InventryProductLineScreen> {
  TextEditingController quantityController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<InventryProductProvider>(context, listen: false)
        .invertProductLineItemsApi(inventryId: widget.inventryId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final inventry = Provider.of<InventryProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text('Product'),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: inventry.isLoading
          ? Center(
              child: Text('Loading...'),
            )
          : inventry.isErrorLoading
              ? Center(
                  child: Text(inventry.errorMessage),
                )
              : inventry.inventryProductData.isEmpty
                  ? Center(
                      child: Text('No Product Found.'),
                    )
                  : ListView.builder(
                      itemCount: inventry.inventryProductData.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Text(inventry.inventryProductData[index].name),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  inventry.inventryProductData[index].location),
                              SizedBox(
                                height: 10,
                              ),
                              Text(inventry
                                  .inventryProductData[index].partnerName),
                              SizedBox(
                                height: 10,
                              ),
                              Text(inventry
                                  .inventryProductData[index].productLot),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        height: size.height * 0.05,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          onChanged: (val) {
                                            inventry.inventryProductData[index]
                                                    .textQuantity =
                                                double.parse(val.toString());
                                            setState(() {});
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              prefixIcon: Container(
                                                width: 10,
                                              ),
                                              hintText: 'Enter Qty',
                                              focusedBorder: InputBorder.none),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: GestureDetector(
                                        onTap: () async {
                                          double difference = double.parse(
                                                  inventry
                                                      .inventryProductData[
                                                          index]
                                                      .textQuantity
                                                      .toString()) -
                                              inventry
                                                  .inventryProductData[index]
                                                  .quantityInHand;
                                          if (difference.round() == 0) {
                                            inventry.inventryCountUpdate(
                                                context: context,
                                                inventryId: inventry
                                                    .inventryProductData[index]
                                                    .id,
                                                count: inventry
                                                    .inventryProductData[index]
                                                    .textQuantity
                                                    .toString(),
                                                reason: '',
                                                difference:
                                                    difference.toString());
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    title: Column(
                                                      children: [
                                                        Text(
                                                            'Reason for difference'),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          'There seems to be a difference in onhand quantity and entered quantity please enter reason for the difference',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    content: Container(
                                                      height:
                                                          size.height * 0.12,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[300],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: TextFormField(
                                                        maxLines: 4,
                                                        controller:
                                                            reasonController,
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText:
                                                                    'Enter Reason',
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none),
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            inventry
                                                                .inventryCountUpdate(
                                                                    context:
                                                                        context,
                                                                    inventryId: inventry
                                                                        .inventryProductData[
                                                                            index]
                                                                        .id,
                                                                    count: inventry
                                                                        .inventryProductData[
                                                                            index]
                                                                        .textQuantity
                                                                        .toString(),
                                                                    reason:
                                                                        reasonController
                                                                            .text,
                                                                    difference:
                                                                        difference
                                                                            .toString())
                                                                .then((value) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              reasonController
                                                                  .text = '';
                                                            });
                                                          },
                                                          child: Text("Submit"))
                                                    ],
                                                  );
                                                });
                                          }
                                        },
                                        child: Container(
                                          height: size.height * 0.05,
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              'Submit',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ))
                                ],
                              )
                            ],
                          ),
                        );
                      }),
      floatingActionButton: Container(
        width: size.width * 0.3,
        height: size.height * 0.05,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.yellow)),
          onPressed: () {
            inventry.inventryvalidationApi(
                context: context, inventryId: widget.inventryId);
          },
          child: Center(
              child: Text(
            'validate',
            style: TextStyle(color: Colors.black),
          )),
        ),
      ),
    );
  }
}
