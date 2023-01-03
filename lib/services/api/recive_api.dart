import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as https;
import 'package:warehouse/const/config.dart';
import '../../models/orders_line_model.dart';
import '../../models/quality_check_questions.dart';
import '../../models/quality_value.dart';
import '../../models/recived_details_model.dart';
import '../../models/reciveorders_model.dart';
import '../../provider/login_details.provider.dart';

import '../../screens/PutAway/put_away_ui_design/put_away_orders.dart';
import '../alert_box.dart';
import '../order_line_data.dart';
import '../snackbar.dart';

//This is the Recive orders page API derived page
//Dio was used for get api details.
class RecieveAPI with ChangeNotifier {
  GlobalSnackbar globalSnackBar = GlobalSnackbar();
  GlobalAlertBox globalAlertBox = GlobalAlertBox();

  List<String> _updateProd = [];

  List<String> get updateProd {
    return _updateProd;
  }

  bool _isLoading = false;
  bool get isLoading {
    if (_isLoading == "") {
      _isLoading = "Not yet updated" as bool;
      return _isLoading;
    } else {
      return _isLoading;
    }
  }

  String _domain = "";

  String get domain {
    if (_domain == "") {
      _domain = "Not yet updated";
      return _domain;
    } else {
      return _domain;
    }
  }

  List<RecivedOrdersModel> _rec = [];
  RecievedDetails? _par;
  List<QualityQuestions> _ques = [];
  List<QualityQuestionsValue> _quesValue = [];
  List<OrderLine> _ord = [];

  List<RecivedOrdersModel> get rec {
    // ignore: unrelated_type_equality_checks
    return _rec;
    // if (_rec == "") {
    //   _rec = "Not yet updated" as List<RecivedOrdersModel>;

    // } else {
    //   return _rec;
    // }
  }

  RecievedDetails? get par {
    // ignore: unrelated_type_equality_checks
    if (_par == "") {
      _par = "Not yet updated" as RecievedDetails;
      return _par;
    } else {
      return _par;
    }
  }

  List<QualityQuestions> get ques {
    return _ques;
  }

  List<QualityQuestionsValue> get quesValue {
    // ignore: unrelated_type_equality_checks
    if (_quesValue == "") {
      _quesValue = "Not yet updated" as List<QualityQuestionsValue>;
      return _quesValue;
    } else {
      return _quesValue;
    }
  }

  String? _errorMessage;
  String? get errorMessage {
    return _errorMessage;
  }

  bool? _isError;
  bool? get isError {
    return _isError;
  }

  List<OrderLine> get ord {
    return _ord;
    // if (_ord == "") {
    //   _ord = "Not yet updated" as List<OrderLine>;
    //   return _ord;
    // } else {
    //   return _ord;
    // }
  }

