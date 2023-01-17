import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/apis/uri_converter.dart';
import 'package:warehouse/const/config.dart';
import 'package:warehouse/models/orders_line_model.dart';
import 'package:warehouse/screens/PutAway/put_away_model/put_away_orderline_model.dart';
import 'package:warehouse/screens/PutAway/put_away_model/putaway_orderline_model.dart';
import 'package:warehouse/screens/PutAway/utilites/putaway_snackbar.dart';
import 'package:warehouse/widgets/custom_alert_dialog.dart';

import '../../../models/location_detail_model.dart';
import '../../../provider/login_details.provider.dart';
import 'package:http/http.dart' as http;

class PutAwayOrderLineProvid with ChangeNotifier {
  MyCustomAlertDialog customAlertDialog = MyCustomAlertDialog();
  UserDetails userDetails = UserDetails();
  List<PutawayOrderLineModel> _allOrderLineProd = [];
  List<PutawayOrderLineModel> get allOrderLineProd {
    return _allOrderLineProd;
  }

  List<List<PutawayOrderLineModel>> _orderlineArrangement = [];

  List<List<PutawayOrderLineModel>> get orderlineArrangement {
    return _orderlineArrangement;
  }

  bool _orderlineLoading = false;
  bool get orderlineLoading {
    return _orderlineLoading;
  }

  bool _orderlineErrorLoading = false;
  bool get orderlineErrorLoading {
    return _orderlineErrorLoading;
  }

  String _orderlIneErrorMessage = '';
  String get orderlIneErrorMessage {
    return _orderlIneErrorMessage;
  }

