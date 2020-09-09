import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:estagio_app/api/api_response.dart';
import "package:collection/collection.dart";
import 'package:estagio_app/entity/event_entity.dart';
import 'dart:convert' as convert;

class EventService {

  getAllFromUser(userId) async {
    var url = 'http://10.0.2.2:8080/event?clientId=$userId';
    try {
      var response = await Dio().get(url);
      return ApiResponse.ok(result: response.data);
    } catch (error) {
      return ApiResponse.error(msg: "Ocorreu um erro ao realizar a operação.");
    }
  }

  getAllMappedFromUser(userId) async {
    ApiResponse response = await getAllFromUser(userId);
    if (response.isOk) {
      var grouped = groupBy(response.result, (obj) => obj['date']);
      return ApiResponse.ok(result: grouped);
    }
    return ApiResponse.error(msg: "Ocorreu um erro ao realizar a operação.");
  }

  insertEvent(userId, Event event) async {
    var url = 'http://10.0.2.2:8080/event?clientId=$userId';
    var data = convert.jsonEncode(event.toJson());
    try {
      var response = await Dio().post(url, data: data);
      return ApiResponse.ok(result: response.data);
    } catch (error) {
      return ApiResponse.error(msg: "Ocorreu um erro ao realizar a operação.");
    }
  }

}