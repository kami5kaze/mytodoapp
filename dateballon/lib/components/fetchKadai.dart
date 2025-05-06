import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<Kadai>> fetchKadaiFromSupabase() async {
  final supabase = Supabase.instance.client;
  final userId = supabase.auth.currentUser?.id;
  if (userId == null) return [];
  final calendarListRepo = await supabase
      .from('calenders_lists')
      .select('calenders_list_id')
      .eq('user_id', userId)
      .maybeSingle();
  if (calendarListRepo == null || calendarListRepo['calenders_list_id'] == null)
    return [];

  final kadaiRepo = await supabase
      .from('calenders')
      .select()
      .eq('calenders_list_id', calendarListRepo['calenders_list_id'])
      .eq('study', true);

  return kadaiRepo.map<Kadai>((item) {
    final date = DateTime.parse(item['dateLine']);
    return Kadai(
      title: item['schedule'] ?? '(無題)',
      dateLine: '${date.month}/${date.day} ${item['end_time']}',
      isWeekly: item['repeat'] ?? false,
    );
  }).toList();
}

class Kadai {
  final String title;
  final String dateLine;
  final bool isWeekly;

  Kadai({
    required this.title,
    required this.dateLine,
    this.isWeekly = false,
  });
}
