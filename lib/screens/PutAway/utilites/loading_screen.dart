import 'package:flutter/material.dart';

class LoadingScreenPutAway extends StatelessWidget {
  final String title;
  const LoadingScreenPutAway({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}
