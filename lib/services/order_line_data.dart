import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/models/recived_details_model.dart';
import 'package:warehouse/services/api/recive_api.dart';
import 'package:warehouse/widgets/custom_alert_dialog.dart';
import '../models/orders_line_model.dart';
import '../models/reciveorders_model.dart';
import '../screens/Receive/receive_orders_line.dart';
import '../screens/Receive/received_order_line2.dart';
import '../screens/Receive/recieved_orders_select.dart';

class OrderListFunction {
  // OrderListFunction(barcodeId);

  Future<OrderLine?> orderLineData(
      {required BuildContext context, required String barcodeId}) async {
    OrderLine? datass;

    var globalorderLine;
    for (var i = 0; i < globalorderLine.length; i++) {
      print("thired Print ${globalorderLine[i].userid}");
      if (globalorderLine[i].skuId == barcodeId) {
        datass = globalorderLine[i];
        globallineDateTwo = globalorderLine[i];
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrederLinePage2(
                      barcode: barcodeId,
                      value: globalorderLine[i],
                    )));
      }
    }
    return datass;
  }

  Future<String?> appBarData(
      {required BuildContext context, required String barcodeId}) async {
    for (var i = 0; i < globalorderLine.length; i++) {
      if (globalorderLine[i].pickingId == barcodeId) {
        globallineDateTwo = globalorderLine[i];
        Text(
            '${globalorderLine[i].quantityDone.toString()}/${globalorderLine[i].productOnQty.toString()}');
      }
    }
  }

  Future<RecivedOrdersModel?> orderBarcode(
      {required BuildContext context, required String barcodeId}) async {
    RecivedOrdersModel newDetail;

    final idGet = Provider.of<RecieveAPI>(context, listen: false).rec;

    final users = Provider.of<RecieveAPI>(context, listen: false);

    for (var i = 0; i < idGet.length; i++) {
      print("idGet--->${idGet.length}---${idGet[i].id + '--' + barcodeId}");
      if (idGet[i].id == barcodeId) {
        print("idValue1 ${idGet[i].id.toString()}");

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => OrdersSelectPage(barcode: barcodeId)));

        users.particularOrders(context: context, domain: barcodeId);
        break;
      } else {
        print('idGet---> pop up $i -- ${idGet.length}');
        if (idGet.length == i + 1) {
          MyCustomAlertDialog().showCustomAlertdialog(
              context: context,
              title: 'Barcode',
              subtitle: 'Please scan valid barcode',
              onTapOkButt: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
        }
      }
    }
  }
}
