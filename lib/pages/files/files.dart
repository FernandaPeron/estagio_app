import 'dart:io';
import 'package:estagio_app/api/api_response.dart';
import 'package:estagio_app/components/file_item.dart';
import 'package:estagio_app/entity/file_entity.dart';
import 'package:estagio_app/entity/user_entity.dart';
import 'package:estagio_app/services/file_service.dart';
import 'package:estagio_app/utils/alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Files extends StatefulWidget {
  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> {
  List<Archive> files = [];
  FileService service = new FileService();
  User _user;
  bool _showProgress = false;

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _getFilesFromUser());
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
        title: Text("Arquivos"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => _uploadArchive(),
      ),
      body: _showProgress ? _loading() : _body(),
    );
  }

  _body() {
    return Container(
        child: files.length != 0
            ? ListView.builder(
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                itemBuilder: _buildArchiveItem,
                itemCount: files.length,
              )
            : Center(
                child: Text("Não há arquivos para listar."),
              ));
  }

  Widget _buildArchiveItem(context, int index) {
    return FileItem(files[index], _getFilesFromUser);
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  _getFilesFromUser() async {
    _setShowProgress(true);
    final response = await service.getFilesFromUser(_user.id);
    if (response != null && response.isOk) {
      files = response.result;
    } else {
      alert(context, response.msg);
    }
    _setShowProgress(false);
  }

  _setShowProgress(bool state) {
    setState(() {
      _showProgress = state;
    });
  }

  _uploadArchive() async {
    File file = await FilePicker.getFile();
    var user = Provider.of<User>(context, listen: false);
    _setShowProgress(true);
    ApiResponse response = await service.uploadFile(file, user.id);
    if (response != null && response.isOk) {
      _getFilesFromUser();
    } else {
      alert(context, response.msg);
    }
    _setShowProgress(false);
  }
}
