import "dart:convert" as convert;

import "package:collection/collection.dart";
import "package:dio/dio.dart";
import "package:estagio_app/api/api_response.dart";
import "package:estagio_app/entity/event_entity.dart";

class EventService {

  getAllFromUser(userId) async {
    var url = "http://10.0.2.2:8080/event?clientId=$userId";
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
      var mapped = response.result.map((item) => new Event.fromJson(item)).toList();
      var grouped = groupBy(mapped, (obj) {
        return obj.date;
      });
      var result = Map<DateTime, List<dynamic>>.from(grouped);
      return ApiResponse.ok(result: result);
    }
    return ApiResponse.error(msg: "Ocorreu um erro ao realizar a operação.");
  }

  insertEvent(userId, Event event) async {
    var url = "http://10.0.2.2:8080/event?clientId=$userId";
    var data = convert.jsonEncode(event.toJson());
    try {
      var response = await Dio().post(url, data: data);
      return ApiResponse.ok(result: response.data);
    } catch (error) {
      return ApiResponse.error(msg: "Ocorreu um erro ao realizar a operação.");
    }
  }

  completeResetEvent(Event event) async {
    var eventId = event.id;
    var action = event.completed ? "reset" : "complete";
    var url = "http://10.0.2.2:8080/event/$eventId/$action";
    try {
      var response = await Dio().put(url);
      return ApiResponse.ok(result: response.data);
    } catch (error) {
      return ApiResponse.error(msg: "Ocorreu um erro ao realizar a operação.");
    }
  }

  deleteEvent(eventId) async {
    var url = "http://10.0.2.2:8080/event/$eventId";
    try {
      var response = await Dio().delete(url);
      return ApiResponse.ok(result: response.data);
    } catch (error) {
      return ApiResponse.error(msg: "Ocorreu um erro ao realizar a operação.");
    }
  }

}