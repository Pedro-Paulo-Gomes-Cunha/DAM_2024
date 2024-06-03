import 'dart:convert' as convert;
import 'package:bikeshared/env.dart';
import 'dart:convert';
import 'dart:io';
import 'package:bikeshared/models/user.dart';
import 'package:bikeshared/services/shared_preferences_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserService {
  late http.Response resposta;
  Future<int> logar(String email, String password) async {
    await search(email, password);
    if (resposta.statusCode == 200) {

      final UserMap = jsonDecode(resposta.body);
      var User_=User.fromJson(UserMap);
      SharedPreferences sharedPreference = SharedPreferencesManager.sharedPreferences;
      sharedPreference.clear();
      await sharedPreference.setString('Id', User_.id);
      await sharedPreference.setString('name', User_.name);
      await sharedPreference.setString('email', User_.email);
      await sharedPreference.setString('password', User_.password);
      //await sharedPreference.setBool('hasBikeShared', bool.fromEnvironment(hasBikeShared.first.text));
    //  await sharedPreference.setDouble('credit', User_.credit);

      await sharedPreference.setString('Profile', User_.Profile);
    } else {

    }

    return resposta.statusCode;
  }

  search(String email, String password) async {
    try {
      var url = Uri.parse(
          'https://caapp.bsite.net/user/login?email=$email&password=$password');
      var response = await http.get(url, headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      });
      resposta = response;
    } catch (e) {
      throw SocketException(e.toString());
    }
  }

  Future<int> CriarRegisto(String name, String password, String email) async {
    await SaveUser(name, password, email);

    if (resposta.statusCode == 200) {
      late http.Response response_2;
      var url = Uri.parse(
          'https://caapp.bsite.net/user/login?email=$email&password=$password');
        response_2= await http.get(url, headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      });

      final UserMap = jsonDecode(response_2.body);
      var User_=User.fromJson(UserMap);
      SharedPreferences sharedPreference = SharedPreferencesManager.sharedPreferences;
      sharedPreference.clear();
      await sharedPreference.setString('Id', User_.id);
      await sharedPreference.setString('name', User_.name);
      await sharedPreference.setString('email', User_.email);
      await sharedPreference.setString('password', User_.password);
      //await sharedPreference.setBool('hasBikeShared', bool.fromEnvironment(hasBikeShared.first.text));
      //  await sharedPreference.setDouble('credit', User_.credit);

      await sharedPreference.setString('Profile', User_.Profile);}
    return resposta.statusCode;
  }

  SaveUser(String name, String password, String email) async {
    try {
      var url = Uri.parse('https://caapp.bsite.net/user');
      resposta = await http.post(url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
          },
          body: jsonEncode(<String, String>{
            "name": name,
            "password": password,
            "email": email,
            "profile": "user",
            "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "credit": "10",
          }));
    } catch (e) {
      //  throw SocketException(e.toString());
    }
  }
}
