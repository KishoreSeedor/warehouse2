class RecivedOrdersModel {
  RecivedOrdersModel({
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

  // factory RecivedOrdersModel.fromJson(Map<String, dynamic> json) =>
  //     RecivedOrdersModel(
  //       barcode: json["barcode"],
  //       createDate: DateTime.parse(json["create_date"]),
  //       date: DateTime.parse(json["date"]),
  //       displayName: json["display_name"],
  //       id: json["id"],
  //       origin: json["origin"],
  //       partnerId: List<dynamic>.from(json["partner_id"].map((x) => x)),
  //       scheduledDate: DateTime.parse(json["scheduled_date"]),
  //       transportDate: DateTime.parse(json["transport_date"]),
  //     );
}
