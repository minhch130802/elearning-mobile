import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with AutomaticKeepAliveClientMixin<CalendarPage> {
  DateTime _dateTimeNow = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: TableCalendar(
          firstDay: DateTime.utc(2016, 12, 24),
          lastDay: DateTime.utc(_dateTimeNow.year + 5, 12, 31),
          focusedDay: DateTime.now(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
