import 'package:flutter/material.dart';

class Dev extends StatelessWidget {
  const Dev({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(width: 100, height: 100, color: Colors.red),
        ],
      ),
    );
  }
}
