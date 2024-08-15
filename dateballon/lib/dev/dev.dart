import 'package:dateballon/components/balloon_card.dart';
import 'package:dateballon/components/eventAddDialog.dart';
import 'package:dateballon/components/tImePikcer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Dev extends HookWidget {
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
              width: 120,
              height: 120,
              child: BalloonCard(title: 'パターン認識', time: '6/10 10:30AM'),
            ),
            AddDialog(),
            Container(
              child: TimePicker(),
            )
          ],
        ),
      ),
    );
  }
}
