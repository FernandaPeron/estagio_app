import 'dart:io';

import 'package:directory_picker/directory_picker.dart';
import 'package:estagio_app/api/api_response.dart';
import 'package:estagio_app/entity/file_entity.dart';
import 'package:estagio_app/entity/spreadsheet_entity.dart';
import 'package:estagio_app/services/file_service.dart';
import 'package:estagio_app/services/spreadsheets_service.dart';
import 'package:estagio_app/utils/alert.dart';
import 'package:estagio_app/utils/confirm_dialog.dart';
import 'package:estagio_app/utils/date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';

class SpreadsheetItem extends StatefulWidget {
  final Spreadsheet file;
  final getSpreadsheetsFromUser;

  SpreadsheetItem(this.file, this.getSpreadsheetsFromUser);

  @override
  _SpreadsheetItemState createState() => _SpreadsheetItemState();
}

class _SpreadsheetItemState extends State<SpreadsheetItem> {
  bool deleteLoading = false;
  bool downloadLoading = false;
  final DateUtils dateUtils = new DateUtils();
  final SpreadsheetsService service = new SpreadsheetsService();
  Directory selectedDirectory;

  Future<void> _pickDirectory(BuildContext context) async {
    Directory directory = selectedDirectory;
    if (directory == null) {
      directory = await getExternalStorageDirectory();
    }

    Directory newDirectory = await DirectoryPicker.pick(
        allowFolderCreation: true,
        context: context,
        rootDirectory: directory,
        backgroundColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))));

    setState(() {
      selectedDirectory = newDirectory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.solidFile,
                  size: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.file.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(height: 2),
                      ),
                      Text(
                        dateUtils.formatDate(
                            "d MMM yyyy, HH:mm", widget.file.date),
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  child: _iconOrLoading(
                      Icon(
                        FontAwesomeIcons.trash,
                        color: Colors.red,
                      ),
                      deleteLoading),
                  onTap: () => _confirmDelete(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmDialog(_deleteFile, "Deseja apagar a planilha?");
      });
  }

  _deleteFile() async {
    deleteLoading = true;
    ApiResponse response = await service.deleteFile(widget.file.id);
    if (response != null && response.isOk) {
      widget.getSpreadsheetsFromUser();
      alert(context, "Planilha excluída com sucesso!");
    } else {
      alert(context, response.msg);
    }
    deleteLoading = false;
  }

  _iconOrLoading(Icon icon, bool loading) {
    return loading
        ? SizedBox(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            height: 20,
            width: 20,
          )
        : icon;
  }
}
