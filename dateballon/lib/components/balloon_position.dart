import 'dart:math';

import 'package:flutter/material.dart';

/// 締切テキスト(M/D hh:mm)をDateTimeに変換
DateTime parseDeadline(String dateLine) {
  final parts = dateLine.split(' ');
  final dateParts = parts[0].split('/');
  final timeParts = parts[1].split(':');
  final now = DateTime.now();

  return DateTime(
    now.year,
    int.parse(dateParts[0]), // 月
    int.parse(dateParts[1]), // 日
    int.parse(timeParts[0]), // 時
    int.parse(timeParts[1]), // 分
    0, // 秒（常に0秒）
  );
}

/// 縦位置を計算（残り秒数で自然上昇）
double calculateTopOffset({
  required DateTime deadline,
  required Size screenSize,
}) {
  final now = DateTime.now();
  final diffDays = deadline.difference(now).inDays;
  final maxHeight = screenSize.height;

  if (diffDays > 7) {
    return maxHeight; // 7日前より前なら一番下
  } else if (diffDays <= 0) {
    return 0; // 当日は一番上
  } else {
    // 1日ごとに1/8ずつ上がる
    return maxHeight * (diffDays / 8);
  }
}

/// 横位置をランダム生成（重なり防止）
double generateRandomLeftOffset(
  List<double> existingOffsets,
  double screenWidth,
  Random random,
) {
  double newOffset;
  do {
    newOffset = random.nextDouble() * (screenWidth - 100); // BalloonCard幅100想定
  } while (existingOffsets.any((offset) => (offset - newOffset).abs() < 100));
  return newOffset;
}
