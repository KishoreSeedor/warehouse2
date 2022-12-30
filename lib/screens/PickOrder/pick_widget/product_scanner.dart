import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/screens/PickOrder/pick_order_provider/pickorder_line_provider.dart';
import 'package:warehouse/screens/PutAway/put_away_widget/custom_appbar_putAway.dart';
import 'package:warehouse/screens/PutAway/put_away_widget/custom_putaway_button.dart';

import '../../../const/color.dart';

class PickProductScanWidget extends StatefulWidget {
  final String locationDesId;
  final String productId;
  const PickProductScanWidget(
      {super.key, required this.locationDesId, required this.productId});

  @override
  State<PickProductScanWidget> createState() => _PickProductScanWidgetState();
}

class _PickProductScanWidgetState extends State<PickProductScanWidget> {
  MobileScannerController cameraController = MobileScannerController();
  String productSc = '';

  Future<dynamic> updateApi({required String id}) async {
    final data = Provider.of<PickOrderLineProvider>(context, listen: false);
    data.updateProductTopick(context: context, id: id, locationid: id);
  }

  Future<void> _getQRcode(Barcode qrCode, MobileScannerArguments? args) async {
    print(qrCode.rawValue);
    if (qrCode.rawValue == widget.locationDesId) {
      productSc = qrCode.rawValue.toString();
      await updateApi(id: widget.productId);
      setState(() {});
    }
  }

  TextEditingController? quantityController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.yellow,
        title: Text('Product Scanner'),
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
          SizedBox(
            height: 20,
          ),
          productSc == ""
              ? Text(
                  'Please scan the product',
                  style: TextStyle(fontSize: 20),
                )
              : Row(
                  children: [
                    Text('QUANTITY'),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Enter Quantity",
                          hintStyle: TextStyle(
                              color: CustomColor.dimensionColor2,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        controller: quantityController,
                        keyboardType: TextInputType.name,
                        onSubmitted: (e) {
                          quantityController!.text = e;
                        },
                      ),
                    )
                  ],
                ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
