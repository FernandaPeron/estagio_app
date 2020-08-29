import 'dart:convert' as convert;
import 'dart:developer';

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
      debugger();
      var jsonResponse = convert.jsonDecode(response.body);
      var user = new File.fromJson(jsonResponse);
      return ApiResponse.ok(result: user);
    } catch (error) {
      return ApiResponse.error(msg: "Ocorreu um erro ao realizar a operação.");
    }
  }

}