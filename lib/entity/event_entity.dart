import 'package:estagio_app/utils/date.dart';
import 'package:flutter/material.dart';

var dateUtils = new DateUtils();

class Event {
  String id = "";
  String eventName = "";
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  Event({this.id, this.eventName, this.date, this.time});

  Event.fromJson(Map<String, dynamic> map) {
    this.id = map["eventId"];
    this.eventName = map["eventName"];
    this.date = DateTime.parse(map["date"]);
    this.time = dateUtils.stringToTimeOfDay(map["time"]);
  }

  Map<String, dynamic> toJson() =>
    {
      "eventId": this.id,
      "eventName": this.eventName,
      "date": this.date.toIso8601String(),
      "time": dateUtils.timeOfDayToString(this.time),
    };

}
