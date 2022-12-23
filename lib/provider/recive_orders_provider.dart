import 'package:flutter/material.dart';

class ParticularOrders with ChangeNotifier {
  String _createDate = "";
  String _displayName = "";
  String _id = "";
  String _origin = "";
  String _partnerId = "";
  String _scheduledDate = "";
  String _transportDate = "";

  String get createData {
    if (_createDate == "") {
      _createDate = "Not yet updated";
      return _createDate;
    } else {
      return _createDate;
    }
  }

  String get displayName {
    if (_displayName == "") {
      _displayName = "Not yet updated";
      return _displayName;
    } else {
      return _displayName;
    }
  }

  String get id {
    if (_id == "") {
      _id = "Not yet updated";
      return _id;
    } else {
      return _id;
    }
  }

  String get orgin {
    if (_origin == "") {
      _origin = "Not yet updated";
      return _origin;
    } else {
      return _origin;
    }
  }

  String get parentId {
    if (_partnerId == "") {
      _partnerId = "Not yet updated";
      return _partnerId;
    } else {
      return _partnerId;
    }
  }

  String get scheduledDate {
    if (_scheduledDate == "") {
      _scheduledDate = "Not yet updated";
      return _scheduledDate;
    } else {
      return _scheduledDate;
    }
  }

  String get transportDate {
    if (_transportDate == "") {
      _transportDate = "Not yet updated";
      return _transportDate;
    } else {
      return _transportDate;
    }
  }
}



  // Future<void> getAllRecievedorders() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   _createDate = prefs.getString("create_date") ?? "Not yet updated";
  //   _displayName = prefs.getString("display_name") ?? "Not yet updated";
  //   _id = prefs.getString("id") ?? "Not yet updated";
  //   _origin = prefs.getString("origin") ?? "Not yet updated";
  //   _partnerId = prefs.getString("partner_id") ?? "Not yet updated";
  //   _scheduledDate = prefs.getString("scheduled_date") ?? "Not yet updated";
  //   _transportDate = prefs.getString("transport_date") ?? "Not yet updated";

  //   notifyListeners();
  // }

