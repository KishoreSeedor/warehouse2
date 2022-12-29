import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:warehouse/const/config.dart';
import 'package:warehouse/provider/login_details.provider.dart';
import 'package:warehouse/screens/Count/Count_model/inventry_product_model.dart';
import 'package:http/http.dart' as http;
import 'package:warehouse/screens/PutAway/utilites/putaway_snackbar.dart';
import 'package:warehouse/widgets/custom_alert_dialog.dart';

class InventryProductProvider with ChangeNotifier {
  UserDetails userDetails = UserDetails();
  MyCustomAlertDialog myCustomAlertDialog = MyCustomAlertDialog();
  List<InventryProductModel> _inventryProductData = [];

  List<InventryProductModel> get inventryProductData {
    return _inventryProductData;
  }

  bool _isloading = false;
  bool get isLoading {
    return _isloading;
  }

  bool _isErrorLoading = false;
  bool get isErrorLoading {
    return _isErrorLoading;
  }

  String _errormessage = '';
  String get errorMessage {
    return _errormessage;
  }

  Future<dynamic> invertProductLineItemsApi(
      {required String inventryId}) async {
    try {
      _isloading = true;
      await userDetails.getAllDetails();
      var headers = {
        'Cookie': 'session_id=9e669fcd0cf6534de56902a8eea6f1affce671ef'
      };
      List<InventryProductModel> _loaddata = [];

      var response = await http.get(
          Uri.parse(
              "$baseApiUrl/seedor-api/warehouse/inventory-lines/list?clientid=${userDetails.clientID}&domain=[('inventory_id','=',$inventryId)]&fields={'product_id','location_id','prod_lot_id','partner_id','product_qty','product_uom_id','inventory_id','display_name','theoretical_qty'}"),
          headers: headers);
      print(
          "$baseApiUrl/seedor-api/warehouse/inventory-lines/list?clientid=${userDetails.clientID}&domain=[('inventory_id','=',$inventryId)]&fields={'product_id','location_id','prod_lot_id','partner_id','product_qty','product_uom_id','inventory_id','display_name','theoretical_qty'}");
      var jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        for (var i = 0; i < jsonData.length; i++) {
          String partnerId = jsonData[i]['partner_id'].toString() == 'false'
              ? ''
              : jsonData[i]['partner_id'][0].toString();
          String partnername = jsonData[i]['partner_id'].toString() == 'false'
              ? ''
              : jsonData[i]['partner_id'][1].toString();
          String productLot = jsonData[i]['prod_lot_id'].toString() == 'false'
              ? ''
              : jsonData[i]['prod_lot_id'][1].toString();
          _loaddata.add(InventryProductModel(
            id: jsonData[i]['id'].toString(),
            location: jsonData[i]['location_id'][1].toString(),
            name: jsonData[i]['product_id'][1].toString(),
            quantityInHand: jsonData[i]['theoretical_qty'],
            partnerId: partnerId,
            partnerName: partnername,
            invertryId: jsonData[i]['inventory_id'][1].toString(),
            productQuantity: jsonData[i]['product_qty'],
            packUnit: jsonData[i]['product_uom_id'][1].toString(),
            productLot: productLot,
            textQuantity: 0.0,
          ));
        }
        _isloading = false;
        _inventryProductData = _loaddata;
        notifyListeners();
      } else {
        _isloading = false;
        _isErrorLoading = true;
        _errormessage = "Something went wrong";
      }
    } on HttpException {
      _isloading = false;
      _isErrorLoading = true;
      _errormessage = "No service found";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "No Service Found",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } on SocketException {
      _isloading = false;
      _isErrorLoading = true;
      _errormessage = "No Internet connection";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "No Internet Connection",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } on FormatException {
      _isloading = false;
      _isErrorLoading = true;
      _errormessage = "Invalid Data Format";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "Invalid Data Format",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } catch (e) {
      _isloading = false;
      _isErrorLoading = true;
      _errormessage = "Something went wrong Cutomer";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "Something went wrong Customer",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });
    }
  }

  Future<dynamic> inventryCountUpdate(
      {required BuildContext context,
      required String inventryId,
      required String count,
      required String reason,
      required String difference}) async {
    try {
      await userDetails.getAllDetails();
      var headers = {
        'Content-Type': 'application/json',
        'Cookie':
            'session_id=33312650586f7fb9b4f969e6223676a8ad4e95c9; session_id=e2fc46ab8d73ddb088f3406a1ee387a52b0bcbb1'
      };

      var body = json.encode({
        "id": inventryId,
        "counted": count,
        "reason": reason,
        "difference": difference,
        "verified_by": userDetails.id,
        "clientid": userDetails.clientID
      });
      print(body);
      var response = await http.put(
          Uri.parse("$baseApiUrl/seedor-api/warehouse/inventory-count/update"),
          headers: headers,
          body: body);
      if (response.statusCode == 200) {
        // Navigator.of(context).pop();
        showSnackBar(context: context, title: 'Successfully Updated');
      } else {
        myCustomAlertDialog.showCustomAlertdialog(
            context: context,
            title: 'Sorry',
            subtitle: 'Something went wrong',
            onTapOkButt: () {
              Navigator.of(context).pop();
            });
      }
    } catch (e) {
      myCustomAlertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: e.toString(),
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    }
  }

  Future<dynamic> inventryvalidationApi(
      {required BuildContext context, required String inventryId}) async {
    try {
      await userDetails.getAllDetails();
      var headers = {
        'Cookie':
            'session_id=33312650586f7fb9b4f969e6223676a8ad4e95c9; session_id=e2fc46ab8d73ddb088f3406a1ee387a52b0bcbb1'
      };
      var response = await http.post(
          Uri.parse(
              '$baseApiUrl/seedor-api/warehouse/validate/$inventryId?clientid=${userDetails.clientID}'),
          headers: headers);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        showSnackBar(context: context, title: 'Successfully validated');
      } else {
        myCustomAlertDialog.showCustomAlertdialog(
            context: context,
            title: 'Sorry',
            subtitle: jsonData['Details'] ?? 'Something went wrong',
            onTapOkButt: () {
              Navigator.of(context).pop();
            });
      }
    } catch (e) {
      myCustomAlertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: e.toString(),
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    }
  }
}
