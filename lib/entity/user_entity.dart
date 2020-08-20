import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String id = "";
  String name = "";
  String email = "";
  String password = "";

  User({this.id, this.name, this.email, this.password});

  User.fromJson(Map<String, dynamic> map) {
    this.id = map["id"];
    this.name = map["nome"];
    this.email = map["email"];
    this.password = map["password"];
  }

  updateUser([User user]) {
    if (user != null) {
      this.id = user.id;
      this.name = user.name;
      this.email = user.email;
      this.password = user.password;
      notifyListeners();
    } else {
      notifyListeners();
    }
  }
}