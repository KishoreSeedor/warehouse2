import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:warehouse/apis/uri_converter.dart';
import 'package:warehouse/const/config.dart';
import 'package:warehouse/models/pallet_name_model.dart';
import 'package:warehouse/models/pallet_particular_model.dart';
import 'package:warehouse/provider/login_details.provider.dart';
import 'package:warehouse/screens/PutAway/utilites/putaway_snackbar.dart';
import 'package:warehouse/screens/Receive/pallet_allocation/product_update_screen.dart';
import 'package:warehouse/screens/Receive/pallet_allocation/scan_pallet_alert.dart';
import 'package:warehouse/widgets/custom_alert_dialog.dart';

import '../../PutAway/put_away_model/putaway_orderline_model.dart';

class RecivePalletProvider with ChangeNotifier {
  String _palletName = "";
  String get palletName {
    return _palletName;
  }

  set setPalletName(String palletName) {
    _palletName = palletName;
  }

  bool _mobileScannerEnable = false;
  bool get mobileScannerEnable {
    return _mobileScannerEnable;
  }

  set setmobileScannerEnable(bool val) {
    _mobileScannerEnable = val;
  }

  /// platte scan barcode
  String _palletScanBarcode = "";

  String get palletScanBarcode {
    return _palletScanBarcode;
  }

  set setPalletScanBarcode(String name) {
    _palletScanBarcode = name;
  }

  ///
  UserDetails userDetails = UserDetails();

  bool _palletLoading = false;
  bool get palletLoading {
    return _palletLoading;
  }

  bool _palleterrorLoading = false;

  bool get palletErrorLoading {
    return _palleterrorLoading;
  }

  String _errorMessage = '';
  String get errorLoading {
    return _errorMessage;
  }

  List<RecivePalletNameModel> _allPalletName = [];

  List<RecivePalletNameModel> get allPalletname {
    return _allPalletName;
  }

