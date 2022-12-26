import 'package:flutter/cupertino.dart';

class CountTotalIdModel with ChangeNotifier {
  String asn;
  String grn;
  String delivery;
  String inStock;

  CountTotalIdModel(
      {required this.asn,
      required this.grn,
      required this.delivery,
      required this.inStock});
}
