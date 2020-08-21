import 'package:estagio_app/api/api_response.dart';
import 'package:estagio_app/entity/user_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class UserService {

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  login(email, password) async {
    var url = 'http://10.0.2.2:8080/login';
    var body = convert.jsonEncode({
      'email': email,
      'password': password,
    });
    try {
      var response = await http.post(url, body: body, headers: requestHeaders);
      if (response.statusCode != 200) {
        return ApiResponse.error(msg: _handleResponse(response.statusCode));
      }
      var jsonResponse = convert.jsonDecode(response.body);
      var user = new User.fromJson(jsonResponse);
      return ApiResponse.ok(result: user);
    } catch (error) {
      return ApiResponse.error(msg: _handleResponse(error));
    }
  }

  register(user) async {
    var url = 'http://10.0.2.2:8080/client';
    final body = convert.jsonEncode(user.toJson());
    try {
      var response = await http.post(url, body: body, headers: requestHeaders);
      if (response.statusCode != 200) {
        return ApiResponse.error(msg: _handleResponse(response.statusCode));
      }
      var jsonResponse = convert.jsonDecode(response.body);
      var user = new User.fromJson(jsonResponse);
      return ApiResponse.ok(result: user);
    } catch (error) {
      return ApiResponse.error(msg: _handleResponse(error));
    }
  }

  _handleResponse(status) {
    switch(status) {
      case 401:
        return "Senha incorreta.";
        break;
      case 404:
        return "Usuário não encontrado.";
        break;
      default:
        return "Ocorreu um erro ao realizar a operação.";
        break;
    }
  }

}