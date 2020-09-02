import 'package:estagio_app/api/api_response.dart';
import 'package:estagio_app/entity/file_entity.dart';
import 'package:estagio_app/services/file_service.dart';
import 'package:estagio_app/utils/alert.dart';
import 'package:estagio_app/utils/date.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FileItem extends StatefulWidget {
  final Archive file;
  final getFilesFromUser;

  FileItem(this.file, this.getFilesFromUser);

  @override
  _FileItemState createState() => _FileItemState();
}

class _FileItemState extends State<FileItem> {
  bool deleteLoading = false;
  bool downloadLoading = false;
  final DateUtils dateUtils = new DateUtils();
  final FileService fileService = new FileService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.solidFile,
                size: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.file.name),
                  Text(
                    dateUtils.formatDate("d MMM yyyy, hh:mm", widget.file.date),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: <Widget>[
              GestureDetector(
                child: _iconOrLoading(
                    Icon(FontAwesomeIcons.download), downloadLoading),
                onTap: () => _downloadFile(),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                child: _iconOrLoading(
                    Icon(
                      FontAwesomeIcons.trash,
                      color: Colors.red,
                    ),
                    deleteLoading),
                onTap: () => _deleteFile(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _deleteFile() async {
    deleteLoading = true;
    ApiResponse response = await fileService.deleteFile(widget.file.id);
    if (response != null && response.isOk) {
      widget.getFilesFromUser();
      alert(context, "Arquivo excluído com sucesso!");
    } else {
      alert(context, response.msg);
    }
    deleteLoading = false;
  }

  _downloadFile() {
    fileService.downloadFile(widget.file);
  }

  _iconOrLoading(Icon icon, bool loading) {
    return loading
        ? icon
        : CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          );
  }
}
