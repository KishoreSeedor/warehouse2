import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/const/image.dart';
import 'package:warehouse/screens/PickOrder/pick_model/pick_order_lines_model.dart';
import 'package:warehouse/screens/PickOrder/pick_order_provider/pickorder_line_provider.dart';
import 'package:warehouse/screens/PickOrder/pick_widget/product_scanner.dart';
import 'package:warehouse/widgets/custom_alert_dialog.dart';

import '../../../const/color.dart';

class PickProdLocationScanner extends StatefulWidget {
  final String locationId;
  const PickProdLocationScanner({super.key, required this.locationId});

  @override
  State<PickProdLocationScanner> createState() =>
      _PickProdLocationScannerState();
}

class _PickProdLocationScannerState extends State<PickProdLocationScanner> {
  MobileScannerController cameraController = MobileScannerController();
  String locationDestination = '';
  List<PickLinesModel> listOfProduct = [];
  TextEditingController? quantityController;

  Future<dynamic> productGet({required String location}) async {
    final data = Provider.of<PickOrderLineProvider>(context, listen: false);
    for (var i = 0; i < data.pickLine.length; i++) {
      // if (location == data.pickLine[i].locationId) {
      listOfProduct.add(data.pickLine[i]);
      // }
    }
    print('dataa----');
  }

  Future<void> _getQRcode(Barcode qrCode, MobileScannerArguments? args) async {
    print(qrCode.rawValue);

    if (locationDestination != '') {
      await cameraController.stop();
    }

    if (locationDestination == '') {
      if (qrCode.rawValue.toString() == widget.locationId.toString()) {
        locationDestination = qrCode.rawValue.toString();
        await productGet(location: qrCode.rawValue.toString());
        setState(() {
          print(locationDestination);
        });
      } else {
        // await productGet(location: qrCode.rawValue.toString());
        // setState(() {
        //   print(locationDestination);
        // });
        MyCustomAlertDialog().showCustomAlertdialog(
            context: context,
            title: 'Note',
            subtitle:
                'Scanned location is wrong.Please scan correct Location ${widget.locationId}',
            onTapOkButt: () {
              Navigator.of(context).pop();
            });
        cameraController.start();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final pickdata = Provider.of<PickOrderLineProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.yellow,
        title: Text(
            locationDestination == '' ? 'Location Scanner' : 'Product Scanner'),
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {
              cameraController.toggleTorch();
            },
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, value, child) {
                switch (value as TorchState) {
                  case TorchState.off:
                    return const Icon(
                      Icons.flash_off,
                      color: Colors.grey,
                    );
                  case TorchState.on:
                    return const Icon(
                      Icons.flash_on,
                      color: Colors.white,
                    );
                }
              },
            ),
          ),
          IconButton(
            onPressed: () {
              cameraController.switchCamera();
            },
            iconSize: 32,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, value, child) {
                switch (value as CameraFacing) {
                  case CameraFacing.back:
                    return const Icon(
                      Icons.camera_rear,
                      color: Colors.grey,
                    );
                  case CameraFacing.front:
                    return const Icon(
                      Icons.camera_front,
                      color: Colors.white,
                    );
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 400,
            child: MobileScanner(
              allowDuplicates: false,
              controller: cameraController,
              onDetect: _getQRcode,
            ),
          ),
          Row(
            children: [
              Text(
                'Your Location is $locationDestination',
                style: TextStyle(fontSize: 20),
              ),
              // Row(
              //   children: [
              //     TextField(
              //       decoration: const InputDecoration(
              //         hintText: "Enter Location code",
              //         hintStyle: TextStyle(
              //             color: CustomColor.dimensionColor2,
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold),
              //       ),
              //       controller: quantityController,
              //       keyboardType: TextInputType.number,
              //       onSubmitted: (e) {
              //         quantityController!.text = e;
              //       },
              //     ),
              //   ],
              // )
            ],
          ),
          Flexible(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ...List.generate(
                    listOfProduct.length,
                    (index) => Container(
                            child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Qty'),
                                Text(listOfProduct[index].quantity.toString())
                              ],
                            ),
                          ),
                          title: Text(
                              listOfProduct[index].locationDestinationName),
                          subtitle: Text(listOfProduct[index].productname),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => PickProductScanWidget(
                                          productId:
                                              listOfProduct[index].productId,
                                        )));
                              },
                              icon: Image.asset(
                                barcodeScanImage,
                                width: 20,
                                height: 20,
                              )),
                        ))),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
