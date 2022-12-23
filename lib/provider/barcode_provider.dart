import 'package:flutter/cupertino.dart';

class barcodeprovider with ChangeNotifier {
  String _barcodeValue = '';

  String get barCodeValue {
    return _barcodeValue;
  }

  set barcodeValuedata(String name) {
    _barcodeValue = name;
  }

  TextEditingController _controller = TextEditingController();

  TextEditingController get barcodecontrollerGet {
    return _controller;
  }

  set barcodeControllerSet(String name) {
    _controller.text = name;
  }
}
