import 'package:estagio_app/components/alarm_item.dart';
import 'package:estagio_app/components/select_date_time.dart';
import 'package:estagio_app/entity/alarm_entity.dart';
import 'package:flutter/material.dart';

class Alarms extends StatefulWidget {
  @override
  _AlarmsState createState() => _AlarmsState();
}

class _AlarmsState extends State<Alarms> {
  List<Alarm> alarms = [
    new Alarm(
      id: 'id1',
      description: 'nome do alarme',
      date: DateTime.now(),
      time: TimeOfDay.now(),
    ),
    new Alarm(
      id: 'id2',
      description: 'nome do alarme 2',
      date: DateTime.now(),
      time: TimeOfDay.now().replacing(hour: 10),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => _addAlarm(),
      ),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text("Alarmes"),
      ),
      body: _body(),
    );
  }

  _body() {
    return alarms.length != 0 ? _alarmsList() : _noAlarmsWarning();
  }

  Expanded _noAlarmsWarning() {
    return Expanded(
      child: Center(
        child: Text("Não há alarmes para listar."),
      ),
    );
  }

  Container _alarmsList() {
    return Container(
      margin: EdgeInsets.all(15),
      child: ListView.builder(
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        itemBuilder: _buildAlarmItem,
        itemCount: alarms.length,
      ),
    );
  }

  Widget _buildAlarmItem(BuildContext context, int index) {
    return AlarmItem(alarms[index]);
  }

  _addAlarm() {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.black38,
      pageBuilder: (BuildContext context, _, __) {
        return SelectDateTime(
          () => {},
        );
      }));
  }
}
