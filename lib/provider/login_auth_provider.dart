import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse/const/config.dart';
import 'package:flutter/material.dart';
import 'package:warehouse/screens/Count/scan_count_container.dart';
import 'package:warehouse/services/alert_box.dart';

import 'package:warehouse/services/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:warehouse/screens/home_page.dart';

import '../services/dialogue.dart';
import 'device_info.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  GlobalSnackbar globalSnackBar = GlobalSnackbar();
  GlobalServices service = GlobalServices();

  Future<void> registerApiCall({
    required String firstname,
    required String lastname,
    required String phoneNumber,
    required String email,
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      var header = {'Content-Type': "application/json"};
      var body = jsonEncode({
        'clientid': clind_id,
        'firstname': firstname,
        "lastname": lastname,
        "email": email,
        'mobile': phoneNumber,
      });

      var response = await http.post(
          Uri.parse("http://eiuat.seedors.com:8290/customer-signup"),
          body: body,
          headers: header);
      // ignore: unrelated_type_equality_checks
      if (response.body == 200) {
        Navigator.of(context).pop();
        await globalSnackBar.successsnackbar(
            context: context,
            text: "Your Account has been created sucessfully");
        // ignore: unrelated_type_equality_checks
      } else if (response.body == 500) {
        Navigator.of(context).pop();
        await globalSnackBar.genarelSnackbar(
            context: context,
            text: "User Already present with this email please try signIn");
        // ignore: unrelated_type_equality_checks
      } else if (response.body == 404) {
        Navigator.of(context).pop();
        await globalSnackBar.genarelSnackbar(
            context: context, text: "Something went wrong");
      }

      _isLoading = false;
      notifyListeners();
    } on HttpException catch (e) {
      debugPrint("Register API error -->${e.message}");
      await globalSnackBar.genarelSnackbar(
          context: context, text: e.message.toString());
    }
  }

  Future<void> loginApi({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      var device = Provider.of<DeviceInformation>(context, listen: false);
      final prefs = await SharedPreferences.getInstance();
      var header = {
        'Content-Type': 'application/json',
        'Cookie':
            'session_id=221158a60339786cb50c760fbeb09fad84f387c8; session_id=1adf55e6ebc1440e59af6456eb48167407c350dc'
      };
      var body = json.encode({
        'username': email,
        'password': password,
        // 'device_id': device.deviceID,
        // 'os_type': device.deviceName,
        // 'client_id': clind_id
      });
      debugPrint(body.toString());
      var response = await http.post(
          Uri.parse('http://eiuat.seedors.com:8290/seedor-api-login'),
          headers: header,
          body: body);
      debugPrint("http://eiuat.seedors.com:8290/seedor-api-login");
      debugPrint("${response.body}hauwhdoaodhu");
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        prefs.setString('partner_id', jsonData["partner_id"].toString());
        prefs.setString('city', jsonData["profile"][0]['city'].toString());
        prefs.setString('companyName', jsonData['profile'][0]['company_name']);
        prefs.setString(
            'country_id', jsonData['profile'][0]['country_id'].toString());
        prefs.setString('email', jsonData['profile'][0]['email'].toString());
        prefs.setString(
            'employee_ids', jsonData['profile'][0]['employee_ids'].toString());
        prefs.setString('id', jsonData['profile'][0]['id'].toString());
        prefs.setString(
            'image_1024', jsonData['profile'][0]['image_1024'].toString());
        prefs.setString('mobile', jsonData['profile'][0]['mobile'].toString());
        prefs.setString('name', jsonData['profile'][0]['name'].toString());
        prefs.setString(
            'parent_id', jsonData['profile'][0]['parent_id'].toString());
        prefs.setString(
            'partner_id', jsonData['profile'][0]['partner_id'].toString());
        prefs.setString('phone', jsonData['profile'][0]['phone'].toString());
        prefs.setString('pin', jsonData['profile'][0]['pin'].toString());

        prefs.setString(
            'street2', jsonData['profile'][0]['street2'].toString());
        prefs.setString(
            'tz_offset', jsonData['profile'][0]['tz_offset'].toString());

        prefs.setString(
            'website', jsonData['profile'][0]['website'].toString());
        prefs.setString('phone', jsonData['profile'][0]['phone'].toString());
        prefs.setString('roles', jsonData['roles'].toString());
        prefs.setString('token', jsonData['token'].toString());
        prefs.setString('planname', jsonData['planname'].toString());
        prefs.setString('clientid', jsonData['clientid'].toString());
        prefs.setString('seedorname', jsonData['seedorname'].toString());

        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const MyHomePage()),
            (Route<dynamic> route) => false);

        await globalSnackBar.successsnackbar(
            context: context, text: "Logged in successfull");
      } else {
        if (jsonData['error'] == "please enter correct password") {
          service.customDialog(
              context, "Password", "Please enter the correct password");
        } else {
          if (jsonData["description"] == jsonData["description"]) {
            await globalSnackBar.genarelSnackbar(
                context: context, text: "please check email and password");
          }
        }
        _isLoading = false;
        notifyListeners();
      }
    } on HttpException catch (e) {
      debugPrint("login api error --> ${e.message}");
      await globalSnackBar.genarelSnackbar(
          context: context, text: e.message.toString());
    }
    _isLoading = false;
    notifyListeners();
  }
}
