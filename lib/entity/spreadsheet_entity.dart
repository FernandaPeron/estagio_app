
class Spreadsheet {
  String id = "";
  String name = "";
  String date = "";
  String spreadsheet = "";

  Spreadsheet({this.id, this.name, this.date, this.spreadsheet});

  Spreadsheet.fromJson(Map<String, dynamic> map) {
    this.id = map["id"];
    this.name = map["name"];
    this.date = map["date"];
    this.spreadsheet = map["spreadsheet"];
  }

  Map<String, dynamic> toJson() =>
    {
      "id": this.id,
      "name": this.name,
      "date": this.date,
      "spreadsheet": this.spreadsheet,
    };

}
