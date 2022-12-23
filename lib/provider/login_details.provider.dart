import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//in this page add loginpage geted details for charing other page

class UserDetails with ChangeNotifier {
  // ignore: non_constant_identifier_names
  String _client_id = "";

  String get clientID {
    if (_client_id == "") {
      _client_id = "Not yet updated";
      return _client_id;
    } else {
      return _client_id;
    }
  }

  String _email = "";

  String get email {
    if (_email == '') {
      _email = 'Not yet Updated';
      return _email;
    } else {
      return _email;
    }
  }

  String _name = "";

  String get name {
    if (_name == "") {
      _name = "Not yet updated";
      return _name;
    } else {
      return _name;
    }
  }

  String _id = "";

  String get id {
    if (_id == "") {
      _id = "Not yet updated";
      return _id;
    } else {
      return _id;
    }
  }

  Future<void> getAllDetails() async {
    final prefs = await SharedPreferences.getInstance();
    _client_id = prefs.getString('clientid') ?? "Not yet updated";

    _email = prefs.getString('email') ?? "Not yet updated";

    _name = prefs.getString('name') ?? 'Not yet updated';
    _id = prefs.getString('id') ?? 'Not yet updeated';
    notifyListeners();
  }
}
