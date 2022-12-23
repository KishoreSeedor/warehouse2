import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/provider/barcode_provider.dart';

import '../const/color.dart';
import 'api/recive_api.dart';

class AlertBarcodeScanner extends StatefulWidget {
  final String barcode;
  const AlertBarcodeScanner({super.key, required this.barcode});

  @override
  State<AlertBarcodeScanner> createState() => _AlertBarcodeScannerState();
}

class _AlertBarcodeScannerState extends State<AlertBarcodeScanner> {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;
  // bool torch = false;
  bool hasflashlight = false;
  bool isturnon = false;

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    var hi = MediaQuery.of(context).size.height;
    final barcode = Provider.of<barcodeprovider>(context);

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
    final users = Provider.of<barcodeprovider>(context, listen: false);

    if (!_screenOpened) {
      String code = qrCode.rawValue.toString().trim();
      users.barcodeValuedata = qrCode.rawValue.toString();
      users.barcodeControllerSet = qrCode.rawValue.toString();
      AudioPlayer().play(AssetSource("audio/scanner.mp3"));

      Navigator.of(context).pop();

      _screenOpened = true;
      cameraController.dispose();
    }
  }
}
