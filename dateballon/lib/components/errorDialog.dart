import 'package:flutter/material.dart';

class Errordialog extends StatelessWidget {
  const Errordialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('エラー'),
      content: const Text('エラーが発生しました'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
