import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:warehouse/const/config.dart';
import 'package:warehouse/provider/login_details.provider.dart';
import 'package:warehouse/screens/Count/Count_model/customer_count_orderprod_model.dart';
import 'package:http/http.dart' as http;

class CustomerCountOrderProvider with ChangeNotifier {
  UserDetails userDetails = UserDetails();
  List<CustomerCountOrderProd> _allCustomerProdList = [];
  List<CustomerCountOrderProd> get allCustomerProdList {
    return _allCustomerProdList;
  }

  bool _customerProdLoading = false;
  bool get customerProdLoading {
    return _customerProdLoading;
  }

  String _customerProdErrorMessage = '';
  String get customerprodErrorMessage {
    return _customerProdErrorMessage;
  }

  bool _customerErrorLoading = false;
  bool get customerErrorLoading {
    return _customerErrorLoading;
  }

  Future<dynamic> getCustomerProdListApi({required String id}) async {
    try {
      _customerProdLoading = true;

      List<CustomerCountOrderProd> _loaddata = [];
      var headers = {
        'Cookie':
            'session_id=9e669fcd0cf6534de56902a8eea6f1affce671ef; session_id=e2fc46ab8d73ddb088f3406a1ee387a52b0bcbb1'
      };

      var response = await http.get(
          Uri.parse(
              "$baseApiUrl/seedor-api/warehouse/order/list?clientid=${userDetails.clientID}&domain=[('partner_id','=',$id)]&fields={'id','display_name','company_id','move_line_ids'}"),
          headers: headers);
      print(
          "$baseApiUrl/seedor-api/warehouse/order/list?clientid=${userDetails.clientID}&domain=[('partner_id','=',$id)]&fields={'id','display_name','company_id','move_line_ids'}");
      var jsonData = json.decode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonData.length; i++) {
          _loaddata.add(
            CustomerCountOrderProd(
                id: jsonData[i]['id'].toString(),
                companyName: jsonData[i]['company_id'][1].toString(),
                displayName: jsonData[i]['display_name'].toString(),
                moveLineIds: jsonData[i]['move_line_ids']),
          );
          print('----');
        }
        _allCustomerProdList = _loaddata;
        print(_allCustomerProdList);
        _customerProdLoading = false;
        notifyListeners();
      } else {
        _customerProdLoading = false;
        _customerErrorLoading = true;
        _customerProdErrorMessage = "Something went wrong";
      }
    } on HttpException {
      _customerProdLoading = false;
      _customerErrorLoading = true;
      _customerProdErrorMessage = "No service found";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "No Service Found",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } on SocketException {
      _customerProdLoading = false;
      _customerErrorLoading = true;
      _customerProdErrorMessage = "No Internet connection";
      // customAlertDialog.showCustomAlertdialog(
      //     context: context,
      //     title: 'Sorry',
      //     subtitle: "No Internet Connection",
      //     onTapOkButt: () {
      //       Navigator.of(context).pop();
      //     });

      notifyListeners();
    } on FormatException {
      _customerProdLoading = false;
      _customerErrorLoading = true;
      _customerProdErrorMessage = "Invalid Data Format";
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
      _customerProdLoading = false;
      _customerErrorLoading = true;
      _customerProdErrorMessage = "Something went wrong";
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
