import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:warehouse/const/config.dart';
import 'package:warehouse/provider/login_details.provider.dart';
import 'package:warehouse/screens/Count/Count_model/orderline_prod_model.dart';

class OrderLineProdProvider with ChangeNotifier {
  UserDetails userDetails = UserDetails();
  bool _orderlineProdLoading = false;
  bool get orderlineProdLoading {
    return _orderlineProdLoading;
  }

  bool _orderlineErrorLoading = false;
  bool get orderlineErrorLoading {
    return _orderlineErrorLoading;
  }

  String _orderlineError = '';
  String get orderlineError {
    return _orderlineError;
  }

  List<OrderLineProdModel> _orderLIneProduct = [];
  List<OrderLineProdModel> get orderLIneProduct {
    return _orderLIneProduct;
  }

  Future<dynamic> getOrderlineProdApi({required String id}) async {
    try {
      _orderlineProdLoading = true;

      List<OrderLineProdModel> _loadData = [];
      var headers = {
        'Cookie':
            'session_id=9e669fcd0cf6534de56902a8eea6f1affce671ef; session_id=e2fc46ab8d73ddb088f3406a1ee387a52b0bcbb1'
      };

      var response = await http.get(
          Uri.parse(
              "$baseApiUrl/seedor-api/warehouse/order-line/list?clientid=${userDetails.clientID}&domain=[('picking_id','=',$id)]"),
          headers: headers);
      print(
          "$baseApiUrl/seedor-api/warehouse/order-line/list?clientid=${userDetails.clientID}&domain=[('picking_id','=',$id)]");
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonData.length; i++) {
          String skudata = jsonData[i]['x_sku_id'].toString() == 'false'
              ? ''
              : jsonData[i]['x_sku_id'][1].toString();
          _loadData.add(OrderLineProdModel(
              id: jsonData[i]['id'].toString(),
              name: jsonData[i]['display_name'].toString(),
              createDate: jsonData[i]['create_date'].toString(),
              origin: jsonData[i]['origin'].toString(),
              companyName: jsonData[i]['company_id'][1].toString(),
              skuId: skudata));
        }
        _orderLIneProduct = _loadData;
        _orderlineProdLoading = false;
        notifyListeners();
      } else {
        _orderlineProdLoading = false;
        _orderlineErrorLoading = true;
        _orderlineError = "Something went wrong";
        notifyListeners();
      }
    } on HttpException {
      _orderlineProdLoading = false;
      _orderlineErrorLoading = true;
      _orderlineError = "No service found";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "No Service Found",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } on SocketException {
      _orderlineProdLoading = false;
      _orderlineErrorLoading = true;
      _orderlineError = "No Internet connection";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "No Internet Connection",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } on FormatException {
      _orderlineProdLoading = false;
      _orderlineErrorLoading = true;
      _orderlineError = "Invalid Data Format";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "Invalid Data Format",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } catch (e) {
      print(e);
      _orderlineProdLoading = false;
      _orderlineErrorLoading = true;
      _orderlineError = "Something went wrong";
      notifyListeners();
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "Something went wrong Customer",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });
    }
  }

  Future<dynamic> getOrderlineProdDetailsApi({required String id}) async {
    try {
      _orderlineProdLoading = true;
      await userDetails.getAllDetails();
      List<OrderLineProdModel> _loadData = [];
      var headers = {
        'Cookie':
            'session_id=9e669fcd0cf6534de56902a8eea6f1affce671ef; session_id=e2fc46ab8d73ddb088f3406a1ee387a52b0bcbb1'
      };

      var response = await http.get(
          Uri.parse(
              "$baseApiUrl/seedor-api/warehouse/order-line/list?clientid=${userDetails.clientID}&domain=[('picking_id','=',$id)]"),
          headers: headers);
      print(
          "$baseApiUrl/seedor-api/warehouse/order-line/list?clientid=${userDetails.clientID}&domain=[('picking_id','=',$id)]");
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonData.length; i++) {
          String skudata = jsonData[i]['x_sku_id'].toString() == 'false'
              ? ''
              : jsonData[i]['x_sku_id'][1].toString();
          _loadData.add(OrderLineProdModel(
              id: jsonData[i]['id'].toString(),
              name: jsonData[i]['display_name'].toString(),
              createDate: jsonData[i]['create_date'].toString(),
              origin: jsonData[i]['origin'].toString(),
              companyName: jsonData[i]['company_id'][1].toString(),
              skuId: skudata));
        }
        _orderLIneProduct = _loadData;
        _orderlineProdLoading = false;
        notifyListeners();
      } else {
        _orderlineProdLoading = false;
        _orderlineErrorLoading = true;
        _orderlineError = "Something went wrong";
        notifyListeners();
      }
    } on HttpException {
      _orderlineProdLoading = false;
      _orderlineErrorLoading = true;
      _orderlineError = "No service found";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "No Service Found",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } on SocketException {
      _orderlineProdLoading = false;
      _orderlineErrorLoading = true;
      _orderlineError = "No Internet connection";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "No Internet Connection",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } on FormatException {
      _orderlineProdLoading = false;
      _orderlineErrorLoading = true;
      _orderlineError = "Invalid Data Format";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "Invalid Data Format",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } catch (e) {
      print(e);
      _orderlineProdLoading = false;
      _orderlineErrorLoading = true;
      _orderlineError = "Something went wrong";
      notifyListeners();
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "Something went wrong Customer",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });
    }
  }
}
