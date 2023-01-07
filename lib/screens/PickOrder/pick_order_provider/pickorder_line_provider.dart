import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:warehouse/screens/PutAway/utilites/putaway_snackbar.dart';

import '../../../const/config.dart';
import '../../../provider/login_details.provider.dart';
import '../../../widgets/custom_alert_dialog.dart';
import '../pick_model/pick_oder_model.dart';
import '../pick_model/pick_order_lines_model.dart';

class PickOrderLineProvider with ChangeNotifier {
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

  Future<dynamic> pickOrderLineAPI(
      {required BuildContext context, required String pickingId}) async {
    try {
      _pickOrderLoading = true;
      notifyListeners();
      final user = Provider.of<UserDetails>(context, listen: false);
      List<PickLinesModel> getData = [];
      await user.getAllDetails();

      var headers = {
        'Cookie':
            'session_id=ad9b3d63d0f6e25ada8e6568cf58fa1a599002b9; session_id=11f5121f566165d27cf73b9a28432ad6d0b3597b'
      };

      String clainedId = user.clientID;

      var url =
          "$baseApiUrl/seedor-api/warehouse/put-way-items?clientid=${user.clientID}&domain=[('putaway_upadted','!=',True),('picking_id','=',$pickingId)]";

      print(
          "order line -->$baseApiUrl/seedor-api/warehouse/put-way-items?clientid=${user.clientID}&domain=[('putaway_upadted','!=',True),('picking_id','=',$pickingId)]");

      http.Response response = await http.get(Uri.parse(url), headers: headers);
      var jsonData = json.decode(response.body);
      _orderlineArrangement = [];
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonData.length; i++) {
          String pickingPartnerId;
          String pickingPartnerName;
          String pickingId;
          String pickingName;
          if (jsonData[i]['picking_id'] == false) {
            pickingId = "";
            pickingName = "";
          } else {
            pickingId = jsonData[i]['picking_id'][0].toString();
            pickingName = jsonData[i]['picking_id'][1].toString();
          }
          getData.add(PickLinesModel(
            id: jsonData[i]['id'].toString(),
            locationDest: jsonData[i]['location_barcode'].toString(),
            locationDestinationName:
                jsonData[i]['location_id'][1].toString(),
            productId: jsonData[i]['product_id'][0].toString(),
            productname: jsonData[i]['product_id'][1].toString(),
            quantity: jsonData[i]['product_qty'].toString(),
            skuId: jsonData[i]['x_sku_line_id'].toString(),
            //             .floor()
            //             .toString(),
          ));
        }
        // pickingId: pickingId,
        //     pickingName: pickingName,
        //     locationId: jsonData[i]['location_dest_id'][0].toString(),
        //     locationDestNation: jsonData[i]['location_dest_id'][1].toString(),
        //     displayName: jsonData[i]['display_name'].toString(),
        //     userid:
        //     productId: jsonData[i]['product_id'][0].toString()
        // productName: jsonData[i]['product_id'][1].toString(),
        //     productOnQty:
        //         double.parse(jsonData[i]['product_uom_qty'].toString())
        //             .floor()
        //             .toString(),

        _pickLine = getData;
        await dataArrangement();

        _pickOrderLoading = false;
        notifyListeners();
        print(pickLine);
        return [response.body, _pickLine];
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
    }
  }

  List<String> locationDest = [];

  List<String> locationDestination = [];

  List<String> setLocationData = [];

  List<List<PickLinesModel>> _orderlineArrangement = [];

  List<List<PickLinesModel>> get orderlineArrangement {
    return _orderlineArrangement;
  }

  Future<dynamic> dataArrangement() async {
    _orderlineArrangement = [];

    locationDest = [];

    List<PickLinesModel> _orderLine = [];

    for (var i = 0; i < _pickLine.length; i++) {
      locationDest.add(_pickLine[i].locationDest);

      // print(_allOrderLineProd[i].locationDest + '--->> location');

    }

    setLocationData = locationDest.toSet().toList();

    // print(data.toList() + ['helloooooooo']);

    for (var i = 0; i < setLocationData.length; i++) {
      // print(data[i] + '--->> loop');

      for (var j = 0; j < _pickLine.length; j++) {
        if (setLocationData[i].toString() == _pickLine[j].locationDest) {
          locationDestination.add(_pickLine[j].locationDestinationName);

          _orderLine.add(_pickLine[j]);

          print('---');
        }
      }

      print(_orderLine.length.toString() + '---->> data length');

      _orderlineArrangement.add(_orderLine);

      _orderLine = [];
    }

    print(_orderlineArrangement.length);
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

  MyCustomAlertDialog customAlertDialog = MyCustomAlertDialog();
  UserDetails userDetails = UserDetails();

  Future<dynamic> updateProductTopick(
      {required BuildContext context,
      required String id,
      required String locationid}) async {
    try {
      userDetails.getAllDetails();
      var headers = {
        'Cookie':
            'session_id=a92b5a9151dc99504afb48b311aadcdbde48fd28; session_id=e2fc46ab8d73ddb088f3406a1ee387a52b0bcbb1'
      };

      var response = await http.put(
          Uri.parse(
              '$baseApiUrl/seedor-api/warehouse/rearrange-bin/$id?clientid=${userDetails.clientID}&verified_by=2&location_id=8'),
          headers: headers);
      print(
          '$baseApiUrl/seedor-api/warehouse/rearrange-bin/$id?clientid=${userDetails.clientID}&verified_by=2&location_id=8');
      if (response.statusCode == 200) {
        showSnackBar(context: context, title: 'Successfully Updated');
        Navigator.of(context).pop();
      } else {
        _orderlineLoading = false;
        _orderlineErrorLoading = false;
        customAlertDialog.showCustomAlertdialog(
            context: context,
            title: 'Sorry',
            subtitle: "Something went wrong",
            onTapOkButt: () {
              Navigator.of(context).pop();
            });

        notifyListeners();
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
    } catch (e) {
      _orderlineLoading = false;
      _orderlineErrorLoading = false;
      customAlertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "Something went wrong",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
      notifyListeners();
    }
  }
}
