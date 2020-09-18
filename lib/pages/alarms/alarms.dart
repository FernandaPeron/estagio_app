import 'package:estagio_app/components/drawer_list.dart';
import 'package:flutter/material.dart';

class Alarms extends StatefulWidget {
  @override
  _AlarmsState createState() => _AlarmsState();
}

class _AlarmsState extends State<Alarms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text("Alarmes"),
      ),
      body: Center(
        child: Image.asset(
          'assets/under_construction.png',
          width: 500,
        ),
      ),
    );
  }
}
