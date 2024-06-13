import 'package:flutter/material.dart';

class DialogUtils {
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ops'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child:  Text('OK 👍'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
