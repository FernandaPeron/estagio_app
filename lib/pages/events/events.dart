import 'package:estagio_app/components/select_date_time.dart';
import 'package:estagio_app/entity/event_entity.dart';
import 'package:estagio_app/entity/user_entity.dart';
import 'package:estagio_app/services/event_service.dart';
import 'package:estagio_app/utils/alert.dart';
import 'package:estagio_app/utils/confirm_dialog.dart';
import 'package:estagio_app/utils/date.dart';
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
  var _selectedDay = new DateTime.now();

  @override
  void initState() {
    _calendarController = CalendarController();
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
    return ListView(
      children: [
        _calendar(),
        Container(child: _buildEventList()),
      ],
    );
  }

  _buildEventList() {
    return _selectedEvents.length != 0
        ? _listViewEvent()
        : _noEventsContainer();
  }

  _noEventsContainer() {
    return Container(
      child: Text("Não há eventos"),
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 25),
    );
  }

  _calendar() {
    return Container(
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
            return _markersBuilder(events, date);
          },
          selectedDayBuilder: (context, date, _) {
            return _selectedDayBuilder(context, date);
          },
          todayDayBuilder: (context, date, _) {
            return _todayDayBuilder(context, date);
          },
        ),
      ),
    );
  }

  _todayDayBuilder(BuildContext context, DateTime date) {
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
  }

  _selectedDayBuilder(BuildContext context, DateTime date) {
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
  }

  _markersBuilder(List events, DateTime date) {
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
  }

  _listViewEvent() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 80),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: _selectedEvents.map((event) => _eventItem(event)).toList(),
      ),
    );
  }

  Container _eventItem(event) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        border: Border.all(width: 0.8, color: Colors.white),
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        title: Text(
          event.eventName,
          style: TextStyle(
            decoration: event.completed
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          _eventSubtitle(event),
          style: TextStyle(
            color: Colors.white60,
          ),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              Container(
                width: 50,
                child: FlatButton(
                  onPressed: () => _toggleEvent(event),
                  child: Icon(
                    event.completed ? Icons.check_box : Icons.check_box_outline_blank,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: 50,
                child: FlatButton(
                  onPressed: () => _confirmDeleteEvent(event),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildEventsMarker(DateTime date, List events) {
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

  _createEvent(DateTime date, TimeOfDay time, name) async {
    User user = Provider.of<User>(context, listen: false);
    Navigator.pop(context);
    var event = new Event(eventName: name, date: date, time: time);
    var response = await eventService.insertEvent(user.id, event);
    if (response.isOk) {
      alert(context, "Evento criado com sucesso!");
    } else {
      alert(context, response.msg);
    }
    _handleEvents();
  }

  _toggleEvent(event) async {
    var response = await eventService.completeResetEvent(event);
    if (!response.isOk) {
      alert(context, response.msg);
    }
    _handleEvents();
  }

  void _handleEvents() async {
    User user = Provider.of<User>(context, listen: false);
    var response = await eventService.getAllMappedFromUser(user.id);
    if (response.isOk) {
      setState(() {
        _events = response.result;
      });
    }
    setState(() {
      _selectedDay =
          new DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
      var selectedEvents = _events != null ? _events[_selectedDay] : null;
      _selectedEvents = selectedEvents != null ? selectedEvents : [];
    });
  }

  _eventSubtitle(Event event) {
    var originalDate = event.date;
    var originalTime = event.time;
    var date = new DateTime(originalDate.year, originalDate.month,
        originalDate.day, originalTime.hour, originalTime.minute);
    return dateUtils.formatDate(
        "dd/MM/yyyy 'às' HH:mm", date.toIso8601String());
  }

  _confirmDeleteEvent(event) {
    showDialog(
        context: context,
        builder: (context) {
          return ConfirmDialog(_deleteEvent, "Deseja excluir o evento?",
              functionParam: event);
        });
  }

  _deleteEvent(Event event) async {
    var result = await eventService.deleteEvent(event.id);
    if (result.isOk) {
      _handleEvents();
      alert(context, "Evento excluído com sucesso!");
    } else {
      alert(context, result.msg);
    }
  }
}
