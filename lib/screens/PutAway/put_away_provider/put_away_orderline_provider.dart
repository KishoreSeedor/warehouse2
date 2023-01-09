import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/const/config.dart';
import 'package:warehouse/models/orders_line_model.dart';
import 'package:warehouse/screens/PutAway/put_away_model/putaway_orderline_model.dart';
import 'package:warehouse/screens/PutAway/utilites/putaway_snackbar.dart';
import 'package:warehouse/widgets/custom_alert_dialog.dart';

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
    return _orderlineLoading;
  }

  String _orderlIneErrorMessage = '';
  String get orderlIneErrorMessage {
    return _orderlIneErrorMessage;
  }

  Future<void> getAllorderLineProduct(
      {required BuildContext context, required String id}) async {
    try {
      _orderlineLoading = true;

      final user = Provider.of<UserDetails>(context, listen: false);
      userDetails.getAllDetails();
      List<PutawayOrderLineModel> _loaddata = [];
      _orderlineArrangement = [];
      var headers = {
        'Cookie':
            'session_id=a92b5a9151dc99504afb48b311aadcdbde48fd28; session_id=de84b687a95814d71089cdb547af129c7ed08e41'
      };

      var response = await http.get(
          Uri.parse(
              "$baseApiUrl/seedor-api/warehouse/put-way-items?clientid=${user.clientID}&fields={'id','location_barcode','location_dest_id','product_id','product_qty','x_sku_line_id'}&domain=[('putaway_upadted','!=',True),('picking_id','=',$id)]"),
          headers: headers);
      print(
          "$baseApiUrl/seedor-api/warehouse/put-way-items?clientid=${user.clientID}&domain=[('putaway_upadted','!=',True),('picking_id','=',$id)]");
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(response.body);

        var jsonData = json.decode(response.body);
        print(jsonData[0]['location_barcode'].toString() +
            '---->> LOCATION BARECODE');
        for (var i = 0; i < jsonData.length; i++) {
          _loaddata.add(PutawayOrderLineModel(
            id: jsonData[i]['id'].toString(),
            locationBarcode: jsonData[i]['location_barcode'].toString(),
            locationDest: jsonData[i]['location_dest_id'][0].toString(),
            locationDestinationName:
                jsonData[i]['location_dest_id'][1].toString(),
            productname: jsonData[i]['product_id'][1].toString(),
            quantity: jsonData[i]['product_qty'].toString(),
            productId: jsonData[i]['product_id'][0].toString(),
            skuId: jsonData[i]['x_sku_line_id'].toString(),
          ));
        }

        _allOrderLineProd = _loaddata;
        _orderlineLoading = false;
        await dataArrangement();
        notifyListeners();
      } else {
        _orderlineLoading = false;
        _orderlineErrorLoading = false;
        _orderlIneErrorMessage = "Something went wrong";
        notifyListeners();
      }
    } on HttpException {
      _orderlineLoading = false;
      _orderlineErrorLoading = false;
      _orderlIneErrorMessage = "No Service Found";
      notifyListeners();
    } on SocketException {
      _orderlineLoading = false;
      _orderlineErrorLoading = false;
      _orderlIneErrorMessage = "No Internet Connection";
      notifyListeners();
    } on FormatException {
      _orderlineLoading = false;
      _orderlineErrorLoading = false;
      _orderlIneErrorMessage = "Invalid Data Format";
      notifyListeners();
    } catch (e) {
      _orderlineLoading = false;
      _orderlineErrorLoading = false;
      _orderlIneErrorMessage = "Some thing went wtong";
      notifyListeners();
    }
  }

  List<String> locationDest = [];
  List<String> locationDestination = [];
  List<String> setLocationData = [];

  Future<dynamic> dataArrangement() async {
    _orderlineArrangement = [];
    locationDest = [];
    List<PutawayOrderLineModel> _orderLine = [];
    for (var i = 0; i < _allOrderLineProd.length; i++) {
      locationDest.add(_allOrderLineProd[i].locationDest);
      // print(_allOrderLineProd[i].locationDest + '--->> location');
    }
    setLocationData = locationDest.toSet().toList();
    // print(data.toList() + ['helloooooooo']);
    for (var i = 0; i < setLocationData.length; i++) {
      // print(data[i] + '--->> loop');
      for (var j = 0; j < _allOrderLineProd.length; j++) {
        if (setLocationData[i].toString() ==
            _allOrderLineProd[j].locationDest) {
          locationDestination.add(_allOrderLineProd[j].locationDestinationName);
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

  Future<dynamic> checkLocationApi(
      {required String locationId, required BuildContext context}) async {
    int statusCode = 0;
    try {
      userDetails.getAllDetails();
      var headers = {
        'Cookie':
            'session_id=9e669fcd0cf6534de56902a8eea6f1affce671ef; session_id=e2fc46ab8d73ddb088f3406a1ee387a52b0bcbb1; session_id=e225a41ff7edb32f8369305a02696814d78d3b90; session_id=971caadaba128adf8659d76b6b89c163b723df68'
      };
      var response = await http.get(
          Uri.parse(
              "$baseApiUrl/seedor-api/warehouse/location/list?clientid=${userDetails.clientID}&domain=[('barcode','=','$locationId')]&fields={'barcode'}"),
          headers: headers);

      print(
          "$baseApiUrl/seedor-api/warehouse/location/list?clientid=${userDetails.clientID}&domain=[('barcode','=','$locationId')]&fields={'barcode'}");
      var jsondata = json.decode(response.body);
      statusCode = response.statusCode;
      if (response.statusCode == 200) {
        if (jsondata.isEmpty) {
          return [205, 'nothing'];
        } else {
          return [response.statusCode, jsondata];
        }
      } else {
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
}
