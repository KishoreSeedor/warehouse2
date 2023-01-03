// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:background_location_tracker/background_location_tracker.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:seedor_emc/allTabBar/home_tabbar_screen.dart';
// import 'package:seedor_emc/common/api_error_handling.dart';
// import 'package:seedor_emc/common/custom_dialog.dart';
// import 'package:seedor_emc/common/custom_snackbar.dart';
// import 'package:seedor_emc/common/user_details_provider.dart';
// import 'package:seedor_emc/companySelection/company_selection_Screen.dart';
// import 'package:seedor_emc/const/config.dart';
// import 'package:seedor_emc/login/login_new_screen.dart';
// import 'package:seedor_emc/login/login_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../allTabBar/tabbar_provider.dart';

// class LoginApiCall with ChangeNotifier {
//   List<String> rolePeremission = [];
//   bool _isLoading = false;
//   bool get isLoading {
//     return _isLoading;
//   }

//   List<String> totalCompany = [
//     'Seedoraffinity',
//     'Seedorpeople',
//     'Seedorfinance',
//     'Seedorproject',
//     'Bookseedor'
//   ];

//   String? _jsonToken;

//   String? get jsonToken {
//     return _jsonToken;
//   }

//   List<CompanyNames> _companyNames = [];
//   List<CompanyNames> get companyNames {
//     return _companyNames;
//   }

//   List<CompanyNames> _finalCompanys = [];

//   List<CompanyNames> get finalCompanys {
//     return _finalCompanys;
//   }

//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

//   MyCustomAlertDialog alertDialog = MyCustomAlertDialog();
//   UserPersonalDetails userPersonalDetails = UserPersonalDetails();
//   int quantity = 1;
//   Future<void> loginApi(
//       {required BuildContext context,
//       required String email,
//       required bool rememberMe,
//       required String password}) async {
//     final prefs = await SharedPreferences.getInstance();
//     try {
//       _isLoading = true;
//       notifyListeners();
//       var headers = {
//         'Content-Type': 'application/json',
//         'Cookie': 'session_id=5c8e05158d4b744dc14e82bbbca5b7542068d19f'
//       };
//       final prefs = await SharedPreferences.getInstance();
//       var body = json.encode({"username": email, "password": password});
//       print(body);
//       var response = await http.post(Uri.parse('$baseApiUrl/seedor-app-login'),
//           headers: headers, body: body);
//       var jsonData = json.decode(response.body);
//       print('$baseApiUrl/seedor-app-login');
//       print(jsonData);
//       _finalCompanys = [];
//       if (response.statusCode == 200) {
//         // if (jsonData['planname'].toString() == 'Basic') {
//         //   alertDialog.showCustomAlertdialog(
//         //       context: context,
//         //       title: 'Sorry',
//         //       subtitle: 'Please by an Premium plan to access mobile app',
//         //       onTapOkButt: () {
//         //         Navigator.of(context).pop();
//         //       });
//         // } else {
//         // if (jsonData['profile'][0]['employee_ids'].toString() == '[]') {
//         //   alertDialog.showCustomAlertdialog(
//         //       context: context,
//         //       onTapOkButt: () {
//         //         Navigator.of(context).pop();
//         //       },
//         //       title: 'Note',
//         //       subtitle:
//         //           'Employee is not created for this user.Please add Employee');
//         //   _isLoading = false;
//         //   notifyListeners();
//         // } else {
//         //   var userRole = jsonData['roles'];

//         //   var role = jsonData['roles'];
//         //   for (var sus in role) {
//         //     if (sus.toString() == '') {
//         //       print('break');
//         //       break;
//         //     }
//         //     print('roles');
//         //     // print(sus['role_id'][1]);
//         //     rolePeremission.add(sus['role_id'][1]);
//         //   }
//         //   print(rolePeremission.toList().toString() + 'sushalt roles');
//         //   // if (jsonData['profile'][0]['city'].toString() == '' ||
//         //   //     jsonData['profile'][0]['company_name'].toString() == '' ||
//         //   //     jsonData['profile'][0]['image_1024'].toString() == '' ||
//         //   //     jsonData['profile'][0]['log_attendance_geolocation'] == '' ||
//         //   //     jsonData['profile'][0]['parent_id'].toString() == '' ||
//         //   //     jsonData['profile'][0]['partner_id'] == [] ||
//         //   //     jsonData['profile'][0]['phone'].toString() == '' ||
//         //   //     jsonData['profile'][0]['pin'].toString() == '' ||
//         //   //     jsonData['profile'][0]['tz_offset'].toString() == '' ||
//         //   //     jsonData['profile'][0]['website'].toString() == '' ||
//         //   //     jsonData['profile'][0]['email'].toString() == '') {

