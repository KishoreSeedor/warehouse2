import 'package:flutter/material.dart';

class EmptyScreenPutAway extends StatelessWidget {
  final String title;
  const EmptyScreenPutAway({super.key, required this.title});

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
