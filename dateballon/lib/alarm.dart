import 'package:dateballon/components/appbarFunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AlarmPage extends HookWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarFunc(),
      body: Container(child: const Text('Alarm')),
    );
  }
}
