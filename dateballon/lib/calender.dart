import "dart:collection";

import "package:dateballon/components/appbarFunc.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/painting.dart";
import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";
import "package:table_calendar/table_calendar.dart";

class CalenderPage extends StatefulWidget {
  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<DateTime, List> _eventList = {};

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _eventList = {
      DateTime.now().add(Duration.zero): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8',
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventList);

    List getEventForDay(DateTime day) {
      return _events[day] ?? [];
    }

    return Scaffold(
      appBar: AppbarFunc(),
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
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: getEventForDay(_selectedDay!)
                  .map((event) => ListTile(
                        title: Text(event.toString()),
                      ))
                  .toList(),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                child: Center(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(50, 50),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  shape: CircleBorder(
                    side: BorderSide(
                      color: Colors.black,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
