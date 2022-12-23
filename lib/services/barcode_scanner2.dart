import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../const/color.dart';

import 'api/recive_api.dart';
import 'order_line_data.dart';

class BarcodeScanner2 extends StatefulWidget {
  final String barcode;
  const BarcodeScanner2({super.key, required this.barcode});

  @override
  State<BarcodeScanner2> createState() => _BarcodeScanner2State();
}

class _BarcodeScanner2State extends State<BarcodeScanner2> {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;
  // bool torch = false;
  bool hasflashlight = false;
  bool isturnon = false;

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    var hi = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Barcode Scanner",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
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
          backgroundColor: CustomColor.yellow,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
          ],
        ),
      ),
    );
  }

  Future<void> _getQRcode(Barcode qrCode, MobileScannerArguments? args) async {
    // TorchState val = cameraController.torchState as TorchState;

    var dataA = '';
    if (!_screenOpened) {
      String code = qrCode.rawValue.toString().trim();
      AudioPlayer().play(AssetSource("audio/scanner.mp3"));
      print("QRcode Fount -->$code");
      dataA = code;

      Navigator.pop(context);

      await OrderListFunction()
          .orderLineData(barcodeId: code, context: context);

      print("second code--> $code");

      // users.particularOrders(context: context, domain: code);
      // Navigator.pop(context);
      _screenOpened = true;
      cameraController.dispose();
    }

    //open

    //showDialog is used for previously get the code info from Qrcode now it's not needed

    // showDialog(
    //     context: context,
    //     builder: (BuildContext? context) {
    //       return AlertDialog(
    //         title: Text("QR Code"),
    //         content: Text(code),
    //         actions: [
    //           TextButton(
    //               onPressed: () {
    //                 // RecieveAPI()
    //                 //     .particularOrders(context: context!, domain: code);
    //                 Navigator.pop(context!);

    //                 Navigator.pop(context);
    //                 Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) => OrdersSelectPage()));

    //                 cameraController.dispose();
    //               },
    //               child: Text("OK"))
    //         ],
    //       );
    //     });
  }
}
