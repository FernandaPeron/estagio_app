import 'package:estagio_app/utils/string_id_generator.dart';
import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class ExcelFile extends StatefulWidget {

  final fileName;

  ExcelFile(this.fileName);

  @override
  _ExcelFileState createState() => _ExcelFileState();
}

class _ExcelFileState extends State<ExcelFile> {

  final columns = 10;
  final rows = 20;
  StringIdGenerator stringId = new StringIdGenerator();
  List<List<String>> data = [];
  List<String> titleColumn = [];
  List<String> titleRow = [];

  List<List<String>> _makeData() {
    final List<List<String>> output = [];
    for (int i = 0; i < columns; i++) {
      final List<String> row = [];
      for (int j = 0; j < rows; j++) {
        row.add('T$i : L$j');
      }
      output.add(row);
    }
    return output;
  }

  /// Simple generator for column title
  List<String> _makeTitleColumn() => List.generate(columns, (i) => stringId.next());

  /// Simple generator for row title
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
        title: Text(widget.fileName),
      ),
      body: StickyHeadersTable(
        columnsLength: titleColumn.length,
        rowsLength: titleRow.length,
        columnsTitleBuilder: (i) => Text(titleColumn[i]),
        rowsTitleBuilder: (i) => Text(titleRow[i]),
        contentCellBuilder: (i, j) =>
            Container(height: 50, width: 50, child: TextField()),
      ),
    );
  }
}
