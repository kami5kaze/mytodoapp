import 'package:flutter/material.dart';

class Event {
  final String title;
  final TimeOfDay? start;
  final TimeOfDay end;
  final bool isWeekly;
  final bool isKadai;
  final DateTime date; // 表示対象の日付（必須）
  final DateTime? dateLine; // イベントの日付（任意）
  final String? id; // Supabaseから取得したID（任意）

  Event({
    required this.title,
    required this.start,
    required this.end,
    required this.date,
    this.id,
    this.dateLine,
    this.isWeekly = false,
    this.isKadai = false,
  });
}