//         //   //   alertDialog.showCustomAlertdialog(
//         //   //     context: context,
//         //   //     title: 'Note',
//         //   //     button: true,
//         //   //     onTapOkButt: () {

//         //   //     },
//         //   //     onTapCancelButt: () {
//         //   //       Navigator.of(context).pop();
//         //   //     },
//         //   //     subtitle:
//         //   //         'Some required field are missing some of the feature may not work please contact administrator to add those field',
//         //   //   );
//         //   //   _isLoading = false;
//         //   //   notifyListeners();
//         //   // }
//         //   // // print(response.body);
//         //   // else {
//         //   //   // print(jsonData);

//         //   //   // print(response.statusCode);
//         //   //   _isLoading = false;
//         //   //   notifyListeners();
//         //   // }
//         // prefs.setString(
//         //     'jsonToken', rememberMe ? jsonData['token'].toString() : '');

//         _jsonToken = jsonData['token'].toString();
//         print(jsonData['companies']);
//         if (jsonData['companies'].isEmpty) {
//         } else {
//           for (var i = 0; i < jsonData['companies'].length; i++) {
//             for (var j = 0; j < totalCompany.length; j++) {
//               if (totalCompany[j] == jsonData['companies'][i]['seedortype'] &&
//                   jsonData['companies'][i]['planname'] != 'Basic') {
//                 print(jsonData['companies'][i]['planname'].toString() +
//                     'plan name');
//                 finalCompanys.add(CompanyNames(
//                     companyName: jsonData['companies'][i]['company_name'],
//                     clientId: jsonData['companies'][i]['clientid'],
//                     seedorType: jsonData['companies'][i]['seedortype'],
//                     planName: jsonData['companies'][i]['planname']));
//               }
//             }
//             // _companyNames.add(CompanyNames(
//             //     clientId: jsonData['companies'][i]['clientid'],
//             //     seedorType: jsonData['companies'][i]['seedortype'],
//             //     planName: jsonData['companies'][i]['Premium']));
//           }
//           if (finalCompanys.length == 1) {
//             await profilegetApi(
//                     userName: email,
//                     context: context,
//                     clientId: jsonData['companies'][0]['clientid'],
//                     seedorType: jsonData['companies'][0]['seedortype'])
//                 .then((value) async {
//               print(value[0].toString() + '------->>> value 1');
//               if (value[0] == 200) {
//                 var role = value[1]['roles'];
//                 for (var sus in role) {
//                   if (sus.toString() == '') {
//                     print('break');
//                     break;
//                   }
//                   print('roles');
//                   // print(sus['role_id'][1]);
//                   rolePeremission.add(sus['role_id'][1]);
//                 }
//                 print(email + '---->>>> email');
//                 prefs.setString('loginemail', email);
//                 prefs.setString('jsonToken',
//                     rememberMe ? jsonData['token'].toString() : '');
//                 prefs.setString('planName',
//                     jsonData['companies'][0]['planname'].toString());
//                 localStoageDataValue(
//                     city: value[1]['profile'][0]['city'].toString(),
//                     companyName:
//                         value[1]['profile'][0]['company_id'][1].toString(),
//                     email: value[1]['profile'][0]['email'].toString(),
//                     emplyeeId:
//                         value[1]['profile'][0]['employee_ids'][0].toString(),
//                     id: value[1]['profile'][0]['id'].toString(),
//                     imageUrl: value[1]['profile'][0]['image_1024'].toString(),
//                     jobTitle: value[1]['profile'][0]['job_title'].toString(),
//                     logAttendanceGeoLocation: value[1]['profile'][0]
//                             ['log_attendance_geolocation']
//                         .toString(),
//                     mobile: value[1]['profile'][0]['mobile'].toString(),
//                     name: value[1]['profile'][0]['name'].toString(),
//                     parentId: value[1]['profile'][0]['parent_id'].toString(),
//                     partnerId:
//                         value[1]['profile'][0]['partner_id'][0].toString(),
//                     phone: value[1]['profile'][0]['phone'].toString(),
//                     pin: value[1]['profile'][0]['zip'].toString(),
//                     street: value[1]['profile'][0]['street'].toString(),
//                     streetTwo: value[1]['profile'][0]['street2'].toString(),
//                     website: value[1]['companywebsite'].toString(),
//                     roles: rolePeremission,
//                     companyCity: value[1]['companycity'] == ""
//                         ? 'City'
//                         : value[1]['companycity'],
//                     companyPincoide: value[1]['companypincode'] == ""
//                         ? 'Pincode'
//                         : value[1]['companypincode'],
//                     companyCountry: value[1]['companycountry'] == ""
//                         ? 'Country'
//                         : value[1]['companycountry'],
//                     companyEmail: value[1]['companyemail'] == ""
//                         ? 'Email'
//                         : value[1]['companyemail'],
//                     companyPhone: value[1]['companyphone'] == ""
//                         ? 'Phone'
//                         : value[1]['companyphone'],
//                     companyState: value[1]['companystate'] == ""
//                         ? 'State'
//                         : value[1]['companystate'],
//                     companyStreetOne: value[1]['companystreet1'] == ""
//                         ? 'Street1'
//                         : value[1]['companystreet1'],
//                     companyStreetTwo: value[1]['companystreet2'] == ""
//                         ? 'Street2'
//                         : value[1]['companystreet2'],
//                     // jsonToken: rememberMe ? jsonData['token'].toString() : '',
//                     clientId: value[1]['clientid'].toString(),
//                     // planName: value[1]['planname'].toString(),
//                     seedorName: value[1]['seedorname'].toString());
//                 await registerDeviceIdApi(userName: email);
//                 Navigator.of(context).pushAndRemoveUntil(
//                     MaterialPageRoute(builder: (ctx) => HomeTabBarScreen()),
//                     (route) => false);
//                 _isLoading = false;
//                 notifyListeners();
//               } else {
//                 // await profilegetApi(
//                 //   context: context,
//                 //     userName: email,
//                 //     clientId: jsonData['companies'][0]['clientid'],
//                 //     seedorType: jsonData['companies'][0]['seedortype']);

