import 'package:estagio_app/utils/date.dart';
import 'package:flutter/material.dart';

var dateUtils = new DateUtils();

class Alarm {
  String id = "";
  String description = "";
  bool enabled = true;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  Alarm({this.id, this.description, this.date, this.time});

  Alarm.fromJson(Map<String, dynamic> map) {
    this.id = map["eventId"];
    this.description = map["description"];
    this.enabled = map["enabled"];
    this.date = DateTime.parse(map["date"]);
    this.time = dateUtils.stringToTimeOfDay(map["time"]);
  }

  Map<String, dynamic> toJson() =>
      {
        "eventId": this.id,
        "description": this.description,
        "enabled": this.enabled,
        "date": this.date.toIso8601String(),
        "time": dateUtils.timeOfDayToString(this.time),
      };

}
