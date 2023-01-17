import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/screens/Receive/pallet_allocation/pallet_provider.dart';
import 'package:warehouse/screens/Receive/pallet_allocation/scan_pallet_alert.dart';
import 'package:warehouse/widgets/custom_alert_dialog.dart';

import '../../../const/color.dart';

class ScanUpdateProductScreen extends StatefulWidget {
  final String pickingId;
  const ScanUpdateProductScreen({super.key, required this.pickingId});

  @override
  State<ScanUpdateProductScreen> createState() =>
      _ScanUpdateProductScreenState();
}

class _ScanUpdateProductScreenState extends State<ScanUpdateProductScreen> {
  TextEditingController enterQuantityController = TextEditingController();
 
  @override
  void dispose() {
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    final pallet = Provider.of<RecivePalletProvider>(context);
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await PalletScanAlertDialog()
            .palletConfirmationDialog(
                context: context, id: widget.pickingId);
        return shouldPop;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColor.darkwhite,
          leading: IconButton(
              onPressed: () {
                PalletScanAlertDialog().palletConfirmationDialog(
                    context: context,
                    id: widget.pickingId);
              },
              icon: Icon(Icons.arrow_back,color: Colors.black,)),
          title: Text(
            'Scan product',
            style: TextStyle(color: Colors.black),
          ),
          actions: [],
        ),
        body: Column(
          children: [
            Text(
              'Your Location Barcode : ${pallet.locationBarcodeScan}',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                onPressed: () {
                  pallet.productScannerDialog(
                    pickingId: widget.pickingId,
                    context: context,
                  );
                },
                child: Text(
                  "Scan Product",
                  style: TextStyle(color: Colors.black),
                )),
            pallet.particularProductModel == null
                ? Container()
                : Container(
                    width: size.width,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: CustomColor.gray200,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            pallet.particularProductModel!.productName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            pallet.particularProductModel!.locationDestName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Qty : ${pallet.particularProductModel!.quantity}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Sku Id : ${pallet.particularProductModel!.skuLineId}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        pallet.particularProductModel!.isSerial == false
                            ? Row(
                                children: [
                                  Expanded(
                                      flex: 4,
                                      child: Container(
                                          height: size.height * 0.05,
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: enterQuantityController,
                                            onChanged: (val) {},
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 10, bottom: 5),
                                                hintText: "Enter Quantity",
                                                border: InputBorder.none,
                                                focusedBorder:
                                                    InputBorder.none),
                                          ))),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        height: size.height * 0.05,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.yellow)),
                                            onPressed: () {
                                              print(int.parse(
                                                          enterQuantityController
                                                              .text)
                                                      .toString() +
                                                  '----' +
                                                  pallet.particularProductModel!
                                                      .quantity
                                                      .toInt()
                                                      .toString());
                                              if (int.parse(
                                                      enterQuantityController
                                                          .text) >
                                                  pallet.particularProductModel!
                                                      .quantity
                                                      .toInt()) {
                                                MyCustomAlertDialog()
                                                    .showCustomAlertdialog(
                                                        context: context,
                                                        title: 'Note',
                                                        subtitle:
                                                            "Please check the enter quantity because enter quantity is greater then product quantity",
                                                        onTapOkButt: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                              } else {
                                                if (pallet.createQtyLoading ==
                                                        true ||
                                                    pallet.quantityUpdateLoading ==
                                                        true) {
                                                } else {
                                                  if (enterQuantityController
                                                          .text ==
                                                      pallet
                                                          .particularProductModel!
                                                          .quantity
                                                          .toInt()
                                                          .toString()) {
                                                    pallet
                                                        .updateQuantityApi(
                                                            serialNum: "",
                                                            palletId: pallet
                                                                .palletName,
                                                            moveId: pallet
                                                                .particularProductModel!
                                                                .id,
                                                            context: context)
                                                        .then((value) {
                                                      enterQuantityController
                                                          .text = "";
                                                      pallet
                                                          .clearparticularModelData();
                                                    });
                                                  } else {
                                                    pallet
                                                        .createMoveLineQuantity(
                                                            context: context,
                                                            moveLineId: pallet
                                                                .particularProductModel!
                                                                .id,
                                                            balanceQty:
                                                                (pallet.particularProductModel!.quantity.toInt() - int.parse(enterQuantityController.text))
                                                                    .toString(),
                                                            moveId: pallet
                                                                .particularProductModel!
                                                                .moveId,
                                                            productId: pallet
                                                                .particularProductModel!
                                                                .productId,
                                                            quantity:
                                                                enterQuantityController.text
                                                                    .trim(),
                                                            locationId: pallet
                                                                .particularProductModel!
                                                                .locationId,
                                                            locationDestId: pallet
                                                                .particularProductModel!
                                                                .locationDestinationId,
                                                            prodUomId: pallet
                                                                .particularProductModel!
                                                                .productUomId,
                                                            pickingID: pallet
                                                                .particularProductModel!
                                                                .pickingId,
                                                            palletId: pallet
                                                                .palletName)
                                                        .then((value) {
                                                      enterQuantityController
                                                          .text = "";
                                                      pallet
                                                          .clearparticularModelData();
                                                    });
                                                  }
                                                }
                                              }
                                            },
                                            child: Text(
                                              pallet.createQtyLoading ||
                                                      pallet
                                                          .quantityUpdateLoading
                                                  ? "Loading"
                                                  : 'Submit',
                                              style: TextStyle(
                                                  color: Colors.black),
                                              overflow: TextOverflow.fade,
                                            )),
                                      ))
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      flex: 4,
                                      child: Container(
                                          height: size.height * 0.05,
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: TextFormField(
                                            controller: pallet.serialNumberId,
                                            onChanged: (val) {},
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 10, bottom: 5),
                                                hintText: "Enter Serial No",
                                                border: InputBorder.none,
                                                focusedBorder:
                                                    InputBorder.none),
                                          ))),
                                  Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          pallet.serialNumScannerDialog(
                                              context: context);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          height: size.height * 0.05,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.yellow),
                                          child: const Center(
                                              child: Icon(
                                                  Icons.qr_code_scanner_sharp)),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        height: size.height * 0.05,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.yellow)),
                                            onPressed: () {
                                              if (pallet.serialLoading) {
                                              } else {
                                                if (pallet.serialNumberId.text
                                                    .trim()
                                                    .isEmpty) {
                                                  MyCustomAlertDialog()
                                                      .showCustomAlertdialog(
                                                          context: context,
                                                          title: "Note",
                                                          subtitle:
                                                              "Please add serial Number",
                                                          onTapOkButt: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          });
                                                } else {
                                                  pallet
                                                      .updateQuantityApi(
                                                          palletId:
                                                              pallet.palletName,
                                                          moveId: pallet
                                                              .particularProductModel!
                                                              .id,
                                                          serialNum: pallet
                                                              .serialNumberId
                                                              .text
                                                              .trim(),
                                                          context: context)
                                                      .then((value) {
                                                    pallet
                                                        .clearparticularModelData();
                                                    pallet.setSerialNumberId =
                                                        '';
                                                  });
                                                }
                                              }
                                            },
                                            child: Text(
                                              pallet.serialLoading
                                                  ? "Loading"
                                                  : 'Submit',
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )),
                                      ))
                                ],
                              )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
