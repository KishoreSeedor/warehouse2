import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/screens/PutAway/utilites/empty_screen.dart';
import 'package:warehouse/screens/PutAway/utilites/error_screen.dart';
import 'package:warehouse/screens/PutAway/utilites/loading_screen.dart';
import 'package:warehouse/screens/Receive/pallet_allocation/pallet_provider.dart';
import 'package:warehouse/screens/Receive/pallet_allocation/scan_pallet_alert.dart';

import '../../../const/color.dart';
import '../../../services/api/recive_api.dart';

class PalletAllocationScreen extends StatefulWidget {
  final String id;
  final String prodId;
  const PalletAllocationScreen(
      {super.key, required this.id, required this.prodId});

  @override
  State<PalletAllocationScreen> createState() => _PalletAllocationScreenState();
}

class _PalletAllocationScreenState extends State<PalletAllocationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<RecivePalletProvider>(context, listen: false)
        .palletListApi(context: context);
    Provider.of<RecivePalletProvider>(context, listen: false)
        .getAllorderLineProduct(
            context: context, id: widget.id, prodId: widget.prodId);
  }

  @override
  Widget build(BuildContext context) {
    final pallet = Provider.of<RecivePalletProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.darkwhite,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          'Pallet',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                onPressed: () {
                  pallet.palletScanDialog(
                      context: context,
                      allPallet: pallet.allPalletname,
                      pickingId: widget.id);
                },
                child: Text(
                  'Create Pallet',
                  style: TextStyle(color: Colors.black),
                )),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Your Location Barcode : ${pallet.locationBarcodeScan}',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          pallet.orderlineLoading
              ? Flexible(
                  child: LoadingScreenPutAway(
                  title: 'Loading...',
                ))
              : pallet.orderlineErrorLoading
                  ? Flexible(
                      child: ErrorScreenPutAway(
                          title: pallet.orderlIneErrorMessage))
                  : pallet.allOrderLineProd.isEmpty
                      ? Flexible(
                          child: EmptyScreenPutAway(title: 'No data found'))
                      : Flexible(
                          child: ListView.builder(
                              itemCount: pallet.allOrderLineProd.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (ctx, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(17),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: CustomColor.gray200,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: size.width * 0.03),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  pallet.allOrderLineProd[index]
                                                      .palletDestinationName,
                                                  style: const TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: CustomColor
                                                          .blackcolor2),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        size.height * 0.04,
                                                  ),
                                                  child: Text(
                                                    pallet
                                                        .allOrderLineProd[index]
                                                        .productname,
                                                    overflow: TextOverflow.fade,
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: CustomColor
                                                            .blackcolor2),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    pallet
                                                        .allOrderLineProd[index]
                                                        .quantity,
                                                    style: const TextStyle(
                                                        color: CustomColor
                                                            .blackcolor2,
                                                        fontSize: 23,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  // Text(
                                                  //   "3",
                                                  //   style: const TextStyle(
                                                  //       color: CustomColor.blackcolor2,
                                                  //       fontSize: 23,
                                                  //       fontWeight: FontWeight.bold),
                                                  // ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                              const Text(
                                                "PCS",
                                                style: TextStyle(
                                                    color:
                                                        CustomColor.blackcolor2,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.03,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
        ],
      ),
      // floatingActionButton: GestureDetector(
      //   onTap: () {
      //     RecieveAPI()
      //         .receivedFinalValitation(context: context, userId: widget.id);
      //   },
      //   child: Container(
      //       height: size.height * 0.06,
      //       width: size.width * 0.35,
      //       margin: const EdgeInsets.all(10),
      //       padding: const EdgeInsets.all(10),
      //       decoration: BoxDecoration(
      //           color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
      //       child: Center(
      //           child: Text(
      //         'Validate',
      //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      //       ))),
      // ),
    );
  }
}
