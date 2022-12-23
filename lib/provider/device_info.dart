import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';

class DeviceInformation extends ChangeNotifier {
  String _deviceId = "";
  String _deviceName = "";
  String get deviceID {
    return _deviceId;
  }

  String get deviceName {
    return _deviceName;
  }

  // ignore: non_constant_identifier_names
  Future InitPlatformStatus() async {
    try {
      if (Platform.isAndroid) {
        _deviceName = 'Android';
      } else if (Platform.isIOS) {
        _deviceName = "Ios";
      }
      _deviceId = (await PlatformDeviceId.getDeviceId)!;
    } on PlatformException {
      _deviceId = "faild to get device Id";
    }
  }
}
