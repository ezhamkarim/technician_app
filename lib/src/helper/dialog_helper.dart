import 'package:flutter/material.dart';

class DialogHelper {
  static Future dialogWithAction(
      BuildContext context, String title, String desc,
      {required void Function() onPressed}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(desc),
            actions: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              ElevatedButton(onPressed: onPressed, child: const Text('Okay'))
            ],
          );
        });
  }
}
