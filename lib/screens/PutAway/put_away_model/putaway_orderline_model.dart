import 'package:flutter/material.dart';

class PutawayOrderLineModel with ChangeNotifier {
  final String id;
  final String palletDest;
  final String palletDestinationName;
  final String productname;
  final String quantity;
  final String productId;
  final String skuId;
  final String locationBarcode;
  final double prodlength;
  final double prodBreath;
  final double prodHeight;
  

  PutawayOrderLineModel({
    required this.id,
    required this.palletDest,
    required this.productname,
    required this.quantity,
    required this.palletDestinationName,
    required this.productId,
    required this.skuId,
    required this.locationBarcode,
    required this.prodBreath,
    required this.prodHeight,
    required this.prodlength
  });
}
