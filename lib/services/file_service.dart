import 'dart:convert' as convert;
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:estagio_app/api/api_response.dart';
import 'package:estagio_app/entity/file_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileService {

  getFilesFromUser(userId) async {
    var url = 'http://10.0.2.2:8080/files/$userId';
    try {
      var response = await http.get(url);
      if (response.statusCode != 200) {
        return ApiResponse.error(msg: "Ocorreu um erro ao realizar a operação.");
      }
      List jsonResponse = convert.jsonDecode(response.body);
      var userFiles = jsonResponse.map((element) { return Archive.fromJson(element); }).toList();
      return ApiResponse.ok(result: userFiles);
    } catch (error) {
      print(error);
      return ApiResponse.error(msg: "Ocorreu um erro ao realizar a operação.");
    }
  }

  deleteFile(fileId) async {
    var url = 'http://10.0.2.2:8080/files/delete/$fileId';
    try {
      var response = await http.delete(url);
      if (response.statusCode != 200) {
        return ApiResponse.error(msg: "Ocorreu um erro ao realizar a operação.");
      }
      return ApiResponse.ok();
    } catch (error) {
      print(error);
      return ApiResponse.error(msg: "Ocorreu um erro ao realizar a operação.");
    }
  }

  downloadFile(Archive archive) async {
    /* final path = (await getApplicationDocumentsDirectory()).path;
    final name = archive.name;
    File file = new File('$path/$name');
    await file.writeAsBytes(convert.utf8.encode(archive.file)); */
  }

  uploadFile(File file, clientId) async {
    var url = 'http://10.0.2.2:8080/files/upload';
    var body = {
      "file": file.readAsBytesSync(),
      "clientId": clientId,
    };
    try {
      // upload
    } catch (error) {
      return ApiResponse.error(msg: "Ocorreu um erro ao realizar a operação.");
    }
  }

}