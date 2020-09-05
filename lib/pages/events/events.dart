import 'package:estagio_app/components/select_date_time.dart';
import 'package:estagio_app/utils/nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  var _calendarController;
  Map<DateTime, List> _events;
  List _selectedEvents;
  var _selectedDay;

  @override
  void initState() {
    _calendarController = CalendarController();
    final _selectedDay = DateTime.now();
    _events = {
      _selectedDay.subtract(Duration(days: 30)): [
        'Event A0',
        'Event B0',
        'Event C0'
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): [
        'Event A2',
        'Event B2',
        'Event C2',
        'Event D2'
      ],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): [
        'Event A4',
        'Event B4',
        'Event C4'
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Event A5',
        'Event B5',
        'Event C5'
      ],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8'
      ],
      _selectedDay.add(Duration(days: 3)):
          Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event C10'
      ],
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(Duration(days: 26)): [
        'Event A14',
        'Event B14',
        'Event C14'
      ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    super.initState();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => _addEvent(),
      ),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text("Eventos"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(15),
          child: TableCalendar(
            availableGestures: AvailableGestures.all,
            events: _events,
            onDaySelected: _onDaySelected,
            calendarController: _calendarController,
            locale: 'pt_BR',
            headerStyle: HeaderStyle(
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
              formatButtonVisible: false,
            ),
            calendarStyle: CalendarStyle(
              weekendStyle: TextStyle().copyWith(
                color: Color(0xFFFF9393),
              ),
              outsideDaysVisible: false,
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle().copyWith(color: Colors.white),
              weekendStyle: TextStyle().copyWith(color: Colors.white),
            ),
            builders: CalendarBuilders(
              markersBuilder: (context, date, events, holidays) {
                final children = <Widget>[];

                if (events.isNotEmpty) {
                  children.add(
                    Positioned(
                      right: 1,
                      bottom: 1,
                      child: _buildEventsMarker(date, events),
                    ),
                  );
                }
                return children;
              },
              selectedDayBuilder: (context, date, _) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  width: 100,
                  height: 100,
                  child: Center(
                    child: Text(
                      '${date.day}',
                    ),
                  ),
                );
              },
              todayDayBuilder: (context, date, _) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  width: 100,
                  height: 100,
                  child: Center(
                    child: Text(
                      '${date.day}',
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(child: _buildEventList()),
      ],
    );
  }

  Widget _buildEventList() {
    return _selectedEvents.length != 0
        ? ListView(
            children: _selectedEvents
                .map((event) => Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        border: Border.all(width: 0.8, color: Colors.white),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: ListTile(
                        title: Text(event.toString()),
                        onTap: () => print('$event tapped!'),
                      ),
                    ))
                .toList(),
          )
        : Container(
            child: Text("Não há eventos"),
            margin: EdgeInsets.only(top: 25),
          );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? Colors.white
            : Colors.black54,
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: _calendarController.isSelected(date)
                ? Colors.black
                : Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  _addEvent() {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return SelectDateTime(
            _createEvent,
            initialDate: _selectedDay,
          );
        }));
  }

  _createEvent(date, time) {
    print(date);
    print(time);
  }
}
