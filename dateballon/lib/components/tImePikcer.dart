import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TimePicker extends HookWidget {
  int selectedHour = DateTime.now().hour;
  int selectedMinute = DateTime.now().minute;

  List<int> hours = List.generate(24, (index) => index + 1);
  List<int> minutes = List.generate(60, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [],
    );
  }
}
