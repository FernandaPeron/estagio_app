import 'package:estagio_app/components/drawer_list.dart';
import 'package:estagio_app/components/list_item.dart';
import 'package:estagio_app/pages/FAQ/faq.dart';
import 'package:estagio_app/pages/alarms/alarms.dart';
import 'package:estagio_app/pages/events/events.dart';
import 'package:estagio_app/pages/files/files.dart';
import 'package:estagio_app/pages/spreadsheets/spreadsheets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerList(),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text("FEITEP Energética"),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          _spreadsheets(),
          _events(),
          _alarms(),
          _files(),
          _faq(),
        ],
      ),
    );
  }

  _spreadsheets() {
    return ListItem(
      "Planilhas",
      FontAwesomeIcons.table,
      Spreadsheets(),
    );
  }

  _events() {
    return ListItem(
      "Eventos",
      FontAwesomeIcons.calendarDay,
      Events(),
    );
  }

  _alarms() {
    return ListItem(
      "Alarmes",
      FontAwesomeIcons.solidClock,
      Alarms(),
    );
  }

  _files() {
    return ListItem(
      "Arquivos",
      FontAwesomeIcons.solidFile,
      Files(),
    );
  }

  _faq() {
    return ListItem(
      "FAQ",
      FontAwesomeIcons.solidQuestionCircle,
      FAQ(),
    );
  }
}
