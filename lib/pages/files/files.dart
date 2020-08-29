import 'package:estagio_app/entity/file_entity.dart';
import 'package:estagio_app/entity/user_entity.dart';
import 'package:estagio_app/services/file_service.dart';
import 'package:estagio_app/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Files extends StatefulWidget {
  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> {
  List<File> files = [];
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
      body: Container(),
    );
  }

  _getFilesFromUser() async {
    setState(() {
      _showProgress = true;
    });
    final response = await service.getFilesFromUser(_user.id);
    if (response != null && response.isOk) {
      files = response.result;
    } else {
      alert(context, response.msg);
    }
    setState(() {
      _showProgress = false;
    });
  }
}
