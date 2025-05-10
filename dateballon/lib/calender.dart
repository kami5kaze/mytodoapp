import "dart:collection";

import "package:dateballon/components/appbarFunc.dart";
import "package:dateballon/components/event.dart";
import "package:dateballon/components/eventAddDialog.dart";
import "package:dateballon/components/fetchEvent.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:table_calendar/table_calendar.dart";

class CalenderPage extends HookWidget {
  final _focusedDay = useState(DateTime.now());
  final _selectedDay = useState(DateTime.now());
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final _eventList = useState<Map<DateTime, List<Event>>>({});

  CalenderPage({super.key});

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  Future<void> loadEvents() async {
    final events = await fetchEventsFromSupabase();
    final grouped = groupEventsByDate(events);
    _eventList.value = grouped;
  }

  @override
  Widget build(BuildContext context) {
    final events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventList.value);

    List getEventForDay(DateTime day) {
      return events[day] ?? [];
    }

    useEffect(() {
      loadEvents();
      return null;
    }, []);

    return Scaffold(
      appBar: const AppbarFunc(),
      body: Stack(
        children: [
          Column(
            children: [
              TableCalendar(
                //locale: 'ja_JP',
                focusedDay: _focusedDay.value,
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2043, 12, 31),
                eventLoader: getEventForDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay.value, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay.value, selectedDay)) {
                    _selectedDay.value = selectedDay;
                    _focusedDay.value = focusedDay;
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay.value = focusedDay;
                },
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 80),
                  shrinkWrap: true,
                  children: getEventForDay(_selectedDay.value)
                      .map((event) => Container(
                            width: 100,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(event.title),
                                  if (event.isKadai || event.start == null)
                                    Text('~ ${_formatTime(event.end)}'),
                                  if (!event.isKadai)
                                    Text(
                                        '${_formatTime(event.start)} ~ ${_formatTime(event.end)}'),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(40, 40),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Colors.black,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onPressed: () async {
                  final result = await showDialog<bool>(
                    context: context,
                    builder: (context) => AddDialog(
                      selectedDay: _selectedDay.value,
                    ),
                  );
                  if (result == true) {
                    await loadEvents();
                  }
                },
                child: const Center(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _formatTime(TimeOfDay? time) {
  if (time == null) return '';
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}