//               }
//             });
//           } else if (finalCompanys.isEmpty) {
//             MyCustomAlertDialog().showCustomAlertdialog(
//                 context: context,
//                 title: 'Sorry',
//                 subtitle: 'Their is no company found in the user',
//                 onTapOkButt: () {
//                   Navigator.of(context).pop();
//                 });
//           } else {
//             print(finalCompanys);
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(
//                     builder: (ctx) => CompanySelectionScreen(
//                           userName: email,
//                           jsonToken: jsonToken!,
//                           companyNames: finalCompanys,
//                           // planName: jsonData['planname'],
//                         )),
//                 (route) => false);
//             _isLoading = false;
//             notifyListeners();
//           }
//         }

//         notifyListeners();

//         //   // localStoageDataValue(
//         //   //     city: jsonData['profile'][0]['city'].toString(),
//         //   //     companyName: jsonData['profile'][0]['company_id'][1].toString(),
//         //   //     email: jsonData['profile'][0]['email'].toString(),
//         //   //     emplyeeId: jsonData['profile'][0]['employee_ids'][0].toString(),
//         //   //     id: jsonData['profile'][0]['id'].toString(),
//         //   //     imageUrl: jsonData['profile'][0]['image_1024'].toString(),
//         //   //     jobTitle: jsonData['profile'][0]['job_title'].toString(),
//         //   //     logAttendanceGeoLocation: jsonData['profile'][0]
//         //   //             ['log_attendance_geolocation']
//         //   //         .toString(),
//         //   //     mobile: jsonData['profile'][0]['mobile'].toString(),
//         //   //     name: jsonData['profile'][0]['name'].toString(),
//         //   //     parentId: jsonData['profile'][0]['parent_id'].toString(),
//         //   //     partnerId: jsonData['profile'][0]['partner_id'][0].toString(),
//         //   //     phone: jsonData['profile'][0]['phone'].toString(),
//         //   //     pin: jsonData['profile'][0]['zip'].toString(),
//         //   //     street: jsonData['profile'][0]['street'].toString(),
//         //   //     streetTwo: jsonData['profile'][0]['street2'].toString(),
//         //   //     website: jsonData['companywebsite'].toString(),
//         //   //     roles: rolePeremission,
//         //   //     companyCity: jsonData['companycity'] == ""
//         //   //         ? 'City'
//         //   //         : jsonData['companycity'],
//         //   //     companyPincoide: jsonData['companypincode'] == ""
//         //   //         ? 'Pincode'
//         //   //         : jsonData['companypincode'],
//         //   //     companyCountry: jsonData['companycountry'] == ""
//         //   //         ? 'Country'
//         //   //         : jsonData['companycountry'],
//         //   //     companyEmail: jsonData['companyemail'] == ""
//         //   //         ? 'Email'
//         //   //         : jsonData['companyemail'],
//         //   //     companyPhone: jsonData['companyphone'] == ""
//         //   //         ? 'Phone'
//         //   //         : jsonData['companyphone'],
//         //   //     companyState: jsonData['companystate'] == ""
//         //   //         ? 'State'
//         //   //         : jsonData['companystate'],
//         //   //     companyStreetOne: jsonData['companystreet1'] == ""
//         //   //         ? 'Street1'
//         //   //         : jsonData['companystreet1'],
//         //   //     companyStreetTwo: jsonData['companystreet2'] == ""
//         //   //         ? 'Street2'
//         //   //         : jsonData['companystreet2'],
//         //   //     // jsonToken: rememberMe ? jsonData['token'].toString() : '',
//         //   //     clientId: jsonData['clientid'].toString(),
//         //   //     planName: jsonData['planname'].toString(),
//         //   //     seedorName: jsonData['seedorname'].toString());
//         //   Navigator.of(context).pushAndRemoveUntil(
//         //       MaterialPageRoute(builder: (ctx) => HomeTabBarScreen()),
//         //       (route) => false);
//         //   _isLoading = false;
//         //   notifyListeners();
//         // }
//         // }
//       } else if (response.statusCode == 302) {
//       } else {
//         returnResponse(
//             response: response,
//             api: jsonData['description'] ?? 'login',
//             context: context);
//         _isLoading = false;
//         notifyListeners();
//       }
//     } on SocketException catch (e) {
//       alertDialog.showCustomAlertdialog(
//         context: context,
//         title: 'Sorry',
//         subtitle: e.message.toString(),
//         onTapOkButt: () {
//           Navigator.of(context).pop();
//         },
//       );
//       _isLoading = false;
//       notifyListeners();
//     } on TimeoutException catch (e) {
//       alertDialog.showCustomAlertdialog(
//         context: context,
//         title: 'Sorry',
//         subtitle: e.message.toString(),
//         onTapOkButt: () {
//           Navigator.of(context).pop();
//         },
//       );
//       _isLoading = false;
//       notifyListeners();
//     } on HttpException catch (e) {
//       alertDialog.showCustomAlertdialog(
//         context: context,
//         title: 'Sorry',
//         subtitle: e.message.toString(),
//         onTapOkButt: () {
//           Navigator.of(context).pop();
//         },
//       );
//       _isLoading = false;
//       notifyListeners();
//     } on Exception catch (e) {
//       alertDialog.showCustomAlertdialog(
//         context: context,
//         title: 'Sorry',
//         subtitle: e.toString(),
//         onTapOkButt: () {
//           Navigator.of(context).pop();
//         },
//       );
//       _isLoading = false;
//       notifyListeners();
//     }
//     // catch (e) {
//     //   alertDialog.showCustomAlertdialog(
//     //     context: context,
//     //     title: 'Sorry',
//     //     subtitle: e.toString(),
//     //     onTapOkButt: () {
//     //       Navigator.of(context).pop();
//     //     },
//     //   );
//     //   _isLoading = false;
//     //   notifyListeners();
//     // }
//   }

//   void localStoageDataValue(
//       {required String city,
//       required String companyName,
//       required String email,
//       required String emplyeeId,
//       required String id,
//       required String imageUrl,
//       required String jobTitle,
//       required String logAttendanceGeoLocation,
//       required String mobile,
//       required String name,
//       required String parentId,
//       required String partnerId,
//       required String phone,
//       required String pin,
//       required String street,
//       required String streetTwo,
//       required String website,
//       required List<String> roles,
//       required String clientId,
//       required String seedorName,
//       required String companyEmail,
//       required String companyStreetOne,
//       required String companyStreetTwo,
//       required String companyPhone,
//       required String companyCountry,
//       required String companyState,
//       required String companyPincoide,
//       required String companyCity}) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString('city', city);
//     prefs.setString('companyName', companyName);
//     prefs.setString('email', email);
//     prefs.setString('employeId', emplyeeId);
//     prefs.setString('id', id);
//     prefs.setString('imageUrl', imageUrl);
//     prefs.setString('jobTitle', jobTitle);
//     prefs.setString('logAttendanceGeoLocation', logAttendanceGeoLocation);
//     prefs.setString('mobile', mobile);
//     prefs.setString('name', name);
//     prefs.setString('parentId', parentId);
//     prefs.setString('partnerId', partnerId);
//     prefs.setString('phone', phone);
//     prefs.setString('pin', pin);
//     prefs.setString('street', street);
//     prefs.setString('streetTwo', streetTwo);
//     prefs.setString('website', website);
//     prefs.setStringList('roles', roles);

//     prefs.setString('clientId', clientId);

//     prefs.setString('seedorName', seedorName);
//     prefs.setString('companyEmail', companyEmail);
//     prefs.setString('companyStreetone', companyStreetOne);
//     prefs.setString('companyStreetTwo', companyStreetTwo);
//     prefs.setString('companyPhone', companyPhone);
//     prefs.setString('companyCountry', companyCountry);
//     prefs.setString('companyState', companyState);
//     prefs.setString('companyPincode', companyPincoide);
//     prefs.setString('companyCity', companyCity);

//     print(prefs.getString('seedorName'));
//     print(prefs.getString('planName'));
//     print(prefs.getString('clientId'));
//     print(prefs.getString('website'));
//   }

//   Future logoutFunction({required BuildContext context}) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.clear().then((value) {
//       print('hello app logout successful');
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => const NewLoginScreen()),
//           (Route<dynamic> route) => false);
//     });
//   }

