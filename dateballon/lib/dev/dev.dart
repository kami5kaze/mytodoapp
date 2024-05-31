import 'package:dateballon/components/balloon_card.dart';
import 'package:flutter/material.dart';

class Dev extends StatelessWidget {
  const Dev({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dev')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 100, height: 100, color: Colors.red),
            Container(
              width: 100,
              height: 100,
              child: BalloonCard(title: 'title', time: 'time'),
            ),
          ],
        ),
      ),
    );
  }
}
