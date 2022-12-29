import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/screens/Count/Count_model/count_total_id.dart';
import '../../../provider/login_details.provider.dart';
import 'package:http/http.dart' as https;

class CountTotalIdProvider with ChangeNotifier {
  CountTotalModel? _countTotalId;
  CountTotalModel? get countTotalId {
    return _countTotalId;
  }

  bool _countIdLoading = false;

  bool get countIdLoading {
    return _countIdLoading;
  }

  bool _countIdErrorLoading = false;

  bool get countIdErrorLoading {
    return _countIdErrorLoading;
  }

  String _countIdErrorMessage = "";

  String get countIdErrorMessage {
    return _countIdErrorMessage;
  }

  Future<dynamic> countTotalIdAPI({required BuildContext context}) async {
    try {
      _countIdLoading = true;
      notifyListeners();
      final user = Provider.of<UserDetails>(context, listen: false);
      await user.getAllDetails();
      var claindId = user.id;
      CountTotalModel getData;

      var headers = {
        'Authorization': 'Bearer ocUHVoyTnMks1CmUFLLEqT4qNrUG7n',
        'Cookie':
            'session_id=5222bbbd6d66229d64474280d7bdef7c1cb1774a; session_id=456c40bb7246801f79c86650cccf21d2a1faba15; session_id=979e2b49ada8464782a173191beb70b7a0d90f87; session_id=56d5057ca65b87b87d09b3800dcb46425bcd1423; session_id=b6d1c0a9b10124f4ea57a8332583d7e438371d76; session_id=1490008fff06052c41c317dc500d97eefadbe038; session_id=4349e557e7a47f8cf300bb34957203b651c285b5; session_id=4349e557e7a47f8cf300bb34957203b651c285b5; session_id=9e669fcd0cf6534de56902a8eea6f1affce671ef; session_id=e2fc46ab8d73ddb088f3406a1ee387a52b0bcbb1'
      };
      var url =
          "http://eiuat.seedors.com:8290/seedor-api/warehouse/total-warehouse/count?fields={'cnt_asn','cnt_grn','cnt_del','cnt_stock'}&clientid=$claindId";
      var response = await https.get(Uri.parse(url), headers: headers);
      print(
          "countTotalId-->http://eiuat.seedors.com:8290/seedor-api/warehouse/total-warehouse/count?fields={'cnt_asn','cnt_grn','cnt_del','cnt_stock'}&clientid=$claindId");
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        getData = (CountTotalModel(
          asn: jsonData[0]["cnt_asn"].toString(),
          grn: jsonData[0]["cnt_grn"].toString(),
          delivery: jsonData[0]["cnt_del"].toString(),
          inStock: jsonData[0]["cnt_stock"].toString(),
          id: jsonData[0]["id"].toString(),
        ));
        _countTotalId = getData;
        _countIdLoading = false;
        notifyListeners();
        return [response.statusCode, _countTotalId];
      } else {
        _countIdLoading = false;
        _countIdErrorLoading = false;
        _countIdErrorMessage = 'Somthing Went Wrong';
        notifyListeners();
      }
    } on HttpException {
      _countIdLoading = false;
      _countIdErrorLoading = false;
      _countIdErrorMessage = "No Service Found";

      notifyListeners();
    } on SocketException {
      _countIdLoading = false;
      _countIdErrorLoading = false;
      _countIdErrorMessage = "No Internet Connection";

      notifyListeners();
    } on FormatException {
      _countIdLoading = false;
      _countIdErrorLoading = false;
      _countIdErrorMessage = "Invalid Data Format";

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
