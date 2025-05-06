import 'package:dateballon/components/event.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<Event>> fetchEventsFromSupabase() async {
  final supabase = Supabase.instance.client;
  final userId = supabase.auth.currentUser?.id;
  if (userId == null) return [];

  final calendarListResponse = await supabase
      .from('calenders_lists')
      .select('calenders_list_id')
      .eq('user_id', userId)
      .maybeSingle();

  if (calendarListResponse == null ||
      calendarListResponse['calenders_list_id'] == null) return [];

  final listId = calendarListResponse['calenders_list_id'];

  final response =
      await supabase.from('calenders').select().eq('calenders_list_id', listId);

  return response.map<Event>((item) {
    final date =
        DateTime.parse(item['study'] == true ? item['dateLine'] : item['date']);

    final endTime = _parseTime(item['end_time']);

    if (item['study'] == true || item['start_time'] == null) {
      return Event(
        title: item['schedule'] ?? '(無題)',
        date: DateTime(date.year, date.month, date.day),
        start: null,
        end: endTime,
        isWeekly: item['repeat'] ?? false,
        isKadai: true,
        id: item['calender_id'],
      );
    } else {
      // イベント（予定）の場合
      final startTime = _parseTime(item['start_time']);
      return Event(
        title: item['schedule'] ?? '(無題)',
        date: DateTime(date.year, date.month, date.day),
        start: startTime,
        end: endTime,
        isWeekly: item['repeat'] ?? false,
        isKadai: false,
        id: item['calender_id'],
      );
    }
  }).toList();
}

TimeOfDay _parseTime(String timeStr) {
  final parts = timeStr.split(':').map(int.parse).toList();
  return TimeOfDay(hour: parts[0], minute: parts[1]);
}

Map<DateTime, List<Event>> groupEventsByDate(List<Event> events) {
  final Map<DateTime, List<Event>> data = {};
  final now = DateTime.now();

  for (final event in events) {
    if (event.isWeekly) {
      // 毎週繰り返しなら、未来数週間分に複製
      for (int i = 0; i < 8; i++) {
        final baseDate = event.date;
        final next = baseDate.add(Duration(days: 7 * i));
        final key = DateTime(next.year, next.month, next.day);
        data.putIfAbsent(key, () => []).add(event);
      }
    } else {
      final key = DateTime(event.date.year, event.date.month, event.date.day);
      data.putIfAbsent(key, () => []).add(event);
    }
  }

  return data;
}
