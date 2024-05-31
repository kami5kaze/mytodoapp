import 'package:dateballon/components/bottombarFunc.dart';
import 'package:dateballon/dev/dev.dart';
import 'package:flutter/material.dart';

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Ballon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Dev(),
      home: BottombarFunc(),
    );
  }
}
