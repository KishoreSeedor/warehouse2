class InventryProductModel {
  final String id;
  final String location;
  final String name;
  final double quantityInHand;
  final String partnerId;
  final String partnerName;
  final String invertryId;
  final double productQuantity;
  final String packUnit;
  final String productLot;
  double textQuantity;

  InventryProductModel({
    required this.id,
    required this.location,
    required this.name,
    required this.quantityInHand,
    required this.partnerId,
    required this.partnerName,
    required this.invertryId,
    required this.productQuantity,
    required this.packUnit,
    required this.productLot,
    required this.textQuantity,
  });
}
