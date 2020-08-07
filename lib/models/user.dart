import 'package:flutter/material.dart';

class User {
  String id;
  String username;
  String email;

  bool isOnline;

  toMap() {
    Map<String, dynamic> result = {
      'id': this.id,
      'email': this.email,
      'username': this.username,
    };

    return result;
  }

  User.fromMap(map) {
    this.id = map['id'];
    this.email = map['email'];
    this.username = map['username'];
  }

  User({@required this.id, this.username, this.email, this.isOnline});
}
