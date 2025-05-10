import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/timezone.dart' as tz;

void setupDailyNotification() async {
  final scheduleText = await fetchTodaysScheduleText();
  await scheduleDailyNotification(scheduleText);
}

// 通知登録
Future<void> scheduleDailyNotification(String bodyText) async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final tommorow7am = tz.TZDateTime.local(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    7,
  ).add(const Duration(days: 1));

  final now = tz.TZDateTime.now(tz.local);
  final testTime = now.add(const Duration(seconds: 1)); // 今から5秒後に通知

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    '今日の予定',
    bodyText,
    tommorow7am,
    const NotificationDetails(
      android:
          AndroidNotificationDetails('daily_channel', 'Daily Notification'),
      iOS: DarwinNotificationDetails(),
    ),
    matchDateTimeComponents: null, //DateTimeComponents.time,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  );
}

Future<String> fetchTodaysScheduleText() async {
  final tommorrow = DateTime.now();

  final supabase = Supabase.instance.client;
  final userId = supabase.auth.currentUser?.id;
  if (userId == null) return '本日の予定はありません。';
  final calendarListResponse = await supabase
      .from('calenders_lists')
      .select('calenders_list_id')
      .eq('user_id', userId)
      .maybeSingle();

  final scheduleResponse = await supabase
      .from('calenders')
      .select()
      .eq(
        'calenders_list_id',
        calendarListResponse!['calenders_list_id'],
      )
      .eq('date', tommorrow)
      .eq('study', false);

  final kadaiResponse = await supabase
      .from('calenders')
      .select()
      .eq(
        'calenders_list_id',
        calendarListResponse['calenders_list_id'],
      )
      .eq('dateLine', tommorrow);

  final plans = scheduleResponse as List<dynamic>;

  final kadai = kadaiResponse as List<dynamic>;

  String planSchedule;
  if (plans.isEmpty) {
    planSchedule = 'なし';
  } else {
    final scheduleText = plans.map((task) {
      final time = task['start_time'].split(':');
      final hourMin = '${time[0]}:${time[1]}';
      return '$hourMin   ${task['schedule']}';
    }).join('\n');
    planSchedule = scheduleText;
  }

  String kadaiSchedule;
  if (kadai.isEmpty) {
    kadaiSchedule = 'なし';
  } else {
    final kadaiText = kadai.map((task) {
      final time = task['end_time'].split(':');
      final hourMin = '${time[0]}:${time[1]}';
      return '$hourMin   ${task['schedule']}';
    }).join('\n');
    kadaiSchedule = kadaiText;
  }
  final schedule = '$planSchedule\n本日の締め切り\n$kadaiSchedule';

  return schedule;
}
