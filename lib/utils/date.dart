import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtils {

  formatDate(format, date) {
    return new DateFormat(format, 'pt_BR').format(DateTime.parse(date));
  }

  timeOfDayToDate(TimeOfDay time) {
    var tempDate = DateTime.now();
    var datetime = DateTime(tempDate.year, tempDate.month,
        tempDate.day, time.hour, time.minute);
    return datetime;
  }

  timeOfDayToString(TimeOfDay time) {
    var tempDate = DateTime.now();
    var datetime = DateTime(tempDate.year, tempDate.month,
        tempDate.day, time.hour, time.minute);
    return formatDate("HH:mm", datetime.toString());
  }

  stringToTimeOfDay(String map) {
    var hour = map.split(":")[0];
    var minute = map.split(":")[1];
    return TimeOfDay(hour: int.parse(hour), minute: int.parse(minute));
  }

}