import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:warehouse/const/config.dart';
import 'package:warehouse/screens/PutAway/put_away_model/put_away_orderline_model.dart';
import 'package:warehouse/screens/PutAway/utilites/putaway_snackbar.dart';

import '../../../provider/login_details.provider.dart';

class PutAwayProvider with ChangeNotifier {
  List<PutAwayOrdersModel> _putAwayOrderLine = [];
  UserDetails userDetails = UserDetails();

  List<PutAwayOrdersModel> get putAwayOrderLine {
    return _putAwayOrderLine;
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

  Future<dynamic> putAwayLineApi({required BuildContext context}) async {
    try {
      _orderlineLoading = true;

      final user = Provider.of<UserDetails>(context, listen: false);

      List<PutAwayOrdersModel> loadData = [];
      var headers = {
        'Cookie':
            'session_id=a92b5a9151dc99504afb48b311aadcdbde48fd28; session_id=e2fc46ab8d73ddb088f3406a1ee387a52b0bcbb1'
      };

      var response = await http.get(
          Uri.parse(
              "$baseApiUrl/seedor-api/warehouse/received-orders?fields={'id','scheduled_date','origin','display_name','date','partner_id','create_date','barcode'}&clientid=${user.clientID}&domain=['%26',('picking_state','=','2'),('state','!=','done')]"),
          headers: headers);
      print(
          "$baseApiUrl/seedor-api/warehouse/received-orders?fields={'id','scheduled_date','origin','display_name','date','partner_id','create_date','barcode'}&clientid=${user.clientID}&domain=['%26',('picking_state','=','2'),('state','!=','done')]");
      var jsonData = json.decode(response.body);
      // print(jsonData['location_barcode'].toString());
      if (response.statusCode == 200) {
        print(response.body);
        print(jsonData.length);
        for (var i = 0; i < jsonData.length; i++) {
          print('----- ${jsonData[i]["date"].toString()}');
          String partnerId;
          String companyName;
          if (jsonData[i]["partner_id"] == false) {
            partnerId = '';
            companyName = '';
          } else {
            partnerId = jsonData[i]["partner_id"][0].toString();
            companyName = jsonData[i]["partner_id"][1].toString();
          }
          String createddate =
              DateTime.parse('${jsonData[i]['create_date']}.000Z')
                  .toLocal()
                  .toString()
                  .substring(0, 19);

          loadData.add(PutAwayOrdersModel(
            barcode: jsonData[i]["barcode"].toString(),
            createDate: createddate,
            date: jsonData[i]["date"].toString(),
            displayName: jsonData[i]["display_name"].toString(),
            id: jsonData[i]["id"].toString(),
            origin: jsonData[i]["origin"].toString(),
            partnerId: partnerId,
            companyName: companyName,
            scheduledDate: jsonData[i]["scheduled_date"].toString(),
            transportDate: jsonData[i]["transport_date"].toString(),
            skuId: jsonData[0]['x_sku_id'].toString(),
          ));

          print('partner--> ${loadData[i].partnerId.toString()}');
        }

        _putAwayOrderLine = loadData;
        print(_putAwayOrderLine.length.toString() + "---> fav data length");
        _orderlineLoading = false;
        notifyListeners();
        print('NNNNNN' + loadData.toString());
        // notifyListeners();

        return [response.statusCode, _putAwayOrderLine];
      } else {
        _orderlineLoading = false;
        _orderlineErrorLoading = false;
        _orderlIneErrorMessage = "Something went Wrong";
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
      print(e);
      _orderlineLoading = false;
      _orderlineErrorLoading = false;
      _orderlIneErrorMessage = "Some thing went wtong";
      notifyListeners();
      return [400, _putAwayOrderLine];
    }
  }

  Future<dynamic> validateApi(
      {required BuildContext context, required String lineId}) async {
    try {
      await userDetails.getAllDetails();
      var headers = {
        'Cookie':
            'session_id=e225a41ff7edb32f8369305a02696814d78d3b90; session_id=971caadaba128adf8659d76b6b89c163b723df68'
      };
      var response = await http.post(
          Uri.parse(
              "$baseApiUrl/seedor-api/warehouse/move-to-done/$lineId?clientid=${userDetails.clientID}"),
          headers: headers);
      print(
          "$baseApiUrl/seedor-api/warehouse/move-to-done/$lineId?clientid=${userDetails.clientID}");
      var jsondata = json.decode(response.body);
      if (response.statusCode == 200) {
        await putAwayLineApi(context: context);
        Navigator.of(context).pop();
        showSnackBar(context: context, title: 'Successfully Updated');
      } else {
        showSnackBar(
            context: context,
            title: jsondata['Details'] ?? 'Something went wrong');
      }
    } catch (e) {
      showSnackBar(context: context, title: 'Something went wrong in validate');
    }
  }
}
