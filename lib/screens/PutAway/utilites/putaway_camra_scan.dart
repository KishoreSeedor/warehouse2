import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/screens/PutAway/put_away_model/put_away_orderline_model.dart';
import 'package:warehouse/screens/PutAway/put_away_provider/put_away_orderline_provider.dart';
import 'package:warehouse/screens/PutAway/put_away_widget/custom_putaway_button.dart';
import 'package:warehouse/widgets/custom_alert_dialog.dart';

import '../../../const/color.dart';
import '../put_away_model/putaway_orderline_model.dart';

class PutAwayBarCodeScanner extends StatefulWidget {
  String scanValue;
  PutAwayBarCodeScanner({super.key, required this.scanValue});

  @override
  State<PutAwayBarCodeScanner> createState() => _PutAwayBarCodeScannerState();
}

class _PutAwayBarCodeScannerState extends State<PutAwayBarCodeScanner> {
  final TextEditingController locationController = TextEditingController();
  MobileScannerController cameraController = MobileScannerController();
  PutawayOrderLineModel putAwayOrdersModel = PutawayOrderLineModel(
      id: '',
      locationDest: '',
      productname: '',
      quantity: '',
      locationDestinationName: '',
      productId: '',
      skuId: '',
      locationBarcode: '');
  String locationDestination = '';
  Future<void> productUpdate({required String id}) async {
    print('product scan start $id');
    final data = Provider.of<PutAwayOrderLineProvid>(context, listen: false);
    if (locationDestination.substring(0, 3).toLowerCase().toString() == 'loc') {
      print('entering locating scan');

      if (id.substring(0, 3).toLowerCase().toString() == 'sku') {
        print('entering product scan');
        for (var i = 0; i < data.allOrderLineProd.length; i++) {
          if (data.allOrderLineProd[i].skuId == id) {
            putAwayOrdersModel = data.allOrderLineProd[i];
            setState(() {});
            break;
          }
        }
        if (putAwayOrdersModel.locationBarcode != null ||
            putAwayOrdersModel.locationBarcode != '') {
          print('null check operator is working');
          if (locationDestination == putAwayOrdersModel.locationBarcode) {
            await data.correctproductUpdateInpallet(
                context: context, id: putAwayOrdersModel.id);
          }
        } else {
          print('null check operator is working as empty');
          MyCustomAlertDialog().showCustomAlertdialog(
              context: context,
              title: 'Note',
              button: true,
              onTapCancelButt: () {
                Navigator.of(context).pop();
              },
              subtitle:
                  'The entered Bin $locationDestination does not match the expected value $id. Do you want to use it anyway',
              onTapOkButt: () {
                data.wrongproductUpdateInPallet(
                    context: context, id: id, locationId: locationDestination);
              });
        }
      } else {
        MyCustomAlertDialog().showCustomAlertdialog(
            context: context,
            title: 'Note',
            button: true,
            onTapCancelButt: () {
              Navigator.of(context).pop();
            },
            subtitle: 'Please scan the correct product',
            onTapOkButt: () {
              Navigator.of(context).pop();
              // data.wrongproductUpdateInPallet(
              //     context: context, id: id, locationId: locationDestination);
            });
      }

      print('------CORRECT LOCATION---');
    } else {
      print('------WRONG LOCATION---');
      // MyCustomAlertDialog().showCustomAlertdialog(
      //     context: context,
      //     title: 'Note',
      //     button: true,
      //     onTapCancelButt: () {
      //       Navigator.of(context).pop();
      //     },
      //     subtitle:
      //         'The entered Bin $locationDestination does not match the expected value $id. Do you want to use it anyway',
      //     onTapOkButt: () {
      //       data.wrongproductUpdateInPallet(
      //           context: context, id: id, locationId: locationDestination);
      //     });
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Note',
          button: true,
          onTapCancelButt: () {
            Navigator.of(context).pop();
          },
          subtitle: 'Please scan the correct location',
          onTapOkButt: () {
            Navigator.of(context).pop();
            // data.wrongproductUpdateInPallet(
            //     context: context, id: id, locationId: locationDestination);
          });
    }
  }

  int quantity = 0;
  Future<void> _getQRcode(Barcode qrCode, MobileScannerArguments? args) async {
    print(qrCode.rawValue);

    if (locationDestination != '') {
      await cameraController.stop();

      await productUpdate(id: qrCode.rawValue.toString());
    }

    if (locationDestination == '' &&
        qrCode.rawValue.toString().substring(0, 3).toString() == 'loc') {
      await cameraController.stop();
      locationDestination = qrCode.rawValue.toString();
      setState(() {
        print(locationDestination);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<PutAwayOrderLineProvid>(context);

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
          Text(
            'Your Location is $locationDestination',
            style: TextStyle(fontSize: 20),
          ),
          // Text(
          //   '( OR )',
          //   style: TextStyle(fontSize: 20),
          // ),
          // SizedBox(
          //   height: 30,
          // ),
          // Row(
          //   children: [
          //     TextField(
          //       controller: locationController,
          //       textAlign: TextAlign.center,
          //       onChanged: (val) {
          //         locationDestination = val.toString();
          //         setState(() {});
          //       },
          //       style: TextStyle(
          //           color: CustomColor.dimensionColor,
          //           fontSize: 18,
          //           fontWeight: FontWeight.bold),
          //       keyboardType: TextInputType.number,
          //       decoration: InputDecoration(
          //           border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(10.0),
          //           ),
          //           filled: true,
          //           hintStyle: TextStyle(
          //               color: CustomColor.dimensionColor2,
          //               fontSize: 18,
          //               fontWeight: FontWeight.normal),
          //           hintText: 'Enter Location',
          //           fillColor: Colors.white70),
          //     ),
          //     TextButton(
          //         onPressed: () {
          //           if (locationDestination == '') {
          //             MyCustomAlertDialog().showCustomAlertdialog(
          //                 context: context,
          //                 title: 'Location',
          //                 subtitle: 'Please enter location',
          //                 onTapOkButt: () {
          //                   Navigator.of(context).pop();
          //                 });
          //           } else {}
          //         },
          //         child: Text('Verify'))
          //   ],
          // ),
          SizedBox(
            height: 40,
          ),
          Text(locationDestination == ''
              ? 'Please Start scan your Location'
              : 'Please Start scan your Product'),
          locationDestination == ''
              ? Container()
              : PutAwayCustomButton(
                  title: 'Scan Product',
                  onTap: () {
                    cameraController.start();
                  })
        ],
      ),
    );
  }
}
