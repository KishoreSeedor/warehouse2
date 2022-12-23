import 'package:flutter/cupertino.dart';

class PickLinesModel with ChangeNotifier {
  final String id;
  final String locationDest;
  final String locationDestinationName;
  final String productname;
  final String quantity;
  final String productId;

  PickLinesModel(
      {required this.id,
      required this.locationDest,
      required this.productname,
      required this.quantity,
      required this.locationDestinationName,
      required this.productId});
}
