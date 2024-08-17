import 'package:flutter/material.dart';

class Event {
  final String title;
  final TimeOfDay start;
  final TimeOfDay end;
  final bool isWeekly;

  Event({
    required this.title,
    required this.start,
    required this.end,
    this.isWeekly = false,
  });
}
