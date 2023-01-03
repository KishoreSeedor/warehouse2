import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:warehouse/const/config.dart';
import 'package:warehouse/provider/login_details.provider.dart';
import 'package:warehouse/screens/Count/Count_model/count_customer_model.dart';
import 'package:warehouse/screens/Count/Count_model/count_total_id.dart';
import 'package:warehouse/widgets/custom_alert_dialog.dart';
import 'package:http/http.dart' as http;

class CustomerCountProvider with ChangeNotifier {
  UserDetails userDetails = UserDetails();
  List<CountCustomerModel> _allCustomerdata = [];
  List<CountCustomerModel> get allCustomerData {
    return _allCustomerdata;
  }

  bool _customerLoading = false;
  bool get customerLoading {
    return _customerLoading;
  }

  bool _customerErrorLoading = false;
  bool get customerErrorLoading {
    return _customerErrorLoading;
  }

  String _customerErrorScreen = '';
  String get customerErrorScreen {
    return _customerErrorScreen;
  }

  bool _countLoading = false;
  bool get coiuntLoading {
    return _countLoading;
  }

  bool _countErrorLoading = false;
  bool get countErrorLoading {
    return _countErrorLoading;
  }

  MyCustomAlertDialog customAlertDialog = MyCustomAlertDialog();