  Future<List<RecivedOrdersModel>> recievedoders(
      {required BuildContext context}) async {
    _isLoading = true;

    final user = Provider.of<UserDetails>(context, listen: false);

    await user.getAllDetails();
    List<RecivedOrdersModel>? result;
    List<RecivedOrdersModel> getOrders = [];

    var headers = {
      'Cookie':
          'session_id=ad9b3d63d0f6e25ada8e6568cf58fa1a599002b9; session_id=830516724d3bb81b684f4a9457d7f11cb28ba537'
    };

    String clinedId = user.clientID;

    print("cId---> $clinedId");

    var url =
        "$baseApiUrl/seedor-api/warehouse/received-orders?fields={'id','scheduled_date','origin','display_name','date','partner_id','create_date','barcode'}&clientid=$clinedId&domain=[('picking_state','=','1')]";
    print(
        "first http-->$baseApiUrl/seedor-api/warehouse/received-orders?fields={'id','scheduled_date','origin','display_name','date','partner_id','create_date','barcode'}&clientid=$clinedId&domain=[('picking_state','=','1')]");
    try {
      https.Response response =
          await https.get(Uri.parse(url), headers: headers);
      // print("respnsee-->$response");
      var jsonData = json.decode(response.body);
      // print("json-->$jsonData");
      // print(response.body);
      if (response.statusCode == 200) {
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

          getOrders.add(RecivedOrdersModel(
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

          print('partner--> ${getOrders[i].partnerId.toString()}');
        }

        _rec = getOrders;
        print(rec.length.toString() + "---> fav data length");
        _isLoading = false;
        print('NNNNNN' + getOrders.toString());
        // notifyListeners();
        return getOrders;
      } else {
        _isLoading = false;
        // notifyListeners();

        print(response.reasonPhrase! + 'last response');
        return result!;
      }
    } on HttpException catch (e) {
      debugPrint("login api error --> ${e.message}");
      await globalSnackBar.genarelSnackbar(
          context: context, text: e.message.toString());
      return result!;
    } on SocketException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "No Internet Connection";
      return result!;
    } on FormatException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "Invalid Data Format";
      return result!;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<RecievedDetails?> particularOrders(
      {required BuildContext context, required String domain}) async {
    _isLoading = true;

    final user = Provider.of<UserDetails>(context, listen: false);

    await user.getAllDetails();

    RecievedDetails getDetails;

    var header = {
      'Cookie':
          'session_id=ad9b3d63d0f6e25ada8e6568cf58fa1a599002b9; session_id=11f5121f566165d27cf73b9a28432ad6d0b3597b'
    };
    String clinedId = user.clientID;

    var url =
        "$baseApiUrl/seedor-api/warehouse/received-orders?fields={'id','scheduled_date','origin','transport_date','display_name','date','partner_id','create_date','barcode',}&clientid=$clinedId&domain=[('id','=',$domain)]";
    print(
        "First domain-->$baseApiUrl/seedor-api/warehouse/received-orders?fields={'id','scheduled_date','origin','transport_date','display_name','date','partner_id','create_date','barcode'}&clientid=$clinedId&domain=[('id','=',$domain)]");
    try {
      var result = '';
      https.Response response =
          await https.get(Uri.parse(url), headers: header);
      print("Barcode value --> ${response.body}");
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        String createddate =
            DateTime.parse('${jsonData[0]['create_date']}.000Z')
                .toLocal()
                .toString()
                .substring(0, 19);
        getDetails = (RecievedDetails(
          // isVisible: false,
          barcode: jsonData[0]["barcode"].toString(),
          createDate: createddate,
          date: jsonData[0]["date"].toString(),
          displayName: jsonData[0]["display_name"].toString(),
          id: jsonData[0]["id"].toString(),
          origin: jsonData[0]["origin"].toString(),
          partnerId: jsonData[0]["partner_id"][0].toString(),
          companyName: jsonData[0]["partner_id"][1].toString(),
          scheduledDate: jsonData[0]["scheduled_date"].toString(),
          skuId: jsonData[0]['x_sku_id'].toString(),
          transportDate: jsonData[0]["transport_date"].toString(),
          isVisible: true,
        ));

        // print(getDetails.id);
        print("particularorder value --> ${response.body}");
        _par = getDetails;
        // notifyListeners();
        print(par);

        print(rec.length.toString() + "---> fav data length");
        // _isLoading = false;
        print('SSSSSS' + getDetails.toString());
      } else {
        _isLoading = false;
        // notifyListeners();

        print(response.reasonPhrase);
      }
    } on HttpException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "No Service Found";
    } on SocketException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "No Internet Connection";
    } on FormatException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "Invalid Data Format";
    } catch (e) {
      _isLoading = false;
      _isError = false;
      _errorMessage = "Some thing went wrong";
    }
    return _par;
  }

  Future<List<OrderLine>> orderLine(
      {required BuildContext context,
      required String domain,
      required String pickingId}) async {
    _isLoading = true;

    var user = Provider.of<UserDetails>(context, listen: false);

    List<OrderLine> getDetails = [];

    await user.getAllDetails();

    var headers = {
      'Cookie':
          'session_id=ad9b3d63d0f6e25ada8e6568cf58fa1a599002b9; session_id=11f5121f566165d27cf73b9a28432ad6d0b3597b'
    };

    String clainedId = user.clientID;

    var url =
        "$baseApiUrl/seedor-api/warehouse/received-order-line?fields={'product_id','product_uom_qty','quantity_done','picking_partner_id','display_name','picking_id','barcode','x_sku_id','x_length','x_breadth','x_height','x_dimension','x_weight'}&clientid=$clainedId&domain=[('picking_id','=',$pickingId)]";

    print(
        "order line -->$baseApiUrl/seedor-api/warehouse/received-order-line?fields={'product_id','product_uom_qty','quantity_done','picking_partner_id','display_name','picking_id','barcode','x_sku_id','x_length','x_breadth','x_height','x_dimension','x_weight'}&clientid=$clainedId&domain=[('picking_id','=',$pickingId)]");

    try {
      https.Response response =
          await https.get(Uri.parse(url), headers: headers);
      var jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        for (var i = 0; i < jsonData.length; i++) {
          String pickingPartnerId;
          String pickingPartnerName;
          String pickingId;
          String pickingName;
          if (jsonData[i]['picking_partner_id'] == false) {
            pickingPartnerName = '';
            pickingId = "";
            pickingName = "";
            pickingPartnerId = "";
          } else {
            pickingPartnerId = jsonData[i]['picking_partner_id'][0].toString();
            pickingPartnerName =
                jsonData[i]['picking_partner_id'][1].toString();
            pickingId = jsonData[i]['picking_id'][0].toString();
            pickingName = jsonData[i]['picking_id'][1].toString();
          }
          getDetails.add(OrderLine(
            pickingId: pickingId,
            pickingName: pickingName,
            displayName: jsonData[i]['display_name'].toString(),
            userid: jsonData[i]['id'].toString(),
            pickingPartnerId: pickingPartnerId,
            pickingPartnerName: pickingPartnerName,
            productId: jsonData[i]['product_id'][0].toString(),
            productName: jsonData[i]['product_id'][1].toString(),
            productOnQty:
                double.parse(jsonData[i]['product_uom_qty'].toString())
                    .floor()
                    .toString(),
            skuId: jsonData[i]['x_sku_id'].toString(),
            quantityDone: double.parse(jsonData[i]['quantity_done'].toString())
                .floor()
                .toString(),
            breadth: jsonData[i]['x_breadth'].toString(),
            height: jsonData[i]['x_height'].toString(),
            length: jsonData[i]['x_length'].toString(),
            weight: jsonData[i]['x_weight'].toString(),
          ));
        }
        print("Barcode2 value --> ${response.body}");
        _ord = getDetails;
        // notifyListeners();
        print(ord);

        print(_ord.length.toString() + "---> fav orderline length");

        print('OOOOOOO' + getDetails.toString());
        // notifyListeners();

        print("${response.reasonPhrase} + order line response");
      } else {
        print("isLoading---loading");
      }
    } on HttpException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "No Service Found";
    } on SocketException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "No Internet Connection";
    } on FormatException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "Invalid Data Format";
    } catch (e) {
      _isLoading = false;
      _isError = false;
      _errorMessage = "Some thing went wrong";
    }

    return _ord;
  }

  Future<int> orderLineQuantity({
    required String quantity,
    required String length,
    required String height,
    required String breadth,
    required String weight,
    required String id,
    required BuildContext context,
  }) async {
    int statusCode = 0;
    _isLoading = true;

    var user = Provider.of<UserDetails>(context, listen: false);

    await user.getAllDetails();

    String verifiedId = user.id;

    var header = {
      'Cookie':
          'session_id=8a47612539d2b93909330392d4b6369f5d83dfa9; session_id=b161ecd263cad0ef56bd6055aaaf7a6e0d8b59cd; session_id=f95ae8522f72d7ff05f1a72c60a9ead326f691ca'
    };

    String clainedId = user.clientID;
    // print("original id -->$skuId");
    var url =
        '$baseApiUrl/seedor-api/warehouse/update-recived/$id?clientid=$clainedId&quantity=$quantity&length=$length&breadth=$breadth&height=$height&weight=$weight&verified_by=$verifiedId';

    print(
        'url order line quantity -->$baseApiUrl/seedor-api/warehouse/update-recived/$id?clientid=$clainedId&quantity=$quantity&length=$length&breadth=$breadth&height=$height&weight=$weight&verified_by=$verifiedId');

    try {
      https.Response response =
          await https.put(Uri.parse(url), headers: header);
      var jsonData = json.decode(response.body);
      statusCode = response.statusCode;
      if (response.statusCode == 200) {
        _updateProd.add(id);

        print(_updateProd.length.toString() + "updateProd");

        print(response.body);

        _isLoading = false;

        globalSnackBar.successsnackbar(context: context, text: "Updated");

        // await RecieveAPI().orderLine(
        //     context: context, domain: domain, pickingId: _par!.id.toString());

        // Navigator.pop(context);
        // print("2nd Api --> ${RecieveAPI().orderLine(
        //   context: context,
        //   domain: domain,
        //   pickingId: _par!.id.toString(),
        // )}");
      } else {
        await globalSnackBar.successsnackbar(context: context, text: "failed");
      }
    } on HttpException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "No Service Found";
    } on SocketException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "No Internet Connection";
    } on FormatException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "Invalid Data Format";
    } catch (e) {
      _isLoading = false;
      _isError = false;
      _errorMessage = "Some thing went wrong";
    }
    return statusCode;
  }

  Future<List<QualityQuestions?>> qualityCheck(
      {required BuildContext context, required String userId}) async {
    _isLoading = true;

    final user = Provider.of<UserDetails>(context, listen: false);

    await user.getAllDetails();

    List<QualityQuestions> getDetails = [];

    var header = {
      'Cookie':
          'session_id=8a47612539d2b93909330392d4b6369f5d83dfa9; session_id=b161ecd263cad0ef56bd6055aaaf7a6e0d8b59cd; session_id=f95ae8522f72d7ff05f1a72c60a9ead326f691ca'
    };
    String clinedId = user.clientID;

    var url =
        "$baseApiUrl/seedor-api/warehouse/quality-check/scenario?clientid=$clinedId&id=$userId&fields={'id','name','possible_ql_values'}";
    print(
        "qustion Api --->$baseApiUrl/seedor-api/warehouse/quality-check/scenario?clientid=$clinedId&id=$userId&fields={'id','name','possible_ql_values'} ");
    try {
      https.Response response =
          await https.get(Uri.parse(url), headers: header);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonData.length; i++) {
          getDetails.add(QualityQuestions(
            id: jsonData[i]['id'].toString(),
            questions: jsonData[i]['name'].toString(),
            value: jsonData[i]['possible_ql_values'].toString(),
          ));
        }

        print("questions--> ${response.body}");

        _ques = getDetails;
        // notifyListeners();
        print(ques);

        print(ques.toString() + "---> fav data length");
        // _isLoading = false;
        print('quququququ' + getDetails.toString());
      } else {
        isLoading == false;
      }
    } on HttpException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "No Service Found";
    } on SocketException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "No Internet Connection";
    } on FormatException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "Invalid Data Format";
    } catch (e) {
      _isLoading = false;
      _isError = false;
      _errorMessage = "Some thing went wrong";
    }
    return _ques;
  }

  Future<List<QualityQuestionsValue?>> qualityCheckValue(
      {required BuildContext context, required String valuesId}) async {
    _isLoading = true;

    final user = Provider.of<UserDetails>(context, listen: false);

    await user.getAllDetails();

    List<QualityQuestionsValue> getDetails = [];

    var header = {
      'Cookie':
          'session_id=8a47612539d2b93909330392d4b6369f5d83dfa9; session_id=b161ecd263cad0ef56bd6055aaaf7a6e0d8b59cd; session_id=f95ae8522f72d7ff05f1a72c60a9ead326f691ca'
    };
    String clinedId = user.clientID;

    var url =
        "$baseApiUrl/seedor-api/warehouse/quatity-check/dropdown?clientid=$clinedId&domain=[('id','=',$valuesId)]&fields={'id','name'}&type=quality-test-value";
    print(
        "qustionValue Api --->$baseApiUrl/seedor-api/warehouse/quatity-check/dropdown?clientid=$clinedId&domain=[('id','=',$valuesId)]&fields={'id','name'}&type=quality-test-value");
    try {
      https.Response response =
          await https.get(Uri.parse(url), headers: header);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonData.length; i++) {
          getDetails.add(QualityQuestionsValue(
              id: jsonData[i]['id'].toString(),
              questions: jsonData[i]['name'].toString()));
        }

        print("questionsValue--> ${response.body}");

        _quesValue = getDetails;
        // notifyListeners();
        print(quesValue);

        print(quesValue.toString() + "---> fav data length");
        // _isLoading = false;
        print('qu1qu1qu1qu1qu1' + getDetails.toString());
      } else {
        isLoading == false;
      }
    } on HttpException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "No Service Found";
    } on SocketException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "No Internet Connection";
    } on FormatException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "Invalid Data Format";
    } catch (e) {
      _isLoading = false;
      _isError = false;
      _errorMessage = "Some thing went wrong";
    }
    return _quesValue;
  }

  Future<int> qualityValueGet({
    required BuildContext context,
    required String feedBack,
    required String questionId,
    required String answerId,
    required String userId,
  }) async {
    final user = Provider.of<UserDetails>(context, listen: false);
    int statusCode = 0;
    await user.getAllDetails();

    var header = {
      "Cookie":
          "session_id=b161ecd263cad0ef56bd6055aaaf7a6e0d8b59cd; session_id=f95ae8522f72d7ff05f1a72c60a9ead326f691ca"
    };

    var url =
        "$baseApiUrl/seedor-api/warehouse/quality-check/update?question_id=$questionId&answer_id=$answerId&note=$feedBack&verified_by=${user.id}&clientid=${user.clientID}";
    print(
        "qualityValueGet---->$baseApiUrl/seedor-api/warehouse/quality-check/update?question_id=$questionId&answer_id=$answerId&note=$feedBack&verified_by=${user.id}&clientid=${user.clientID}");

    try {
      https.Response response =
          await https.put(Uri.parse(url), headers: header);
      var jsonData = json.decode(response.body);
      statusCode = response.statusCode;
      if (response.statusCode == 200) {
        print("value-->${response.body}");

        globalSnackBar.successsnackbar(context: context, text: "Success");
      } else {
        globalSnackBar.genarelSnackbar(
            context: context, text: "Please Choose Value");
      }
    } on HttpException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "No Service Found";
    } on SocketException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "No Internet Connection";
    } on FormatException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "Invalid Data Format";
    } catch (e) {
      _isLoading = false;
      _isError = false;
      _errorMessage = "Some thing went wrong";
    }
    return statusCode;
  }

  Future<void> receivedFinalValitation(
      {required BuildContext context, required String userId}) async {
    final user = Provider.of<UserDetails>(context, listen: false);

    await user.getAllDetails();
    try {
      _isLoading = true;
      var header = {
        'Cookie':
            'session_id=aa66520e9df6fa47c0d7d174c2bf6d4fe3203db8; session_id=e2fc46ab8d73ddb088f3406a1ee387a52b0bcbb1'
      };
      var url =
          "$baseApiUrl/seedor-api/warehouse/move-to-putaway/$userId?clientid=${user.clientID}";
      print(
          "valit url-->$baseApiUrl/seedor-api/warehouse/move-to-putaway/$userId?clientid=${user.clientID}");
      var response = await https.post(Uri.parse(url), headers: header);
      var jsonData = json.decode(response.body);
      print("valid response-->${response.body}");
      if (response.statusCode == 200) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PutAwayOrdersScreen()));
      } else if (jsonData["Details"] == jsonData["Details"]) {
        globalSnackBar.genarelSnackbar(
            context: context,
            text:
                "You cannot validate a transfer if no quantites are reserved nor done");
      } else {
        globalSnackBar.genarelSnackbar(
            context: context, text: "Something was wrong,Try again later");
      }
    } on HttpException catch (e) {
      debugPrint("login api error --> ${e.message}");
      await globalSnackBar.genarelSnackbar(
          context: context, text: e.message.toString());
    } on SocketException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "Some thing went wrong";
    } on FormatException {
      _isLoading = false;
      _isError = false;
      _errorMessage = "Some thing went wrong";
    }
  }
}