//   Future profilegetApi(
//       {required String userName,
//       required String clientId,
//       required String seedorType,
//       required BuildContext context}) async {
//     try {
//       var headers = {
//         'Content-Type': 'application/json',
//         'Cookie':
//             'session_id=c6a24e1932727ae85716659ef21eba065ca3314e; session_id=610f5c520d61a6765ce8e26c02f234bcf50469da'
//       };
//       var body = json.encode({
//         "username": userName,
//         "clientid": clientId,
//         "seedortype": seedorType,
//       });
//       print(body);
//       var response = await http.post(
//           Uri.parse('$baseApiUrl/seedor-api-profile'),
//           headers: headers,
//           body: body);

//       var jsonData = json.decode(response.body);

//       if (response.statusCode == 200) {
//         // print(jsonData);
//         return [response.statusCode, jsonData];
//       } else if (response.statusCode == 302) {
//         quantity += 1;
//         if (quantity >= 4) {
//           alertDialog.showCustomAlertdialog(
//               context: context,
//               title: 'Sorry',
//               subtitle:
//                   'Unable to Connect to the server please try again later',
//               onTapOkButt: () {
//                 Navigator.of(context).pop();
//               });
//           _isLoading = false;
//           notifyListeners();
//         } else {
//           profilegetApi(
//               userName: userName,
//               clientId: clientId,
//               seedorType: seedorType,
//               context: context);
//         }
//       } else {}
//     } catch (e) {}
//   }

