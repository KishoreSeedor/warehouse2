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
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  twoButton
                      ? ElevatedButton(onPressed: () {}, child: Text('Cancel'))
                      : Container(),
                  SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('Ok'))
                ],
              ),
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
              title: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              content: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (button == true)
                      CupertinoDialogAction(
                        child: const Text('Cancel'),
                        onPressed: () => onTapCancelButt!(),
                      ),
                    SizedBox(
                      width: 15,
                    ),
                    CupertinoDialogAction(
                      child: const Text('Ok'),
                      onPressed: () => onTapOkButt(),
                    ),
                  ],
                ),
              ],
            ),
          )
        : showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  content: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (button == true)
                          ElevatedButton(
                            child: const Text('Cancel'),
                            onPressed: () => onTapCancelButt!(),
                          ),
                        SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          child: const Text('Ok'),
                          onPressed: () => onTapOkButt(),
                        ),
                      ],
                    ),
                  ]);
            });
  }
}
