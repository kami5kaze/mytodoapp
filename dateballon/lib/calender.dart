import "dart:collection";

import "package:dateballon/components/appbarFunc.dart";
import "package:dateballon/components/event.dart";
import "package:dateballon/components/eventAddDialog.dart";
import "package:flutter/material.dart";
import "package:table_calendar/table_calendar.dart";

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});
  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<DateTime, List<Event>> _eventList = {};

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _eventList = {};
  }

  void addEvent(Event event) {
    if (_eventList[_focusedDay] != null) {
      _eventList[_focusedDay]!.add(event);
      //開始時間が被っている時のエラーダイアログ
      //毎週の予定の場合
    } else {
      _eventList[_focusedDay] = [event];
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventList);

    List getEventForDay(DateTime day) {
      return events[day] ?? [];
    }

    return Scaffold(
      appBar: const AppbarFunc(),
      body: Column(
        children: [
          TableCalendar(
            //locale: 'ja_JP',
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2043, 12, 31),
            eventLoader: getEventForDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                getEventForDay(selectedDay);
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: getEventForDay(_selectedDay!)
                  .map((event) => Container(
                        width: 100,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(event.title),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(50, 50),
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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddDialog(
                      onAddEvent: (event) {
                        addEvent(event);
                      },
                    ),
                  );
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
