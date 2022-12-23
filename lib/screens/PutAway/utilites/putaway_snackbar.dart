  import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String title}) {
  final snackBar = SnackBar(
    backgroundColor: Colors.yellowAccent,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    content: Text(title,style:const TextStyle(color: Colors.black),),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

          
                       