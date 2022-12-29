import 'package:flutter/cupertino.dart';

class CountTotalModel with ChangeNotifier {
  String asn;
  String grn;
  String delivery;
  String inStock;
  String id;

  CountTotalModel({
    required this.asn,
    required this.grn,
    required this.delivery,
    required this.inStock,
    required this.id,
  });
}
