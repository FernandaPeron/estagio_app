import 'dart:io';

import 'package:estagio_app/api/api_response.dart';
import 'package:estagio_app/components/file_item.dart';
import 'package:estagio_app/components/search_bar.dart';
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
  List<Archive> filteredList = [];

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
      child: Column(
        children: <Widget>[
          _searchBar(),
          _listOfFiles(),
        ],
      ),
    );
  }

  Widget _buildArchiveItem(context, int index) {
    return FileItem(filteredList[index], _getFilesFromUser);
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
      setState(() {
        files = response.result;
        filteredList = List.from(files);
        _sortList();
      });
    } else {
      alert(context, response.msg);
    }
    _setShowProgress(false);
  }

  void _sortList() {
    filteredList.sort((a,b) => b.date.compareTo(a.date));
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

  _listOfFiles() {
    return  filteredList.length != 0
        ? ListView.builder(
      shrinkWrap: true,
      physics: new NeverScrollableScrollPhysics(),
      itemBuilder: _buildArchiveItem,
      itemCount: filteredList.length,
    )
        : Expanded(
          child: Center(
      child: Text("Não há arquivos para listar."),
    ),
        );
  }

  _searchBar() {
    return SearchBar(_filterList, "Buscar arquivo");
  }

  _filterList(String term) {
    if (term.isEmpty) {
      setState(() {
        filteredList = List.from(files);
        _sortList();
      });
      return;
    }
    setState(() {
      filteredList = files
          .where((element) => element.name.toLowerCase().contains(term.toLowerCase()))
          .toList();
      _sortList();
    });
  }
}
