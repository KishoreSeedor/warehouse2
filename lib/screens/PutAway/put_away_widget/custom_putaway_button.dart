import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PutAwayCustomButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  const PutAwayCustomButton({super.key,required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(title),
            onPressed: () {
              onTap();
            })
        : ElevatedButton(
            onPressed: () {
              onTap();
            },
            child: Text(title));
  }
}