  Future<dynamic> palletListApi({required BuildContext context}) async {
    try {
      _palletLoading = true;
      _palleterrorLoading = false;
      _errorMessage = "";
      List<RecivePalletNameModel> _loadData = [];

      await userDetails.getAllDetails();
      var headers = {
        'Cookie': 'session_id=971caadaba128adf8659d76b6b89c163b723df68'
      };

      var response = await http.get(
          UriConverter(
              "$baseApiUrl/seedor-api/warehouse/pallet-type/list?clientid=${userDetails.clientID}&fields={'id','name'}"),
          headers: headers);
      var jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        for (var i = 0; i < jsonData.length; i++) {
          _loadData.add(RecivePalletNameModel(
              id: jsonData[i]["id"].toString(),
              name: jsonData[i]["name"].toString()));
        }

        _allPalletName = _loadData;
        _palletLoading = false;

        notifyListeners();
      } else {
        _palletLoading = false;
        _palleterrorLoading = true;
        _errorMessage = jsonData["Details"] ?? "Something went wrong";

        notifyListeners();
      }
    } on HttpException {
      _palletLoading = false;
      _palleterrorLoading = true;
      _errorMessage = "No Service Found";

      notifyListeners();
    } on SocketException {
      _palletLoading = false;
      _palleterrorLoading = true;
      _errorMessage = "No Internet Connection";

      notifyListeners();
    } on FormatException {
      _palletLoading = false;
      _palleterrorLoading = true;
      _errorMessage = "Invalid Data Format";

      notifyListeners();
    } catch (e) {
      _palletLoading = false;
      _palleterrorLoading = true;
      _errorMessage = "Something went wrong";

      notifyListeners();
    }
  }

  List<PutawayOrderLineModel> _allOrderLineProd = [];
  List<PutawayOrderLineModel> get allOrderLineProd {
    return _allOrderLineProd;
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
      {required BuildContext context,
      required String id,
      String? prodId}) async {
    try {
      _orderlineLoading = true;

      await userDetails.getAllDetails();
      List<PutawayOrderLineModel> _loaddata = [];
      String domain = prodId == null ? "" : ",('product_id','=',$prodId)";
      var headers = {
        'Cookie':
            'session_id=a92b5a9151dc99504afb48b311aadcdbde48fd28; session_id=de84b687a95814d71089cdb547af129c7ed08e41'
      };

      var response = await http.get(
          Uri.parse(
              "$baseApiUrl/seedor-api/warehouse/put-way-items?clientid=${userDetails.clientID}&fields={'id','location_barcode','location_dest_id','product_id','product_qty','x_sku_line_id','x_sku_id','qty_done','result_package_id','x_length','x_breadth','x_height','x_weight','x_volume'}&domain=[('putaway_upadted','!=',True),('picking_id','=',$id)$domain]"),
          headers: headers);
      print(
          "$baseApiUrl/seedor-api/warehouse/put-way-items?clientid=${userDetails.clientID}&fields={'id','location_barcode','location_dest_id','product_id','product_qty','x_sku_line_id','x_sku_id','qty_done','result_package_id','x_length','x_breadth','x_height','x_weight','x_volume'}&domain=[('putaway_upadted','!=',True),('picking_id','=',$id)$domain]");
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(response.body);

        var jsonData = json.decode(response.body);
        print(jsonData[0]['location_barcode'].toString() +
            '---->> LOCATION BARECODE');
        for (var i = 0; i < jsonData.length; i++) {
          String palletName =
              jsonData[i]['result_package_id'].toString() == "false"
                  ? "Pallet Not Assigned"
                  : jsonData[i]['result_package_id'][1].toString();
          _loaddata.add(PutawayOrderLineModel(
            id: jsonData[i]['id'].toString(),
            locationBarcode: jsonData[i]['location_barcode'].toString(),
            palletDest: jsonData[i]['location_dest_id'][0].toString(),
            palletDestinationName: palletName,

            productname: jsonData[i]['product_id'][1].toString(),
            quantity: jsonData[i]['qty_done'].toString(),
            productId: jsonData[i]['product_id'][0].toString(),
            skuId: jsonData[i]['x_sku_id'][1].toString(),
            prodBreath:  jsonData[i]['x_breadth'],
            prodHeight:  jsonData[i]['x_height'],
            prodlength:  jsonData[i]['x_length'],
          ));
        }

        _allOrderLineProd = _loaddata;
        print(_allOrderLineProd.length.toString() +
            '----->>>>> _all orderline prod length');
        _orderlineLoading = false;

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
      print(e.toString() + '--------->>>>> error message');
      _orderlineLoading = false;
      _orderlineErrorLoading = true;
      _orderlIneErrorMessage = "Some thing went wtong";
      notifyListeners();
    }
  }

  bool _createPalletLoading = false;

  bool get createPalletLoading {
    return _createPalletLoading;
  }

  String _createPalletError = "";
  String get createPalletError {
    return createPalletError;
  }

  Future<dynamic> createpalletApi({
    required String palletType,
    required String name,
  }) async {
    int statusCode = 0;
    _createPalletError = "";
    try {
      _palletName = "";
      _palletLoading = true;
      await userDetails.getAllDetails();
      var headers = {
        'Content-Type': 'application/json',
        'Cookie':
            'session_id=7b0a33157a6184c6019bd9ba6f7a5b8a907049bf; session_id=d6cb2da7245cf10957955b7d3e69faf47211e186; session_id=bf9906c7d125f65ef5d1994900d47197b750deac'
      };
      var body = json.encode({
        "clientid": userDetails.clientID,
        "pallet_type": palletType,
        "name": name
      });
      print(body);
      var response = await http.post(
          UriConverter("$baseApiUrl/seedor-api/warehouse/pallet/create"),
          headers: headers,
          body: body);
      print("$baseApiUrl/seedor-api/warehouse/pallet/create");
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        _palletName = jsonData["Id"].toString();

        _palletLoading = false;
        notifyListeners();
        return [response.statusCode, jsonData["Id"].toString()];
      } else {
        _palletLoading = false;
        _createPalletError = jsonData["Details"] ?? "Something went wrong";
        notifyListeners();
        // MyCustomAlertDialog().showCustomAlertdialog(
        //     context: context,
        //     title: "Sorry",
        //     subtitle: jsonData["Details"] ?? "Something went wrong",
        //     onTapOkButt: () {
        //       Navigator.of(context).pop();
        //     });
        return [
          response.statusCode,
          jsonData["Details"] ?? "Something went wrong"
        ];
      }
    } catch (e) {
      _palletLoading = false;
      _createPalletError = "Something went wrong";
      notifyListeners();
      return [statusCode, "Something went wrong"];
    }
  }

  String _selectedPalletName = "";
  String get selectedPalletName {
    return _selectedPalletName;
  }

  palletScanDialog(
      {required BuildContext context,
      required List<RecivePalletNameModel> allPallet,
      required String pickingId}) {
    print('--------->>>>>>>>picking Id value $pickingId');
    // final data = Provider.of<RecivePalletProvider>(context, listen: false);
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Create Pallet'),
            content: Wrap(
              children: List.generate(allPallet.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    mobilescannerDialog(
                        context: context,
                        name: allPallet[index].id,
                        pickingId: pickingId);
                    _selectedPalletName = allPallet[index].id;
                    notifyListeners();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(allPallet[index].name),
                  ),
                );
              }),
            ),
            // actions: [
            //   ElevatedButton(
            //       onPressed: () {
            //         Navigator.of(context).pop();
            //       },
            //       child: const Text('Ok')),
            // ],
          );
        });
  }

  String _locationBarcodeScan = "";
  String get locationBarcodeScan {
    return _locationBarcodeScan;
  }

  set setLocationBarcodeScan(String value) {
    _locationBarcodeScan = value;
  }

  mobilescannerDialog(
      {required BuildContext context,
      required String name,
      required String pickingId}) {
    MobileScannerController cameraController = MobileScannerController();
    Future<void> _getQRcode(
        Barcode qrCode, MobileScannerArguments? args) async {
      String barcode = qrCode.rawValue.toString();
      print('qr code data value ------>>> $barcode');
      await cameraController.stop();
      createpalletApi(
        palletType: _selectedPalletName,
        name: barcode,
      ).then((value) async {
        if (value[0] == 200) {
          _locationBarcodeScan = barcode;
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => ScanUpdateProductScreen(
                    pickingId: pickingId,
                  )));
          notifyListeners();
        } else {
          // Navigator.of(context).pop();
          // // _locationBarcodeScan = "location wrong please change";
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (ctx) => ScanUpdateProductScreen(
          //           pickingId: pickingId,
          //         )));
          MyCustomAlertDialog().showCustomAlertdialog(
              context: context,
              title: 'Sorry',
              subtitle: value[1].toString(),
              onTapOkButt: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
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

  String _barcodeCreatedId = "";

  String get barcodeCreateDId {
    return _barcodeCreatedId;
  }

  ParticularProductModel? _particularProductModel;
  ParticularProductModel? get particularProductModel {
    return _particularProductModel;
  }

  void clearparticularModelData() {
    _particularProductModel = null;
    notifyListeners();
  }

  Future<dynamic> particularOrderLineProd(
      {required BuildContext context,
      required String skuId,
      required String pickingId}) async {
    try {
      await userDetails.getAllDetails();
      _particularProductModel = null;
      var headers = {
        'Cookie': 'session_id=0f8b8670c9d9d484082c247ff094c0c7e4a0cddb'
      };

      var response = await http.get(
          UriConverter(
              "$baseApiUrl/seedor-api/warehouse/put-way-items?clientid=${userDetails.clientID}&fields={'id','location_barcode','location_dest_id','product_id','product_qty','x_sku_line_id','result_package_id','qty_done','picking_id','product_uom_id','location_id','serial','move_id','x_sku_id'}&domain=[('picking_id','=',$pickingId),('x_sku_id','=','$skuId'),('result_package_id','=',False)]"),
          headers: headers);
      print(
          "$baseApiUrl/seedor-api/warehouse/put-way-items?clientid=${userDetails.clientID}&fields={'id','location_barcode','location_dest_id','product_id','product_qty','x_sku_line_id','result_package_id','qty_done','picking_id','product_uom_id','location_id','serial','move_id','x_sku_id'}&domain=[('picking_id','=',$pickingId),('x_sku_id','=','$skuId'),('result_package_id','=',False)]");
      var jsonData = json.decode(response.body);
      String result = jsonData[0]["result_package_id"].toString() == "false"
          ? "no"
          : jsonData[0]["result_package_id"][0].toString();
      if (response.statusCode == 200) {
        if (result != "no") {
          print('product is allocated already');
          // Navigator.of(context).pop();
          MyCustomAlertDialog().showCustomAlertdialog(
              context: context,
              title: "Note",
              subtitle: "This product already allocated",
              onTapOkButt: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
        } else {
          _particularProductModel = ParticularProductModel(
              id: jsonData[0]['id'].toString(),
              productName: jsonData[0]['product_id'][1].toString(),
              locationBarcode: jsonData[0]['location_barcode'].toString(),
              locationDestinationId:
                  jsonData[0]['location_dest_id'][0].toString(),
              locationDestName: jsonData[0]['location_dest_id'][1].toString(),
              locationId: jsonData[0]['location_id'][0].toString(),
              pickingId: jsonData[0]['picking_id'][0].toString(),
              productId: jsonData[0]['product_id'][0].toString(),
              productUomId: jsonData[0]['product_uom_id'][0].toString(),
              resultpackageid: jsonData[0]['result_package_id'],
              skuLineId: jsonData[0]['x_sku_id'][1].toString(),
              quantity: jsonData[0]['qty_done'],
              isSerial: jsonData[0]["serial"],
              moveId: jsonData[0]["move_id"][0].toString());
          Navigator.of(context).pop();
          print('');
          notifyListeners();
        }
      } else {
        MyCustomAlertDialog().showCustomAlertdialog(
            context: context,
            title: 'Sorry',
            subtitle: jsonData["Details"] ?? "Something went wrong",
            onTapOkButt: () {
              Navigator.of(context).pop();
            });
      }
    } catch (e) {
      print(e.toString());
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "Something went wrong",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    }
  }

  productScannerDialog(
      {required BuildContext context, required String pickingId}) {
    MobileScannerController cameraController = MobileScannerController();
    Future<void> _getQRcode(
        Barcode qrCode, MobileScannerArguments? args) async {
      String barcode = qrCode.rawValue.toString();
      await cameraController.stop();
      String test = "";
      for (var i = 0; i < _allOrderLineProd.length; i++) {
        if (_allOrderLineProd[i].skuId == barcode) {
          test = "val";
          await particularOrderLineProd(
                  context: context, skuId: barcode, pickingId: pickingId)
              .then((value) {
            // Navigator.of(context).pop();
          });

          break;
        }
      }
      if (test == "") {
        MyCustomAlertDialog().showCustomAlertdialog(
            context: context,
            title: 'Note',
            subtitle: 'Please scan correct product',
            onTapOkButt: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            });
      }

      print('qr code data value prod ------>>> $barcode');
      // await cameraController.stop();

      print(barcode);
    }

    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Scan Product"),
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

  TextEditingController _serialnumberId = TextEditingController();

  TextEditingController get serialNumberId {
    return _serialnumberId;
  }

  set setSerialNumberId(String serialId) {
    _serialnumberId.text = serialId;
  }

  serialNumScannerDialog({
    required BuildContext context,
  }) {
    MobileScannerController cameraController = MobileScannerController();
    Future<void> _getQRcode(
        Barcode qrCode, MobileScannerArguments? args) async {
      String barcode = qrCode.rawValue.toString();

      print('qr code data value serial value ------>>> $barcode');
      // await cameraController.stop();
      _serialnumberId.text = barcode;
      Navigator.of(context).pop();
      print(barcode);
    }

    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Scan Serial Number"),
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

  bool _serialLoading = false;
  bool get serialLoading {
    return _serialLoading;
  }

  Future<dynamic> updateSerialNumApi(
      {required String moveId,
      required String serialNum,
      required BuildContext context}) async {
    try {
      _serialLoading = true;
      notifyListeners();
      await userDetails.getAllDetails();
      var headers = {
        'Authorization': 'Bearer 3bcnsU8jUPS2iWUK9Ey1H1DvqODghG',
        'Content-Type': 'application/json',
        'Cookie':
            'session_id=1094e035e6e99e2204699393448693df32c7a6f5; session_id=0f8b8670c9d9d484082c247ff094c0c7e4a0cddb'
      };

      var body = json
          .encode({"serial_no": serialNum, "clientid": userDetails.clientID});
      print(body);
      var response = await http.put(
          UriConverter(
              "$baseApiUrl/seedor-api/warehouse/update-serial-no/$moveId"),
          headers: headers,
          body: body);
      print("$baseApiUrl/seedor-api/warehouse/update-serial-no/$moveId");
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        _serialLoading = false;
        notifyListeners();
        showSnackBar(context: context, title: "Successfully Updated");
      } else {
        _serialLoading = false;
        notifyListeners();
        print(jsonData["Details"]);
        MyCustomAlertDialog().showCustomAlertdialog(
            context: context,
            title: 'Sorry',
            subtitle: jsonData["Details"] ?? "Something went wrong",
            onTapOkButt: () {
              Navigator.of(context).pop();
            });
        // showSnackBar(
        //     context: context,
        //     title: jsonData["Details"] ?? "Something went wrong");
      }
    } catch (e) {
      print(e.toString());
      _serialLoading = false;
      notifyListeners();
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "Something went wrong",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
      showSnackBar(context: context, title: "Something went wrong");
    }
  }

  bool _createQtyLoading = false;
  bool get createQtyLoading {
    return _createQtyLoading;
  }

  Future<dynamic> createMoveLineQuantity({
    required BuildContext context,
    required String moveId,
    required String productId,
    required String quantity,
    required String locationId,
    required String locationDestId,
    required String prodUomId,
    required String pickingID,
    required String palletId,
    required String balanceQty,
    required String moveLineId,
  }) async {
    try {
      _createQtyLoading = true;
      await userDetails.getAllDetails();
      var headers = {
        'Content-Type': 'application/json',
        'Cookie':
            'session_id=7b0a33157a6184c6019bd9ba6f7a5b8a907049bf; session_id=55086562687c122cacc52f4d11fdc91c221c6e53; session_id=bb81389513a21e5dec0ecf1683143518d1dbfad8'
      };
      var body = json.encode({
        "move_id": int.parse(moveId),
        "product_id": int.parse(productId),
        "qty_done": quantity,
        "location_id": int.parse(locationId),
        "location_dest_id": int.parse(locationDestId),
        "product_uom_id": prodUomId,
        "serial": "",
        "picking_id": int.parse(pickingID),
        "pallet_id": int.parse(palletId),
        "clientid": userDetails.clientID,
        "updated_qty": balanceQty,
        "old_move_line": moveLineId
      });
      print(body);
      var response = await http.post(
          UriConverter("$baseApiUrl/seedor-api/warehouse/move-line/create"),
          headers: headers,
          body: body);
      print("$baseApiUrl/seedor-api/warehouse/move-line/create");
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        _createQtyLoading = false;
        notifyListeners();
        showSnackBar(context: context, title: "Successfully Created");
      } else {
        _createQtyLoading = false;
        notifyListeners();
        MyCustomAlertDialog().showCustomAlertdialog(
            context: context,
            title: 'Sorry',
            subtitle: jsonData["Details"] ?? "Something went wrong",
            onTapOkButt: () {
              Navigator.of(context).pop();
            });
      }
    } catch (e) {
      _createQtyLoading = false;
      notifyListeners();
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "Something went wrong",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    }
  }

  bool _quantityUpdateLoading = false;
  bool get quantityUpdateLoading {
    return _quantityUpdateLoading;
  }

  Future<dynamic> updateQuantityApi(
      {required String palletId,
      required String moveId,
      required String serialNum,
      required BuildContext context}) async {
    try {
      _quantityUpdateLoading = true;
      await userDetails.getAllDetails();
      var headers = {
        'Content-Type': 'application/json',
        'Cookie':
            'session_id=7b0a33157a6184c6019bd9ba6f7a5b8a907049bf; session_id=55086562687c122cacc52f4d11fdc91c221c6e53; session_id=bb81389513a21e5dec0ecf1683143518d1dbfad8'
      };
      var body = json.encode({
        "pallet_id": palletId,
        "clientid": userDetails.clientID,
        "serial_no": serialNum,
      });
      print(body);
      var response = await http.put(
          UriConverter(
              "$baseApiUrl/seedor-api/warehouse/update-move-line/$moveId"),
          headers: headers,
          body: body);
      print("$baseApiUrl/seedor-api/warehouse/update-move-line/$moveId");
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        _quantityUpdateLoading = false;
        notifyListeners();
        showSnackBar(context: context, title: "Successfully Updated");
      } else {
        _quantityUpdateLoading = false;
        notifyListeners();
        print(jsonData["Details"]);
        MyCustomAlertDialog().showCustomAlertdialog(
            context: context,
            title: 'Sorry',
            subtitle: jsonData["Details"] ?? "Something went wrong",
            onTapOkButt: () {
              Navigator.of(context).pop();
            });
      }
    } catch (e) {
      _quantityUpdateLoading = false;
      print(e);
      notifyListeners();
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: "Something went wrong",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    }
  }
}
