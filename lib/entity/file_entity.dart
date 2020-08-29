
class File {
  String id = "";
  String name = "";
  String user = "";
  String file = "";

  File({this.id, this.name, this.user, this.file});

  File.fromJson(Map<String, dynamic> map) {
    this.id = map["archiveId"];
    this.name = map["archiveName"];
    this.user = map["client"];
    this.file = map["file"];
  }

  Map<String, dynamic> toJson() =>
    {
      "archiveId": this.id,
      "archiveName": this.name,
      "client": this.user,
      "file": this.file,
    };

}
