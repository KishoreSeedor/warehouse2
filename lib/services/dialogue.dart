import 'package:flutter/material.dart';

class GlobalServices {
  customDialog(BuildContext context, String title, String subtitle) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(title),
            content: Text(
              subtitle,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok')),
            ],
          );
        });
  }
}