//   Future registerDeviceIdApi({required String userName}) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       var headers = {
//         'Content-Type': 'application/json',
//         'Cookie':
//             'session_id=b161ecd263cad0ef56bd6055aaaf7a6e0d8b59cd; session_id=610f5c520d61a6765ce8e26c02f234bcf50469da'
//       };
//       String osType = '';
//       String decviceId = '';

//       if (Platform.isAndroid) {
//         AndroidDeviceInfo android = await deviceInfo.androidInfo;
//         osType = 'Android';
//         decviceId = android.id!;
//       } else if (Platform.isIOS) {
//         IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//         osType = 'Ios';
//         decviceId = iosInfo.identifierForVendor!;
//       }

//       var body = json.encode({
//         "username": userName,
//         "device_id": decviceId,
//         "login_source": "MOBILE",
//         "datetime": DateTime.now().toString().substring(0, 10),
//         "os_type": osType
//       });
//       print(body);

//       var response = await http.post(
//           Uri.parse(
//               '$baseApiUrl/seedor-api/login-trace/single-user-login-management'),
//           headers: headers,
//           body: body);
//       print(response.body.toString() + '----->> checking');
//       return response.statusCode;
//     } catch (e) {}
//   }

//   Future logoutApiCall({required BuildContext context}) async {
//     await userPersonalDetails.getUserDetails();
//     try {
//       var headers = {
//         'Content-Type': 'application/json',
//         'Cookie':
//             'session_id=b161ecd263cad0ef56bd6055aaaf7a6e0d8b59cd; session_id=610f5c520d61a6765ce8e26c02f234bcf50469da'
//       };
//       final prefs = await SharedPreferences.getInstance();

