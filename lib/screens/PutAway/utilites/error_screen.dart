import 'package:flutter/material.dart';

class ErrorScreenPutAway extends StatelessWidget {
  final String title;
  const ErrorScreenPutAway({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
            color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }
}
