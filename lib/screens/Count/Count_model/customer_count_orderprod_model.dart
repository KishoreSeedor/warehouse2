import 'package:flutter/cupertino.dart';

class CustomerCountOrderProd {
  final String id;
  final String companyName;
  final String displayName;
  final List<dynamic> moveLineIds;

  CustomerCountOrderProd(
      {required this.id,
      required this.companyName,
      required this.displayName,
      required this.moveLineIds});
}
