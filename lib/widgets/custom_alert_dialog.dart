import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog {
  customAlertDialog(
      {required BuildContext context,
      required String title,
      required String content,
      bool twoButton = false}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              twoButton
                  ? ElevatedButton(onPressed: () {}, child: Text('Cancel'))
                  : Container(),
              ElevatedButton(onPressed: () {}, child: Text('Ok'))
            ],
          );
        });
  }
}

class MyCustomAlertDialog {
  showCustomAlertdialog({
    required BuildContext context,
    required String title,
    required String subtitle,
    bool button = false,
    required Function() onTapOkButt,
    Function()? onTapCancelButt,
  }) async {
    return Platform.isIOS
        ? showCupertinoDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(subtitle),
              actions: <Widget>[
                if (button == true)
                  CupertinoDialogAction(
                    child: const Text('Cancel'),
                    onPressed: () => onTapCancelButt!(),
                  ),
                CupertinoDialogAction(
                  child: const Text('Ok'),
                  onPressed: () => onTapOkButt(),
                ),
              ],
            ),
          )
        : showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: Text(title),
                  content: Text(subtitle),
                  actions: <Widget>[
                    if (button == true)
                      ElevatedButton(
                        child: const Text('Cancel'),
                        onPressed: () => onTapCancelButt!(),
                      ),
                    ElevatedButton(
                      child: const Text('Ok'),
                      onPressed: () => onTapOkButt(),
                    ),
                  ]);
            });
  }
}
