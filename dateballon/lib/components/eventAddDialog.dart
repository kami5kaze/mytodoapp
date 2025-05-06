import 'package:dateballon/components/errorDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddDialog extends HookWidget {
  final DateTime selectedDay;
  const AddDialog({super.key, required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    final TextEditingController eventEditingController =
        useTextEditingController();
    final TextEditingController studyEditingController =
        useTextEditingController();
    final startTime = useState(TimeOfDay.now());
    final endTime = useState(
      TimeOfDay(hour: startTime.value.hour + 1, minute: startTime.value.minute),
    );
    final value = useState(false);

    return Dialog(
      child: DefaultTabController(
        length: 2,
        child: SizedBox(
          height: 300,
          width: 450,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: '予定'),
                  Tab(text: '課題'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _EventForm(
                      eventEditingController,
                      startTime,
                      endTime,
                      value,
                      selectedDay,
                      context,
                    ),
                    _TaskForm(
                      studyEditingController,
                      startTime,
                      endTime,
                      value,
                      selectedDay,
                      context,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _EventForm(
    TextEditingController titleEditingController,
    ValueNotifier<TimeOfDay> startTime,
    ValueNotifier<TimeOfDay> endTime,
    ValueNotifier<bool> value,
    DateTime selectedDay,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text('予定 : '),
              Expanded(
                child: TextField(
                  controller: titleEditingController,
                  decoration: const InputDecoration(labelText: 'タイトル'),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('開始時間 : '),
              TextButton(
                onPressed: () async {
                  final newTime = await pickTimer(context, startTime.value);
                  if (newTime != null) startTime.value = newTime;
                },
                child:
                    Text('${startTime.value.hour}:${startTime.value.minute}'),
              ),
              const Text('終了時間 : '),
              TextButton(
                onPressed: () async {
                  final newTime = await pickTimer(context,
                      endTime.value); // Fixed by moving pickTimer outside build
                  if (newTime != null) endTime.value = newTime;
                },
                child: Text('${endTime.value.hour}:${endTime.value.minute}'),
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.all(5),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const Text("毎週"),
          //       Switch(
          //         value: value.value,
          //         onChanged: (bool newValue) {
          //           value.value = newValue;
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: ElevatedButton(
              onPressed: () async {
                final supabase = Supabase.instance.client;
                final userId = supabase.auth.currentUser!.id;
                // print(userId);
                final calednerListId = await supabase
                    .from('calenders_lists')
                    .select('calenders_list_id')
                    .eq('user_id', userId)
                    .maybeSingle();
                if (calednerListId == null) {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        const ErrorDialog(message: 'カレンダーリストが見つかりませんでした'),
                  );
                } else {
                  final start = timeOfDayToString(startTime.value);
                  final end = timeOfDayToString(endTime.value);
                  await supabase.from('calenders').insert({
                    'calenders_list_id': calednerListId['calenders_list_id'],
                    'schedule': titleEditingController.text,
                    'date': selectedDay.toIso8601String().split('T').first,
                    'start_time': start,
                    'end_time': end,
                    'repeat': value.value,
                  });
                }
                Navigator.of(context).pop(true);
              },
              child: const Text('追加'),
            ),
          ),
        ],
      ),
    );
  }

  _TaskForm(
    TextEditingController titleEditingController,
    ValueNotifier<TimeOfDay> startTime,
    ValueNotifier<TimeOfDay> endTime,
    ValueNotifier<bool> value,
    DateTime selectedDay,
    BuildContext context,
  ) {
    final dateLine = useState(DateTime.now());
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text('課題 : '),
              Expanded(
                child: TextField(
                  controller: titleEditingController,
                  decoration: const InputDecoration(labelText: 'タイトル'),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("締め切り"),
                TextButton(
                  child: Text(
                      '${dateLine.value.year}/${dateLine.value.month}/${dateLine.value.day}'),
                  onPressed: () async {
                    final newDate = await pickDate(context, dateLine.value);
                    if (newDate != null) {
                      dateLine.value = newDate;
                    }
                  },
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Text('終了時間 : '),
              TextButton(
                onPressed: () async {
                  final newTime = await pickTimer(context,
                      endTime.value); // Fixed by moving pickTimer outside build
                  if (newTime != null) endTime.value = newTime;
                },
                child: Text('${endTime.value.hour}:${endTime.value.minute}'),
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.all(5),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const Text("毎週"),
          //       Switch(
          //         value: value.value,
          //         onChanged: (bool newValue) => value.value = newValue,
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: ElevatedButton(
              onPressed: () async {
                final supabase = Supabase.instance.client;
                final userId = supabase.auth.currentUser!.id;

                final calednerListId = await supabase
                    .from('calenders_lists')
                    .select('calenders_list_id')
                    .eq('user_id', userId)
                    .maybeSingle();
                if (calednerListId == null) {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        const ErrorDialog(message: 'カレンダーリストが見つかりませんでした'),
                  );
                } else {
                  try {
                    final start = timeOfDayToString(startTime.value);
                    final end = timeOfDayToString(endTime.value);
                    await supabase.from('calenders').insert({
                      'calenders_list_id': calednerListId['calenders_list_id'],
                      'schedule': titleEditingController.text,
                      'date': selectedDay.toIso8601String().split('T').first,
                      'dateLine':
                          dateLine.value.toIso8601String().split('T').first,
                      'study': true,
                      'end_time': end,
                      'repeat': value.value,
                    });
                  } catch (e) {
                    print('Supabase Insert Error: $e');
                  }
                  Navigator.of(context).pop(true);
                }
              },
              child: const Text('追加'),
            ),
          ),
        ],
      ),
    );
  }
}

Future<TimeOfDay?> pickTimer(
    BuildContext context, TimeOfDay initialTime) async {
  final newTime = await showTimePicker(
    context: context,
    initialTime: initialTime,
    initialEntryMode: TimePickerEntryMode.dialOnly,
  );
  return newTime;
}

Future<DateTime?> pickDate(BuildContext context, DateTime initialDate) async {
  final newDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime.now().subtract(const Duration(days: 365 * 2)),
    lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
  );
  return newDate;
}

String timeOfDayToString(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute:00';
}
