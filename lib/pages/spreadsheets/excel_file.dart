import 'package:estagio_app/entity/file_entity.dart';
import 'package:estagio_app/utils/string_id_generator.dart';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class ExcelFile extends StatefulWidget {
  final Archive archive;

  ExcelFile({this.archive});

  @override
  _ExcelFileState createState() => _ExcelFileState();
}

class _ExcelFileState extends State<ExcelFile> {
  final columns = 26;
  final rows = 21;
  final stringId = new StringIdGenerator();
  var excel;
  var bytes;
  List<String> titleColumn = [];
  List<String> titleRow = [];
  List<List<String>> data;

  @override
  void initState() {
    if (widget.archive == null) {
      excel = Excel.createExcel();
    }
    super.initState();
  }

  List<String> _makeTitleColumn() =>
      List.generate(columns, (i) => stringId.next(i));

  List<String> _makeTitleRow() => List.generate(rows, (i) => '$i');

  @override
  Widget build(BuildContext context) {
    titleColumn = _makeTitleColumn();
    titleRow = _makeTitleRow();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.archive != null ? widget.archive.name : ''),
      ),
      body: StickyHeadersTable(
        cellDimensions: CellDimensions(
          stickyLegendWidth: 60,
          stickyLegendHeight: 30,
          contentCellWidth: 80,
          contentCellHeight: 45,
        ),
        columnsLength: titleColumn.length,
        rowsLength: titleRow.length,
        columnsTitleBuilder: (i) => Text(titleColumn[i]),
        rowsTitleBuilder: (i) => Text(titleRow[i]),
        contentCellBuilder: (i, j) => Container(
          height: 60,
          width: 105,
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: Color(0xFFE7E7E7),
            border: Border.all(width: 0.8, color: Colors.black),
          ),
          child: TextField(
            style: TextStyle(color: Colors.black, fontSize: 18, height: 1.7),
            decoration: InputDecoration(focusedBorder: InputBorder.none, border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
