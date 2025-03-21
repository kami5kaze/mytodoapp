import 'package:dateballon/login.dart';
import 'package:flutter/material.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Ballon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Dev(),
      home: const LoginPage(),
      // home: const BottombarPage(),
    );
  }
}
