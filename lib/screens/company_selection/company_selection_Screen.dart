import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse/models/company_model.dart';
import 'package:warehouse/screens/login/login_api_call_warehouse.dart';

class LoginCompanySelection extends StatefulWidget {
  final String jsonToken;
  final List<LoginCompanyModel> companyNames;
  final String userName;
  // final String planName;
  const LoginCompanySelection({
    Key? key,
    required this.jsonToken,
    required this.companyNames,
    required this.userName,
    // required this.planName,
  }) : super(key: key);

  @override
  State<LoginCompanySelection> createState() => _LoginCompanySelectionState();
}

class _LoginCompanySelectionState extends State<LoginCompanySelection> {
  bool isLoading = false;
  int selectedIndex = 0;
  LoginCompanyModel? company;
  List<String> rolePeremission = [];

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<LoginWareHouseCall>(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: List.generate(widget.companyNames.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Card(
                    margin: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      color: selectedIndex == index
                          ? Colors.grey[200]
                          : Colors.white,
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(flex: 2, child: Text('Company Name')),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                      widget.companyNames[index].companyName)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex: 2, child: Text('Seedor Type')),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                      widget.companyNames[index].seedortype)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex: 2, child: Text('Planname')),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                      widget.companyNames[index].planname)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          floatingActionButton: ElevatedButton(
              child: Text(isLoading ? 'Loading' : 'Next'),
              onPressed: () async {
                if (isLoading == false) {
                  setState(() {
                    isLoading = true;
                  });
                  final prefs = await SharedPreferences.getInstance();
                  for (var i = 0; i < widget.companyNames.length; i++) {
                    if (selectedIndex == i) {
                      company = LoginCompanyModel(
                          clientid: widget.companyNames[i].clientid,
                          seedortype: widget.companyNames[i].seedortype,
                          companyName: widget.companyNames[i].companyName,
                          planname: widget.companyNames[i].planname);
                      await profile
                          .getProfileDetails(
                              context: context,
                              userEmail: widget.userName,
                              clientId: widget.companyNames[i].clientid,
                              seedorType: widget.companyNames[i].seedortype)
                          .then((value) async {
                        // print(value + 'hello hello');
                        if (value == null) {
                          setState(() {
                            isLoading = false;
                          });
                        } else if (value[0] == 200) {
                          prefs.setString('jsonToken', widget.jsonToken);
                          prefs.setString('loginemail', widget.userName);
                          prefs.setString('Plan Name', company!.planname);
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
                          // await profile.registerDeviceIdApi(
                          //     userName: widget.userName);
                          profile.localStoageDataValue(
                              city: value[1]['profile'][0]['city'].toString(),
                              companyName: value[1]['profile'][0]['company_id'][1]
                                  .toString(),
                              email: value[1]['profile'][0]['email'].toString(),
                              emplyeeId: value[1]['profile'][0]['employee_ids'][0]
                                  .toString(),
                              id: value[1]['profile'][0]['id'].toString(),
                              imageUrl: value[1]['profile'][0]['image_1024']
                                  .toString(),
                              jobTitle: value[1]['profile'][0]['job_title']
                                  .toString(),
                              logAttendanceGeoLocation: value[1]['profile'][0]
                                      ['log_attendance_geolocation']
                                  .toString(),
                              mobile:
                                  value[1]['profile'][0]['mobile'].toString(),
                              name: value[1]['profile'][0]['name'].toString(),
                              parentId: value[1]['profile'][0]['parent_id']
                                  .toString(),
                              partnerId: value[1]['profile'][0]['partner_id'][0]
                                  .toString(),
                              phone: value[1]['profile'][0]['phone'].toString(),
                              pin: value[1]['profile'][0]['zip'].toString(),
                              street:
                                  value[1]['profile'][0]['street'].toString(),
                              streetTwo:
                                  value[1]['profile'][0]['street2'].toString(),
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
                              companyEmail: value[1]['companyemail'] == "" ? 'Email' : value[1]['companyemail'],
                              companyPhone: value[1]['companyphone'] == "" ? 'Phone' : value[1]['companyphone'],
                              companyState: value[1]['companystate'] == "" ? 'State' : value[1]['companystate'],
                              companyStreetOne: value[1]['companystreet1'] == "" ? 'Street1' : value[1]['companystreet1'],
                              companyStreetTwo: value[1]['companystreet2'] == "" ? 'Street2' : value[1]['companystreet2'],
                              // jsonToken: rememberMe ? jsonData['token'].toString() : '',
                              clientID: value[1]['clientid'].toString(),
                              // planName: value[1]['planname'].toString(),
                              seedorName: value[1]['seedorname'].toString());

                          // Navigator.of(context).pushAndRemoveUntil(
                          //     MaterialPageRoute(
                          //         builder: (ctx) => const HomeTabBarScreen()),
                          //     (route) => false);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      });
                    }
                  }
                } else {}
              })),
    );
  }
}
