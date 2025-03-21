import 'package:alarm/alarm.dart';
import 'package:dateballon/components/appbarFunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AlarmPage extends HookWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarFunc(),
      body: Container(child: Text('Alarm')),
    );
  }
}
