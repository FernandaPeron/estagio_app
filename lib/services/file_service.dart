import 'dart:convert' as convert;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:estagio_app/api/api_response.dart';
import 'package:estagio_app/entity/file_entity.dart';
import 'package:http/http.dart' as http;

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
      return ApiResponse.error(msg: "Ocorreu um erro ao realizar a operação.");
    }
  }

  deleteFile(fileId) async {
    var url = 'http://10.0.2.2:8080/files/delete/$fileId';
    try {
      var response = await Dio().delete(url);
      return ApiResponse.ok(result: response);
    } catch (error) {
      return ApiResponse.error(msg: "Ocorreu um erro ao realizar a operação.");
    }
  }

  downloadFile(Archive archive, folder) async {
    final name = archive.name;
    var url = 'http://10.0.2.2:8080/files/download/${archive.id}';
    await Dio().download(url, folder + "/" + name);
  }

  uploadFile(File file, clientId) async {
    var url = 'http://10.0.2.2:8080/files/upload';
      FormData formData = FormData.fromMap({
        "clientId": clientId,
        "file": await MultipartFile.fromFile(file.path)
      });
      try {
        var response = await Dio().post(url, data: formData);
        return ApiResponse.ok(result: response);
      } catch (error) {
        return ApiResponse.error(msg: _handleErrorMessage(error));
      }
  }

  _handleErrorMessage(DioError error) {
    switch(error.response.statusCode) {
      case 404:
        return "Usuário não encontrado.";
        break;
      case 409:
        return "Já existe um arquivo com este nome.";
        break;
      default:
        return "Ocorreu um erro ao realizar a operação.";
    }
  }

}