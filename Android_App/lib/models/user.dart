//import 'dart:convert';

import '../Helpers/Parse.dart';

class User{
  late String id;
  late String name;
  late String email;
  late String password;
  late double credit;
  late String Profile;

  User(
    this.id,
    this.name,
    this.email,
    this.password,
    this.credit,
    this.Profile
  );

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        email = json['email'] as String,
        password = json['password'] as String,
        credit =Helping.checkDouble(json['credit']),
        Profile = json['profile'] as String;
}