//       var body = json.encode({"username": userPersonalDetails.email});
//       var response = await http.post(
//           Uri.parse('$baseApiUrl/seedor-api/login-trace/log-out'),
//           headers: headers,
//           body: body);

//       if (response.statusCode == 200) {
//         showSnackBar(context: context, title: 'Logged out');
//       } else {
//         showSnackBar(context: context, title: 'Unable to logout');
//       }
//       return response.statusCode;
//     } catch (e) {}
//   }

//   Future loginStreamApical({required BuildContext context}) async {
//     try {
//       var headers = {
//         'Content-Type': 'application/json',
//         'Cookie':
//             'session_id=b161ecd263cad0ef56bd6055aaaf7a6e0d8b59cd; session_id=610f5c520d61a6765ce8e26c02f234bcf50469da'
//       };
//       final prefs = await SharedPreferences.getInstance();
//       String osType = '';
//       String decviceId = '';

//       if (Platform.isAndroid) {
//         AndroidDeviceInfo android = await deviceInfo.androidInfo;
//         osType = 'Android';
//         decviceId = android.id!;
//       } else if (Platform.isIOS) {
//         IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//         osType = 'Ios';
//         decviceId = iosInfo.identifierForVendor!;
//       }
//       await userPersonalDetails.getUserDetails();
//       print(prefs.getString('loginemail').toString() + '----->>> user name');
//       var body = json.encode({
//         "params": {
//           "username": prefs.getString('loginemail'),
//           "device_id": decviceId
//         }
//       });
//       print(body);
//       var response = await http.post(
//           Uri.parse(
//               '$baseApiUrl/services/single-login-management/get-login-status'),
//           headers: headers,
//           body: body);
//       var jsonData = json.decode(response.body);
//       if (response.statusCode == 200) {
//         print(jsonData);
//         if (jsonData['Entries']['Entry'][0]['bool'] == '0') {
//           print('------LOGOUT-------');
//           MyCustomAlertDialog().showCustomAlertdialog(
//               context: context,
//               title: 'Note',
//               subtitle: 'Another device has been logged in with same user',
//               onTapOkButt: () {
//                 logoutFunction(context: context);
//               });
//         } else {
//           print('------LOGIN-------');
//         }
//       } else {}
//       return [response.statusCode, jsonData];
//     } catch (e) {}
//   }
// }

// class CompanyNames {
//   final String clientId;
//   final String seedorType;
//   final String planName;
//   final String companyName;

//   CompanyNames({
//     required this.clientId,
//     required this.seedorType,
//     required this.planName,
//     required this.companyName,
//   });
// }
