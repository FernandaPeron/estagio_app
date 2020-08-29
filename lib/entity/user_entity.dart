import 'dart:developer';

import "package:flutter/material.dart";

class User with ChangeNotifier {
  String id = "";
  String name = "";
  String email = "";
  String password = "";

  User({this.id, this.name, this.email, this.password});

  User.fromJson(Map<String, dynamic> map) {
    this.id = map["userId"];
    this.name = map["userName"];
    this.email = map["email"];
    this.password = map["password"];
  }

  Map<String, dynamic> toJson() =>
    {
      "userId": this.id,
      "userName": this.name,
      "email": this.email,
      "password": this.password,
    };

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