  Future<dynamic> getAllCustomerApi({required BuildContext context}) async {
    _customerLoading = true;
    try {
      await userDetails.getAllDetails();
      List<CountCustomerModel> _loadData = [];
      var headers = {
        'Cookie':
            'session_id=9e669fcd0cf6534de56902a8eea6f1affce671ef; session_id=e2fc46ab8d73ddb088f3406a1ee387a52b0bcbb1'
      };
      var response = await http.get(
          Uri.parse(
              "$baseApiUrl/seedor-api/warehouse/customer/list?clientid=${userDetails.clientID}&fields={'id','name'}"),
          headers: headers);
      print(response.statusCode);

      var jsonData = json.decode(response.body);
      // print(jsonData.length);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonData.length; i++) {
          // _loadData.add(CountCustomerModel(
          //     id: jsonData[i]['id'].toString(),
          //     name: jsonData[i]['name'].toString()));
        }
        print(_loadData.length);
        _allCustomerdata = _loadData;
        _customerLoading = false;
        print(_allCustomerdata.length);
        notifyListeners();
      } else {
        _customerLoading = false;
        _customerErrorLoading = true;
        _customerErrorScreen = "Something went wrong Cutomer";

        notifyListeners();
      }
    } on HttpException {
      _customerLoading = false;
      _customerErrorLoading = true;
      _customerErrorScreen = "No service found";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "No Service Found",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } on SocketException {
      _customerLoading = false;
      _customerErrorLoading = true;
      _customerErrorScreen = "No Internet connection";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "No Internet Connection",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } on FormatException {
      _customerLoading = false;
      _customerErrorLoading = true;
      _customerErrorScreen = "Invalid Data Format";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "Invalid Data Format",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } catch (e) {
      _customerLoading = false;
      _customerErrorLoading = true;
      _customerErrorScreen = "Something went wrong Cutomer";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "Something went wrong Customer",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });
    }
  }

  CountTotalModel? _countTotalModel;
  CountTotalModel? get countTotalModel {
    return _countTotalModel;
  }

  Future<dynamic> getCountforAllDetails(
      {required BuildContext context,
      required String apiName,
      required String id}) async {
    try {
      await userDetails.getAllDetails();
      _countLoading = true;
      var headers = {
        'Authorization': 'Bearer ocUHVoyTnMks1CmUFLLEqT4qNrUG7n',
      };
      _countTotalModel = null;
      String domain = '';
      if (apiName != 'total-warehouse') {
        domain = "&domain=[('id','=',$id)]";
      } else {
        domain = '';
      }
      var response = await http.get(
          Uri.parse(
              "$baseApiUrl/seedor-api/warehouse/$apiName/count?fields={'cnt_asn','cnt_grn','cnt_del','cnt_stock'}&clientid=${userDetails.clientID}$domain"),
          headers: headers);
      print(
          "$baseApiUrl/seedor-api/warehouse/$apiName/count?fields={'cnt_asn','cnt_grn','cnt_del','cnt_stock'}&clientid=${userDetails.clientID}$domain");
      print(response.body);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(jsonData[0]['cnt_asn'].toString());
        _countTotalModel = CountTotalModel(
            asn: jsonData[0]['cnt_asn'].toString(),
            grn: jsonData[0]['cnt_grn'].toString(),
            delivery: jsonData[0]['cnt_del'].toString(),
            inStock: jsonData[0]['cnt_stock'].toString(),
            id: jsonData[0]['id'].toString());
        print(_countTotalModel);
        _countLoading = false;
        notifyListeners();
      } else {
        _countLoading = false;
        _countErrorLoading = true;
        customAlertDialog.showCustomAlertdialog(
            context: context,
            title: 'Sorry',
            subtitle: "Something went wrong in count",
            onTapOkButt: () {
              Navigator.of(context).pop();
            });
      }
    } on HttpException {
      _countLoading = false;
      _countErrorLoading = true;
      customAlertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "No service found",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });

      notifyListeners();
    } on SocketException {
      _countLoading = false;
      _countErrorLoading = true;
      customAlertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "No internet connection",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "No Internet Connection",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } on FormatException {
      _countLoading = false;
      _countErrorLoading = true;
      customAlertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "Invalid Data Format",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });

      notifyListeners();
    } catch (e) {
      _countLoading = false;
      _countErrorLoading = true;
      customAlertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "Something went wrong in count",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    }
  }

  List<CountCustomerModel> searchQuery(String text) {
    var searchListData = _allCustomerdata
        .where((element) =>
            element.name.toLowerCase().contains(text.toLowerCase()))
        .toList();

    return searchListData;
  }

  Future<dynamic> inventryProductgetApi({required BuildContext context}) async {
    _customerLoading = true;
    try {
      await userDetails.getAllDetails();
      List<CountCustomerModel> _loadData = [];
      var headers = {
        'Cookie':
            'session_id=9e669fcd0cf6534de56902a8eea6f1affce671ef; session_id=e2fc46ab8d73ddb088f3406a1ee387a52b0bcbb1'
      };
      print(
          "$baseApiUrl/seedor-api/warehouse/inventory/list?clientid=${userDetails.clientID}&domain=['&',('state','!=','done'),('state','!=','cancel')]");

      var response = await http.get(
        Uri.parse(
            "$baseApiUrl/seedor-api/warehouse/inventory/list?clientid=${userDetails.clientID}&domain=['%26',('state','!=','done'),('state','!=','cancel')]"),
      );
      print(response.statusCode);

      var jsonData = json.decode(response.body);
      // print(jsonData.length);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonData.length; i++) {
          _loadData.add(CountCustomerModel(
            id: jsonData[i]['id'].toString(),
            name: jsonData[i]['display_name'].toString(),
            date: DateTime.parse('${jsonData[i]['date']}.000Z')
                .toLocal()
                .toString()
                .substring(0, 19)
                .toString(),
            status: jsonData[i]['state'].toString(),
          ));
        }
        print(_loadData.length);
        _allCustomerdata = _loadData;
        _customerLoading = false;
        print(_allCustomerdata.length);
        notifyListeners();
      } else {
        _customerLoading = false;
        _customerErrorLoading = true;
        _customerErrorScreen = "Something went wrong Cutomer";

        notifyListeners();
      }
    } on HttpException {
      _customerLoading = false;
      _customerErrorLoading = true;
      _customerErrorScreen = "No service found";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "No Service Found",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } on SocketException {
      _customerLoading = false;
      _customerErrorLoading = true;
      _customerErrorScreen = "No Internet connection";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "No Internet Connection",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } on FormatException {
      _customerLoading = false;
      _customerErrorLoading = true;
      _customerErrorScreen = "Invalid Data Format";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "Invalid Data Format",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } catch (e) {
      _customerLoading = false;
      _customerErrorLoading = true;
      _customerErrorScreen = "Something went wrong Cutomer";
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
