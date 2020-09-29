import 'dart:io';

import 'package:estagio_app/api/api_response.dart';
import 'package:estagio_app/components/search_bar.dart';
import 'package:estagio_app/components/spreadsheet_item.dart';
import 'package:estagio_app/entity/file_entity.dart';
import 'package:estagio_app/entity/user_entity.dart';
import 'package:estagio_app/pages/spreadsheets/excel_file.dart';
import 'package:estagio_app/services/file_service.dart';
import 'package:estagio_app/services/spreadsheets_service.dart';
import 'package:estagio_app/utils/alert.dart';
import 'package:estagio_app/utils/nav.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class Spreadsheets extends StatefulWidget {
  @override
  _SpreadsheetsState createState() => _SpreadsheetsState();
}

class _SpreadsheetsState extends State<Spreadsheets> {
  List<Archive> spreadsheets = [];
  SpreadsheetsService spreadsheetService = new SpreadsheetsService();
  FileService fileService = new FileService();
  User _user;
  bool _showProgress = false;
  List<Archive> filteredList = [];

  @override
  initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getSpreadsheetsFromUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text("Planilhas"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => createSpreadsheet(),
      ),
      body: _showProgress ? _loading() : _body(),
    );
  }

  _body() {
    return Container(
      child: Column(
        children: <Widget>[
          _searchBar(),
          _listOfSpreadsheets(),
        ],
      ),
    );
  }

  Widget _buildSpreadsheetItem(context, int index) {
    return SpreadsheetItem(filteredList[index], _getSpreadsheetsFromUser);
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  _getSpreadsheetsFromUser() async {
    _setShowProgress(true);
    final response = await spreadsheetService.getSpreadsheetsFromUser(_user.id);
    if (response != null && response.isOk) {
      setState(() {
        spreadsheets = response.result;
        filteredList = List.from(spreadsheets);
        _sortList();
      });
    } else {
      alert(context,
          "Ocorreu um erro ao realizar a operação. Tente novamente mais tarde.");
    }
    _setShowProgress(false);
  }

  void _sortList() {
    filteredList.sort((a, b) => b.date.compareTo(a.date));
  }

  _setShowProgress(bool state) {
    setState(() {
      _showProgress = state;
    });
  }

  _listOfSpreadsheets() {
    return filteredList.length != 0
        ? ListView.builder(
            shrinkWrap: true,
            physics: new NeverScrollableScrollPhysics(),
            itemBuilder: _buildSpreadsheetItem,
            itemCount: filteredList.length,
          )
        : Expanded(
            child: Center(
              child: Text("Não há planilhas para listar."),
            ),
          );
  }

  _searchBar() {
    return SearchBar(_filterList, "Buscar planilha");
  }

  _filterList(String term) {
    if (term.isEmpty) {
      setState(() {
        filteredList = List.from(spreadsheets);
        _sortList();
      });
      return;
    }
    setState(() {
      filteredList = spreadsheets
          .where((element) =>
              element.name.toLowerCase().contains(term.toLowerCase()))
          .toList();
      _sortList();
    });
  }

  createSpreadsheet() {
    push(context, ExcelFile());
  }
}
