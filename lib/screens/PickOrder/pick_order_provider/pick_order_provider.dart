import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:provider/provider.dart';
import 'package:warehouse/const/config.dart';
import 'package:warehouse/provider/login_details.provider.dart';
import 'package:warehouse/screens/PickOrder/pick_model/pick_order_lines_model.dart';

import '../../PutAway/put_away_model/putaway_orderline_model.dart';
import '../pick_model/pick_oder_model.dart';

class PickOrderProvider with ChangeNotifier {
  List<PickOrderModel> _pickOrder = [];

  List<PickOrderModel> get pickOrder {
    return _pickOrder;
  }

  List<PickLinesModel> _pickLine = [];
  List<PickLinesModel> get pickLine {
    return _pickLine;
  }

  bool _pickOrderLoading = false;

  bool get pickOrderLoading {
    return _pickOrderLoading;
  }

  bool _pickOrderErrorLoading = false;

  bool get pickOrderErrorLoading {
    return _pickOrderErrorLoading;
  }

  String _pickOrderErrorMessage = "";

  String get pickOrderErrorMessage {
    return _pickOrderErrorMessage;
  }

  Future<dynamic> pickOrderAPI({required BuildContext context}) async {
    try {
      _pickOrderLoading = true;
      notifyListeners();
      final user = Provider.of<UserDetails>(context, listen: false);
      await user.getAllDetails();
      List<PickOrderModel> getData = [];
      var headers = {
        'Cookie':
            'session_id=ad9b3d63d0f6e25ada8e6568cf58fa1a599002b9; session_id=e2fc46ab8d73ddb088f3406a1ee387a52b0bcbb1',
      };

      var url =
          "$baseApiUrl/seedor-api/warehouse/received-orders?fields={'x_clientno','id','scheduled_date','origin','display_name','date','partner_id','create_date','barcode'}&clientid=${user.clientID}&domain=[('picking_state','=','3')]";
      // &domain=[('custom_stage_id','=','Bin Allocation')]--->Add end late when values are confirmed
      var response = await https.get(Uri.parse(url), headers: headers);
      print(
          "pickOrderUrl--->$baseApiUrl/seedor-api/warehouse/received-orders?fields={'x_clientno','id','scheduled_date','origin','display_name','date','partner_id','create_date','barcode'}&clientid=${user.clientID}&domain=[('picking_state','=','3')]");
      var jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        print(response.body);
        for (var i = 0; i < jsonData.length; i++) {
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

          getData.add(PickOrderModel(
            barcode: jsonData[i]["barcode"].toString(),
            createDate: createddate,
            date: jsonData[i]["date"].toString(),
            displayName: jsonData[i]["display_name"].toString(),
            id: jsonData[i]["id"].toString(),
            origin: jsonData[i]["x_clientno"].toString(),
            partnerId: partnerId,
            companyName: companyName,
            scheduledDate: jsonData[i]["scheduled_date"].toString(),
            transportDate: jsonData[i]["transport_date"].toString(),
          ));
        }
        _pickOrder = getData;
        _pickOrderLoading = false;
        notifyListeners();
        return [response.statusCode, _pickOrder];
      } else {
        _pickOrderLoading = false;
        _pickOrderErrorLoading = false;
        _pickOrderErrorMessage = 'Somthing Went Wrong';
        notifyListeners();
      }
    } on HttpException {
      _pickOrderLoading = false;
      _pickOrderErrorLoading = false;
      _pickOrderErrorMessage = "No Service Found";

      notifyListeners();
    } on SocketException {
      _pickOrderLoading = false;
      _pickOrderErrorLoading = false;
      _pickOrderErrorMessage = "No Internet Connection";

      notifyListeners();
    } on FormatException {
      _pickOrderLoading = false;
      _pickOrderErrorLoading = false;
      _pickOrderErrorMessage = "Invalid Data Format";

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
