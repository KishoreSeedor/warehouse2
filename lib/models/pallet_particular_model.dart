class ParticularProductModel {
  final String id;
  final String productName;
  final String locationBarcode;
  final String locationDestinationId;
  final String locationId;
  final String pickingId;
  final String productId;
  final String productUomId;
  final bool resultpackageid;
  final String skuLineId;
  final double quantity;
  final String locationDestName;
  final bool isSerial;
  final String moveId;

  ParticularProductModel({
    required this.id,
    required this.productName,
    required this.locationBarcode,
    required this.locationDestinationId,
    required this.locationId,
    required this.pickingId,
    required this.productId,
    required this.productUomId,
    required this.resultpackageid,
    required this.skuLineId,
    required this.quantity,
    required this.locationDestName,
    required this.isSerial,
    required this.moveId,
  });
}
