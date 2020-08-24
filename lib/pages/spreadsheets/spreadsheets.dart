import 'package:estagio_app/components/drawer_list.dart';
import 'package:flutter/material.dart';

class Spreadsheets extends StatefulWidget {
  @override
  _SpreadsheetsState createState() => _SpreadsheetsState();
}

class _SpreadsheetsState extends State<Spreadsheets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text("Planilhas"),
      ),
      body: Container(),
    );
  }
}
