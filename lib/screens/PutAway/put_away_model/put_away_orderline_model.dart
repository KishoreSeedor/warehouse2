import 'package:flutter/material.dart';

class PutAwayOrdersModel with ChangeNotifier{
  String barcode;
  String createDate;
  String date;
  String displayName;
  String id;
  String origin;
  String partnerId;
  String companyName;
  String scheduledDate;
  String transportDate;
  String skuId;

  PutAwayOrdersModel({
    required this.barcode,
    required this.createDate,
    required this.date,
    required this.displayName,
    required this.id,
    required this.origin,
    required this.partnerId,
    required this.companyName,
    required this.scheduledDate,
    required this.transportDate,
    required this.skuId,
  });
}
