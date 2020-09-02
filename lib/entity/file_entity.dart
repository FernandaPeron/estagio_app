
class Archive {
  String id = "";
  String name = "";
  String date = "";
  String file = "";

  Archive({this.id, this.name, this.date, this.file});

  Archive.fromJson(Map<String, dynamic> map) {
    this.id = map["archiveId"];
    this.name = map["archiveName"];
    this.date = map["date"];
    this.file = map["file"];
  }

  Map<String, dynamic> toJson() =>
    {
      "archiveId": this.id,
      "archiveName": this.name,
      "date": this.date,
      "file": this.file,
    };

}