  Future<void> getAllorderLineProduct(
      {required BuildContext context, required String id}) async {
    try {
      _orderlineLoading = true;
      _orderlineErrorLoading = false;
      await userDetails.getAllDetails();
      List<PutawayOrderLineModel> _loaddata = [];
      _orderlineArrangement = [];
      var headers = {
        'Cookie':
            'session_id=a92b5a9151dc99504afb48b311aadcdbde48fd28; session_id=de84b687a95814d71089cdb547af129c7ed08e41'
      };

      var response = await http.get(
          Uri.parse(
              "$baseApiUrl/seedor-api/warehouse/put-way-items?clientid=${userDetails.clientID}&fields={'id','location_barcode','location_dest_id','product_id','product_qty','x_sku_line_id','result_package_id','qty_done','x_length','x_breadth','x_height','x_weight','x_volume'}&domain=[('putaway_upadted','!=',True),('picking_id','=',$id)]"),
          headers: headers);
      print(
          "$baseApiUrl/seedor-api/warehouse/put-way-items?clientid=${userDetails.clientID}&fields={'id','location_barcode','location_dest_id','product_id','product_qty','x_sku_line_id','result_package_id','qty_done','x_length','x_breadth','x_height','x_weight','x_volume'}&domain=[('putaway_upadted','!=',True),('picking_id','=',$id)]");
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(response.body);

        var jsonData = json.decode(response.body);
        print(jsonData[0]['location_barcode'].toString() +
            '---->> LOCATION BARECODE');

        for (var i = 0; i < jsonData.length; i++) {
          String palletDest =
              jsonData[i]['result_package_id'].toString() == "false"
                  ? ""
                  : jsonData[i]['result_package_id'][0].toString();
          String palletDestName =
              jsonData[i]['result_package_id'].toString() == "false"
                  ? "No pallet Assign"
                  : jsonData[i]['result_package_id'][1].toString();
          _loaddata.add(PutawayOrderLineModel(
            id: jsonData[i]['id'].toString(),
            locationBarcode: jsonData[i]['location_barcode'].toString(),
            palletDest: palletDest,
            palletDestinationName: palletDestName,
            productname: jsonData[i]['product_id'][1].toString(),
            quantity: jsonData[i]['qty_done'].toString(),
            productId: jsonData[i]['product_id'][0].toString(),
            skuId: jsonData[i]['x_sku_line_id'].toString(),
            prodBreath: jsonData[i]['x_breadth'],
            prodHeight: jsonData[i]['x_height'],
            prodlength: jsonData[i]['x_length'],
          ));
        }
        print(_allOrderLineProd.length.toString() +
            '------->>>> all product length');
        _allOrderLineProd = _loaddata;
        _orderlineLoading = false;
        await dataArrangement();
        notifyListeners();
      } else {
        _orderlineLoading = false;
        _orderlineErrorLoading = true;
        _orderlIneErrorMessage = "Something went wrong";
        notifyListeners();
      }
    } on HttpException {
      _orderlineLoading = false;
      _orderlineErrorLoading = true;
      _orderlIneErrorMessage = "No Service Found";
      notifyListeners();
    } on SocketException {
      _orderlineLoading = false;
      _orderlineErrorLoading = true;
      _orderlIneErrorMessage = "No Internet Connection";
      notifyListeners();
    } on FormatException {
      _orderlineLoading = false;
      _orderlineErrorLoading = true;
      _orderlIneErrorMessage = "Invalid Data Format";
      notifyListeners();
    } catch (e) {
      _orderlineLoading = false;
      _orderlineErrorLoading = true;
      _orderlIneErrorMessage = "Some thing went wtong";
      notifyListeners();
    }
  }

  List<String> locationDest = [];
  List<String> locationDestination = [];
  List<String> setLocationData = [];
  List<String> totalCBMpallet = [];

  Future<dynamic> dataArrangement() async {
    _orderlineArrangement = [];
    locationDest = [];
    setLocationData = [];
    locationDestination = [];
    List<PutawayOrderLineModel> _orderLine = [];
    for (var i = 0; i < _allOrderLineProd.length; i++) {
      locationDest.add(_allOrderLineProd[i].palletDest);
      print(_allOrderLineProd[i].palletDest + '--->> location');
    }
    setLocationData = locationDest.toSet().toList();
    print(setLocationData.toList() + ['helloooooooo']);
    for (var i = 0; i < setLocationData.length; i++) {
      print(setLocationData[i] + '--->> loop');
      for (var j = 0; j < _allOrderLineProd.length; j++) {
        if (setLocationData[i].toString() == _allOrderLineProd[j].palletDest) {
          // String calculation =
          //     "${int.parse(_allOrderLineProd[j].prodBreath) * int.parse(_allOrderLineProd[j].prodHeight) * int.parse(_allOrderLineProd[j].prodlength) / 1000} ";
          // String totalCBM =
          //     "${int.parse(calculation) * int.parse(_allOrderLineProd[i].quantity)}";
          locationDestination.add(_allOrderLineProd[j].palletDestinationName);
          locationDestination.toSet().toList();
          // totalCBMpallet.add(totalCBM);
          _orderLine.add(_allOrderLineProd[j]);

          print('---');
        }
      }
      print(_orderLine.length.toString() + '---->> data length');
      _orderlineArrangement.add(_orderLine);
      _orderLine = [];
    }
    print(_orderlineArrangement.length);
  }

  Future<dynamic> correctproductUpdateInpallet(
      {required BuildContext context, required String id}) async {
    try {
      var headers = {
        'Cookie':
            'session_id=a92b5a9151dc99504afb48b311aadcdbde48fd28; session_id=de84b687a95814d71089cdb547af129c7ed08e41'
      };
      await userDetails.getAllDetails();
      var response = await http.put(
          Uri.parse(
              '$baseApiUrl/seedor-api/warehouse/complete-put-away/$id?clientid=${userDetails.clientID}&verified_by=${userDetails.id}'),
          headers: headers);
      print(
          "$baseApiUrl/seedor-api/warehouse/complete-put-away/$id?clientid=${userDetails.clientID}&verified_by=${userDetails.id}");
      if (response.statusCode == 200) {
        await getAllorderLineProduct(context: context, id: id);
        showSnackBar(context: context, title: 'Successfully updated');
        Navigator.of(context).pop();
      } else {
        customAlertDialog.showCustomAlertdialog(
            context: context,
            title: 'Sorry',
            subtitle: 'Something went Wrong',
            onTapOkButt: () {
              Navigator.of(context).pop();
            });
      }
    } on HttpException {
      _orderlineLoading = false;
      _orderlineErrorLoading = false;
      customAlertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "No Service Found",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });

      notifyListeners();
    } on SocketException {
      _orderlineLoading = false;
      _orderlineErrorLoading = false;
      customAlertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "No Internet Connection",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });

      notifyListeners();
    } on FormatException {
      _orderlineLoading = false;
      _orderlineErrorLoading = false;
      customAlertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "Invalid Data Format",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });

      notifyListeners();
    }
  }

  Future<dynamic> wrongproductUpdateInPallet(
      {required BuildContext context,
      required String id,
      required String locationId}) async {
    try {
      await userDetails.getAllDetails();
      var headers = {
        'Cookie':
            'session_id=a92b5a9151dc99504afb48b311aadcdbde48fd28; session_id=de84b687a95814d71089cdb547af129c7ed08e41'
      };

      var response = await http.put(
          Uri.parse(
              '$baseApiUrl/seedor-api/warehouse/rearrange-bin/$id?clientid=${userDetails.clientID}&verified_by=${userDetails.id}&location_id=$locationId'),
          headers: headers);
      print(
          '$baseApiUrl/seedor-api/warehouse/rearrange-bin/$id?clientid=${userDetails.clientID}&verified_by=${userDetails.id}&location_id=$locationId');
      if (response.statusCode == 200) {
        await getAllorderLineProduct(context: context, id: id);
        showSnackBar(context: context, title: 'Successfully updated');

        Navigator.of(context).pop();
      } else {
        customAlertDialog.showCustomAlertdialog(
            context: context,
            title: 'Sorry',
            subtitle: 'Something went Wrong',
            onTapOkButt: () {
              Navigator.of(context).pop();
            });
      }
    } on HttpException {
      _orderlineLoading = false;
      _orderlineErrorLoading = false;
      customAlertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "No Service Found",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });

      notifyListeners();
    } on SocketException {
      _orderlineLoading = false;
      _orderlineErrorLoading = false;
      customAlertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "No Internet Connection",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });

      notifyListeners();
    } on FormatException {
      _orderlineLoading = false;
      _orderlineErrorLoading = false;
      customAlertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "Invalid Data Format",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });

      notifyListeners();
    }
  }

  Future<dynamic> getBarcodeWithProduct() async {
    try {} catch (e) {
      print(e);
    }
  }

  bool _locationLoading = false;
  bool get locationLoading {
    return _locationLoading;
  }

  Future<dynamic> checkLocationApi(
      {required String locationIds, required BuildContext context}) async {
    int statusCode = 0;
    try {
      _locationLoading = true;
      notifyListeners();
      userDetails.getAllDetails();
      var headers = {
        'Cookie':
            'session_id=9e669fcd0cf6534de56902a8eea6f1affce671ef; session_id=e2fc46ab8d73ddb088f3406a1ee387a52b0bcbb1; session_id=e225a41ff7edb32f8369305a02696814d78d3b90; session_id=971caadaba128adf8659d76b6b89c163b723df68'
      };
      var response = await http.get(
          Uri.parse(
              "$baseApiUrl/seedor-api/warehouse/location/list?clientid=${userDetails.clientID}&domain=[('barcode','=','$locationIds')]&fields={'barcode','name','occupied_volume','volume'}"),
          headers: headers);

      print(
          "$baseApiUrl/seedor-api/warehouse/location/list?clientid=${userDetails.clientID}&domain=[('barcode','=','$locationIds')]&fields={'barcode','name','occupied_volume','volume'}");
      var jsondata = json.decode(response.body);
      statusCode = response.statusCode;
      if (response.statusCode == 200) {
        if (jsondata.isEmpty) {
          _locationLoading = false;
          customAlertDialog.showCustomAlertdialog(
              context: context,
              onTapOkButt: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              title: 'Note',
              subtitle: 'Please scan the correct Location');
          notifyListeners();
          return [205, 'nothing'];
        } else {
          _locationLoading = false;
          notifyListeners();
          return [response.statusCode, jsondata];
        }
      } else {
        _locationLoading = false;
        notifyListeners();
        MyCustomAlertDialog().showCustomAlertdialog(
            context: context,
            title: 'Sorry',
            subtitle: jsondata['Details'] ?? 'Something went wrong',
            onTapOkButt: () {
              Navigator.of(context).pop();
            });
        return [205, 'nothing'];
      }
    } catch (e) {
      _locationLoading = false;
      notifyListeners();
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: 'Something went wrong',
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
      return [205, 'nothing'];
    }
  }

  LocationDetailModel _locationDetailModel = LocationDetailModel(
      id: "", totalCBMofLocation: 0.0, containCBMofLocation: 0.0, name: "");
  LocationDetailModel get locationDetailModel {
    return _locationDetailModel;
  }

  void clearlocationDetailModel() {
    _locationDetailModel = LocationDetailModel(
        containCBMofLocation: 0.0, id: "", name: "", totalCBMofLocation: 0.0);
    notifyListeners();
  }

  double locationPercentage = 0.0;
  String locationScanBalanceValue = "";

  locationscannerDialog({
    required BuildContext context,
  }) {
    MobileScannerController cameraController = MobileScannerController();
    Future<void> _getQRcode(
        Barcode qrCode, MobileScannerArguments? args) async {
      String barcode = qrCode.rawValue.toString();
      locationScanBalanceValue = "";
      print('qr code data value ------>>> $barcode');
      await cameraController.stop();

      await checkLocationApi(locationIds: barcode, context: context)
          .then((value) {
        if (value[0] == 200) {
          print(
              "${value[1][0]["occupied_volume"]} occupied volume  ${value[1][0]["volume"]} -------->>>>>>> location percentage");
          double volume =
              value[1][0]["volume"] == 0.0 ? 1 : value[1][0]["volume"];
          locationPercentage = (value[1][0]["occupied_volume"] / volume) * 100;

          print(
              "${(value[1][0]["occupied_volume"] / volume) * 100} -------->>>>>>> location percentage");
          print(value[1][0]["id"].toString() + '---------->>>> iddd');
          _locationDetailModel = LocationDetailModel(
              id: value[1][0]["id"].toString(),
              totalCBMofLocation: value[1][0]["volume"],
              containCBMofLocation: value[1][0]["occupied_volume"],
              name: value[1][0]["name"].toString());
          locationScanBalanceValue =
              "${value[1][0]["volume"] - value[1][0]["occupied_volume"]}";
          Navigator.of(context).pop();
          notifyListeners();
        }
      });

      print(barcode);
    }

    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Scan Location"),
            content: Container(
              height: 200,
              width: 300,
              child: MobileScanner(
                allowDuplicates: false,
                controller: cameraController,
                onDetect: _getQRcode,
              ),
            ),
          );
        });
  }

  List<PutawayOrderLineModel> _palletScanOrderLineModel = [];

  List<PutawayOrderLineModel> get palletScanOrderLineModel {
    return _palletScanOrderLineModel;
  }

  void clearpalletScanOrderLineModel() {
    _palletScanOrderLineModel = [];
    notifyListeners();
  }

  double _totalCbmOfProd = 0.0;

  double get totalCbmOfProd {
    return _totalCbmOfProd;
  }

  palletscannerDialog({
    required BuildContext context,
  }) {
    MobileScannerController cameraController = MobileScannerController();
    Future<void> _getQRcode(
        Barcode qrCode, MobileScannerArguments? args) async {
      String barcode = qrCode.rawValue.toString();
      print('qr code data value ------>>> $barcode');
      _palletScanOrderLineModel = [];
      await cameraController.stop();
      _totalCbmOfProd = 0.0;
      for (var j = 0; j < _allOrderLineProd.length; j++) {
        print(_allOrderLineProd[j].palletDestinationName +
            '----->> desnation name');
        if (barcode == _allOrderLineProd[j].palletDestinationName) {
          print(barcode +
              '||||-----|||' +
              _allOrderLineProd[j].palletDestinationName);
          String calculation =
              "${double.parse(_allOrderLineProd[j].prodBreath.toString()) * double.parse(_allOrderLineProd[j].prodHeight.toString()) * double.parse(_allOrderLineProd[j].prodlength.toString())} ";
          print(
              "${double.parse(_allOrderLineProd[j].prodBreath.toString())}  ${double.parse(_allOrderLineProd[j].prodHeight.toString())}  ${(double.parse(_allOrderLineProd[j].prodlength.toString()))} / 1000} ");
          String totalCBM =
              "${double.parse(calculation) * double.parse(_allOrderLineProd[j].quantity)}";
          print(
              "${double.parse(calculation)} + ${double.parse(_allOrderLineProd[j].quantity)}");
          _totalCbmOfProd += double.parse(totalCBM);

          // locationDestination.add(_allOrderLineProd[j].palletDestinationName);
          _palletScanOrderLineModel.add(_allOrderLineProd[j]);

          // totalCBMpallet.add(totalCBM);
          // _orderLine.add(_allOrderLineProd[j]);
          print(_totalCbmOfProd.toString() + '------->>> total cbm prod');
          print('---');
        }
      }

      Navigator.of(context).pop();
      notifyListeners();

      print(barcode);
    }

    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Scan Pallet"),
            content: Container(
              height: 200,
              width: 300,
              child: MobileScanner(
                allowDuplicates: false,
                controller: cameraController,
                onDetect: _getQRcode,
              ),
            ),
          );
        });
  }

  bool _locationUptBool = false;
  bool get locationUptBool {
    return _locationUptBool;
  }

  Future<dynamic> updateThePalletLocation({
    required BuildContext context,
    required String palletId,
    required String locationId,
    required String volume,
  }) async {
    try {
      _locationUptBool = true;
      notifyListeners();
      await userDetails.getAllDetails();
      var headers = {
        'Content-Type': 'application/json',
        'Cookie':
            'session_id=4549a63c0953dcb1c020ce2e79e0f6a75d4d0a64; session_id=486464445ef21244a65ffa34109a1afdd4dceec6'
      };
      var body = json.encode({
        "clientid": userDetails.clientID,
        "pallet_id": palletId,
        "location_id": locationId,
        "volume": volume
      });
      print(body);
      var response = await http.put(
          UriConverter(
              "$baseApiUrl/seedor-api/warehouse/update-pallet-location"),
          headers: headers,
          body: body);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        _palletScanOrderLineModel = [];
        _locationDetailModel = LocationDetailModel(
            id: "",
            totalCBMofLocation: 0.0,
            containCBMofLocation: 0.0,
            name: "");
        

        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showSnackBar(context: context, title: "Successfully Updated");
        _locationUptBool = false;
        notifyListeners();
      } else {
        customAlertDialog.showCustomAlertdialog(
            context: context,
            title: 'Sorry',
            subtitle: jsonData["Details"] ?? "Something went wrong",
            onTapOkButt: () {
              Navigator.of(context).pop();
            });
        _locationUptBool = false;
        notifyListeners();
      }
    } on HttpException {
      _locationUptBool = false;

      customAlertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "No Service Found",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });

      notifyListeners();
    } on SocketException {
      _locationUptBool = false;

      customAlertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "No Internet Connection",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });

      notifyListeners();
    } on FormatException {
      _locationUptBool = false;

      customAlertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "Invalid Data Format",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });

      notifyListeners();
    } catch (e) {
      customAlertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "Something went wrong",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
      _locationUptBool = false;
      notifyListeners();
    }
  }
}
