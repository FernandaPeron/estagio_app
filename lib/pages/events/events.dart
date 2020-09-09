import 'dart:developer';

import 'package:estagio_app/components/select_date_time.dart';
import 'package:estagio_app/entity/event_entity.dart';
import 'package:estagio_app/entity/user_entity.dart';
import 'package:estagio_app/services/event_service.dart';
import 'package:estagio_app/utils/date.dart';
import 'package:estagio_app/utils/nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  var _calendarController;
  Map<DateTime, List> _events;
  List _selectedEvents = [];
  EventService eventService = new EventService();
  DateUtils dateUtils = new DateUtils();
  var _selectedDay;

  @override
  void initState() {
    _calendarController = CalendarController();
    final _selectedDay = DateTime.now();
    _handleEvents();
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
            availableGestures: AvailableGestures.horizontalSwipe,
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

  _createEvent(DateTime date, TimeOfDay time, name) {
    User user = Provider.of<User>(context, listen: false);
    var datetime = DateTime(date.year, date.month,
        date.day, time.hour, time.minute);
    var formattedTime = dateUtils.formatDate("HH:mm", datetime.toString());
    var event = new Event(eventName: name, date: date.toIso8601String(), time: formattedTime);
    eventService.insertEvent(user.id, event);
  }

  void _handleEvents() async {
    User user = Provider.of<User>(context, listen: false);
    var events = await eventService.getAllMappedFromUser(user.id);
    var selectedEvents = _events != null ? _events[_selectedDay] : null;
    _selectedEvents = selectedEvents != null ? selectedEvents : [];
  }
}
