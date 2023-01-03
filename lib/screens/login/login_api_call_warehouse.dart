import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse/apis/uri_converter.dart';
import 'package:warehouse/models/company_model.dart';
import 'package:warehouse/screens/company_selection/company_selection_Screen.dart';
import 'package:warehouse/screens/home_page.dart';
import 'package:warehouse/widgets/custom_alert_dialog.dart';
import 'package:http/http.dart' as http;

class LoginWareHouseCall with ChangeNotifier {
  MyCustomAlertDialog alertDialog = MyCustomAlertDialog();
  //LIST OF COMPANY FROM LOGIN API//
  List<LoginCompanyModel> _listOfLoginCompany = [];
  // LOADING FOR LOGIN BUTTON //
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  bool rememberMe = true;
  List<String> rolePeremission = [];

// lOGIN API CALL IT WILL RETURUN JSONTOKEN & LIST OF COMPANY (if the user press the login button first this api will work)//
  Future<dynamic> loginApiCall(
      {required BuildContext context,
      required String userEmail,
      required String userPassword}) async {
    try {
      _isLoading = true;
      final prefs = await SharedPreferences.getInstance();
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = json.encode({"username": userEmail, "password": userPassword});
      print(body);
      var response = await http.post(
          UriConverter(allApiCallsName.loginApiCallName),
          body: body,
          headers: headers);

      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(response.statusCode);
        // Here we are adding all Company from login api response
        for (var i = 0; i < jsonData['companies'].length; i++) {
          _listOfLoginCompany.add(LoginCompanyModel(
              clientid: jsonData['companies'][i]['clientid'].toString(),
              seedortype: jsonData['companies'][i]['seedortype'].toString(),
              companyName: jsonData['companies'][i]['company_name'].toString(),
              planname: jsonData['companies'][i]['planname'].toString()));
        }
        if (_listOfLoginCompany.length == 1) {
          getProfileDetails(
                  context: context,
                  userEmail: userEmail,
                  clientId: jsonData['companies'][0]['clientid'],
                  seedorType: jsonData['companies'][0]['seedortype'])
              .then((value) {
            if (value[0] == 200) {
              var role = value[1]['roles'];

              for (var sus in role) {
                if (sus.toString() == '') {
                  print('break');

                  break;
                }

                print('roles');

                // print(sus['role_id'][1]);

                rolePeremission.add(sus['role_id'][1]);
              }

              prefs.setString('loginemail', userEmail);

              prefs.setString(
                  'jsonToken', rememberMe ? jsonData['token'].toString() : '');

              prefs.setString(
                  'planName', jsonData['companies'][0]['planname'].toString());

              localStoageDataValue(
                  city: value[1]['profile'][0]['city'].toString(),
                  companyName:
                      value[1]['profile'][0]['company_id'][1].toString(),
                  email: value[1]['profile'][0]['email'].toString(),
                  emplyeeId:
                      value[1]['profile'][0]['employee_ids'][0].toString(),
                  id: value[1]['profile'][0]['id'].toString(),
                  imageUrl: value[1]['profile'][0]['image_1024'].toString(),
                  jobTitle: value[1]['profile'][0]['job_title'].toString(),
                  logAttendanceGeoLocation: value[1]['profile'][0]
                          ['log_attendance_geolocation']
                      .toString(),
                  mobile: value[1]['profile'][0]['mobile'].toString(),
                  name: value[1]['profile'][0]['name'].toString(),
                  parentId: value[1]['profile'][0]['parent_id'].toString(),
                  partnerId: value[1]['profile'][0]['partner_id'][0].toString(),
                  phone: value[1]['profile'][0]['phone'].toString(),
                  pin: value[1]['profile'][0]['zip'].toString(),
                  street: value[1]['profile'][0]['street'].toString(),
                  streetTwo: value[1]['profile'][0]['street2'].toString(),
                  website: value[1]['companywebsite'].toString(),
                  roles: rolePeremission,
                  companyCity: value[1]['companycity'] == ""
                      ? 'City'
                      : value[1]['companycity'],
                  companyPincoide: value[1]['companypincode'] == ""
                      ? 'Pincode'
                      : value[1]['companypincode'],
                  companyCountry: value[1]['companycountry'] == ""
                      ? 'Country'
                      : value[1]['companycountry'],
                  companyEmail: value[1]['companyemail'] == ""
                      ? 'Email'
                      : value[1]['companyemail'],
                  companyPhone: value[1]['companyphone'] == ""
                      ? 'Phone'
                      : value[1]['companyphone'],
                  companyState: value[1]['companystate'] == ""
                      ? 'State'
                      : value[1]['companystate'],
                  companyStreetOne: value[1]['companystreet1'] == ""
                      ? 'Street1'
                      : value[1]['companystreet1'],
                  companyStreetTwo: value[1]['companystreet2'] == ""
                      ? 'Street2'
                      : value[1]['companystreet2'],

                  // jsonToken: rememberMe ? jsonData['token'].toString() : '',

                  clientID: value[1]['profile'][0]['clientid'].toString(),

                  // planName: value[1]['planname'].toString(),

                  seedorName: value[1]['seedorname'].toString());

              // await registerDeviceIdApi(userName: email);
              print("claint-->${value[1]['clientid'].toString()}");
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => const MyHomePage()),
                  (route) => false);

              _isLoading = false;

              notifyListeners();
            }
          });
        } else if (_listOfLoginCompany.length <= 2) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (ctx) => LoginCompanySelection(
                      jsonToken: jsonData['token'].toString(),
                      companyNames: _listOfLoginCompany,
                      userName: userEmail)),
              (route) => false);
        }
      } else {
        alertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: jsonData['Details'] ?? 'Something went wrong',
          onTapOkButt: () {
            Navigator.of(context).pop();
          },
        );
        _isLoading = false;
      }
    } on SocketException catch (e) {
      alertDialog.showCustomAlertdialog(
        context: context,
        title: 'Sorry',
        subtitle: e.message.toString(),
        onTapOkButt: () {
          Navigator.of(context).pop();
        },
      );
      _isLoading = false;
      notifyListeners();
    } on TimeoutException catch (e) {
      alertDialog.showCustomAlertdialog(
        context: context,
        title: 'Sorry',
        subtitle: e.message.toString(),
        onTapOkButt: () {
          Navigator.of(context).pop();
        },
      );
      _isLoading = false;
      notifyListeners();
    } on HttpException catch (e) {
      alertDialog.showCustomAlertdialog(
        context: context,
        title: 'Sorry',
        subtitle: e.message.toString(),
        onTapOkButt: () {
          Navigator.of(context).pop();
        },
      );
      _isLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      alertDialog.showCustomAlertdialog(
        context: context,
        title: 'Sorry',
        subtitle: e.toString(),
        onTapOkButt: () {
          Navigator.of(context).pop();
        },
      );
      _isLoading = false;
      notifyListeners();
    }
    //  catch (e) {
    //   alertDialog.showCustomAlertdialog(
    //     context: context,
    //     title: 'Sorry',
    //     subtitle: e.toString(),
    //     onTapOkButt: () {
    //       Navigator.of(context).pop();
    //     },
    //   );
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }

  // PROFILE GET API //

  Future<dynamic> getProfileDetails({
    required BuildContext context,
    required String userEmail,
    required String clientId,
    required String seedorType,
  }) async {
    var jsonData;
    int statusCode = 0;
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = json.encode({
        "username": userEmail,
        "clientid": clientId,
        "seedortype": seedorType,
      });
      var response = await http.post(
          UriConverter(allApiCallsName.loginProfileGetApiName),
          headers: headers,
          body: body);
      statusCode = response.statusCode;
      jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        return [response.statusCode, jsonData];
      } else {
        alertDialog.showCustomAlertdialog(
          context: context,
          title: 'Sorry',
          subtitle: jsonData['Details'] ?? 'Something went wrong',
          onTapOkButt: () {
            Navigator.of(context).pop();
          },
        );
        _isLoading = false;
        return [statusCode, jsonData];
      }
    } on SocketException catch (e) {
      alertDialog.showCustomAlertdialog(
        context: context,
        title: 'Sorry',
        subtitle: e.message.toString(),
        onTapOkButt: () {
          Navigator.of(context).pop();
        },
      );
      _isLoading = false;

      notifyListeners();
      return [statusCode, e.message];
    } on TimeoutException catch (e) {
      alertDialog.showCustomAlertdialog(
        context: context,
        title: 'Sorry',
        subtitle: e.message.toString(),
        onTapOkButt: () {
          Navigator.of(context).pop();
        },
      );
      _isLoading = false;
      notifyListeners();
      return [statusCode, e.message];
    } on HttpException catch (e) {
      alertDialog.showCustomAlertdialog(
        context: context,
        title: 'Sorry',
        subtitle: e.message.toString(),
        onTapOkButt: () {
          Navigator.of(context).pop();
        },
      );
      _isLoading = false;
      notifyListeners();
      return [statusCode, e.message];
    } on Exception catch (e) {
      alertDialog.showCustomAlertdialog(
        context: context,
        title: 'Sorry',
        subtitle: e.toString(),
        onTapOkButt: () {
          Navigator.of(context).pop();
        },
      );
      _isLoading = false;
      notifyListeners();
      return [statusCode, e.toString()];
    } catch (e) {
      alertDialog.showCustomAlertdialog(
        context: context,
        title: 'Sorry',
        subtitle: e.toString(),
        onTapOkButt: () {
          Navigator.of(context).pop();
        },
      );
      _isLoading = false;
      notifyListeners();
      return [statusCode, e.toString()];
    }
  }

  void localStoageDataValue(
      {required String city,
      required String companyName,
      required String email,
      required String emplyeeId,
      required String id,
      required String imageUrl,
      required String jobTitle,
      required String logAttendanceGeoLocation,
      required String mobile,
      required String name,
      required String parentId,
      required String partnerId,
      required String phone,
      required String pin,
      required String street,
      required String streetTwo,
      required String website,
      required List<String> roles,
      required String clientID,
      required String seedorName,
      required String companyEmail,
      required String companyStreetOne,
      required String companyStreetTwo,
      required String companyPhone,
      required String companyCountry,
      required String companyState,
      required String companyPincoide,
      required String companyCity}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('city', city);
    prefs.setString('companyName', companyName);
    prefs.setString('email', email);
    prefs.setString('employeId', emplyeeId);
    prefs.setString('id', id);
    prefs.setString('imageUrl', imageUrl);
    prefs.setString('jobTitle', jobTitle);
    prefs.setString('logAttendanceGeoLocation', logAttendanceGeoLocation);
    prefs.setString('mobile', mobile);
    prefs.setString('name', name);
    prefs.setString('parentId', parentId);
    prefs.setString('partnerId', partnerId);
    prefs.setString('phone', phone);
    prefs.setString('pin', pin);
    prefs.setString('street', street);
    prefs.setString('streetTwo', streetTwo);
    prefs.setString('website', website);
    prefs.setStringList('roles', roles);

    prefs.setString('clientId', clientID);

    prefs.setString('seedorName', seedorName);
    prefs.setString('companyEmail', companyEmail);
    prefs.setString('companyStreetone', companyStreetOne);
    prefs.setString('companyStreetTwo', companyStreetTwo);
    prefs.setString('companyPhone', companyPhone);
    prefs.setString('companyCountry', companyCountry);
    prefs.setString('companyState', companyState);
    prefs.setString('companyPincode', companyPincoide);
    prefs.setString('companyCity', companyCity);

    print(prefs.getString('seedorName'));
    print(prefs.getString('planName'));
    print(prefs.getString('clientId'));
    print(prefs.getString('website'));
  }
}
