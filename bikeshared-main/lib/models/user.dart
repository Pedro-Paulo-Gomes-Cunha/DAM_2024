//import 'dart:convert';

class User{
  late String id;
  late String name;
  late String email;
  late String password;
  late int credit;
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
        credit = json['credit'] as int,
        Profile = json['profile'] as String;
}