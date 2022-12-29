import 'package:flutter/material.dart';

class PutawayOrderLineModel with ChangeNotifier {
  final String id;
  final String locationDest;
  final String locationDestinationName;
  final String productname;
  final String quantity;
  final String productId;
  final String skuId;
  final String locationBarcode;

  PutawayOrderLineModel({
    required this.id,
    required this.locationDest,
    required this.productname,
    required this.quantity,
    required this.locationDestinationName,
    required this.productId,
    required this.skuId,
    required this.locationBarcode,
  });
}
