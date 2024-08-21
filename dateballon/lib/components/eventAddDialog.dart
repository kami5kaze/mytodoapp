import 'package:dateballon/components/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddDialog extends HookWidget {
  final Function(Event) onAddEvent;
  AddDialog({required this.onAddEvent});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleEditingController =
        TextEditingController();
    final startTime = useState(TimeOfDay.now());
    final endTime = useState(
      TimeOfDay(hour: startTime.value.hour + 1, minute: startTime.value.minute),
    );
    final value = useState(false);
    void onChanged(bool newValue) {
      value.value = newValue;
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

    return Container(
      width: 350,
      height: 300,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                //タイトル
                Text('イベント名:'),
                SizedBox(
                  width: 230,
                  height: 60,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    //タイトル入力
                    child: TextField(
                      controller: titleEditingController,
                      decoration: InputDecoration(
                        hintText: '  title',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.1),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //開始・終了時間
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //コンポーネント化
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () async {
                      final selectedSTime =
                          await pickTimer(context, startTime.value);
                      if (selectedSTime != null) {
                        startTime.value = selectedSTime;
                      }
                    },
                    child: Text('開始：${startTime.value.format(context)}'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () async {
                      final selectedETime =
                          await pickTimer(context, endTime.value);
                      if (selectedETime != null) {
                        endTime.value = selectedETime;
                      }
                    },
                    child: Text('終了：${endTime.value.format(context)}'),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('毎週', style: TextStyle(fontSize: 18)),
                CupertinoSwitch(
                  onChanged: onChanged,
                  value: value.value,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                Event event = Event(
                  title: titleEditingController.text,
                  start: startTime.value,
                  end: endTime.value,
                  isWeekly: value.value,
                );
                onAddEvent(event);
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}
