
class Event {
  String id = "";
  String eventName = "";
  String date = "";
  String time = "";

  Event({this.id, this.eventName, this.date, this.time});

  Event.fromJson(Map<String, dynamic> map) {
    this.id = map["eventId"];
    this.eventName = map["eventName"];
    this.date = map["date"];
    this.time = map["time"];
  }

  Map<String, dynamic> toJson() =>
      {
        "eventId": this.id,
        "eventName": this.eventName,
        "date": this.date,
        "time": this.time,
      };

}
