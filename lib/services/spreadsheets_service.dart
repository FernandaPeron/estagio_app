import 'dart:io';

import 'package:estagio_app/api/api_response.dart';
import 'package:estagio_app/entity/file_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SpreadsheetsService {

  getSpreadsheetsFromUser(String userId) async {
    var url = 'http://10.0.2.2:8080/files/$userId/xlsx';
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

}