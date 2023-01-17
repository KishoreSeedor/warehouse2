import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:warehouse/models/pallet_name_model.dart';
import 'package:warehouse/screens/Receive/pallet_allocation/pallet_provider.dart';

class PalletScanAlertDialog {
  palletConfirmationDialog({required BuildContext context,required String id}) {
    final data = Provider.of<RecivePalletProvider>(context, listen: false);
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Note'),
            content: Text(
                "If you completed palletization.Click confirm to complete the process"),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.yellow)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.yellow)),
                  onPressed: () {
                    data.setLocationBarcodeScan = "";
                    data.getAllorderLineProduct(context: context, id: id);
                     data.clearparticularModelData();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          );
        });
  }
}
