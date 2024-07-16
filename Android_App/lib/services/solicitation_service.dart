import 'dart:convert' as convert;
import 'package:bikeshared/env.dart';
import 'dart:convert';
import 'dart:io';
import 'package:bikeshared/models/user.dart';
import 'package:bikeshared/models/solicitation.dart';

import 'package:bikeshared/services/shared_preferences_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/station.dart';
import '../repositories/solicitation_repository.dart';
import '../repositories/station_repository.dart';

class SolicitationService {
  late http.Response resposta;
  static double lat = 0.0;
  static double long = 0.0;
  static bool globalHasBikeShared = false;
  String error = '';


  static Future<int> solicitation(stationId,userid) async{
    //SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    try {
      //final url = Uri.parse(Env.url);

      Station data = StationRepository.list.where((station) =>
          station.stationId.contains(stationId)).first;

      String stringconection="${Env.url}/solicitations";
      var url= Uri.parse(stringconection);

      http.Response response = await http.post(url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
          },
          body: jsonEncode(<String, String>{
            "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "station" :stationId,
            "address": data.address,
            "latitutde": data.lat.toString(),
            "longitude":data.long.toString(),
            "hasBikeShared" :"true",
            "stationReturn":"3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "userId":userid,
          }));

      final body = response.body;
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        print("ok");
        await SharedPreferencesManager.sharedPreferences.setString('stationSelected',stationId);
        await SharedPreferencesManager.sharedPreferences.setBool('hasBikeShared',true);
        globalHasBikeShared = true;

        var result = await search(userid);
        if(result==null || result.id==""){
          Station data = StationRepository.list.where((station) =>
              station.stationId.contains(stationId)).first;
          SolicitationRepository.list.add(result);
        }
        TrocarPontos(false);
        return statusCode;}else{ return statusCode;}

    } catch (e) {
      print("Exception");
      return 500;
    }
  }

  static Future<bool> returnedBike(stationId,userid)async{
    try {
      var result = await search(userid);
      if(result==null || result.id=="") return false;

      String stringconection="${Env.url}/solicitations";
      var url= Uri.parse(stringconection);

      http.Response response = await http.put(url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
          },
          body: jsonEncode(<String, String>{
            "id": result.id,
            "station" :result.station,
            "address":result.address,
            "latitutde": result.lat.toString(),
            "longitude":result.long.toString(),
            "hasBikeShared" :"false",
            "stationReturn":stationId,
            "userId":userid,
          }));

      if(response.statusCode == 200){
        print("ok");
        final body = response.body;
        SolicitationRepository.list.last.stationReturn = stationId;
        await SharedPreferencesManager.sharedPreferences.setString('stationSelected',"");
        await SharedPreferencesManager.sharedPreferences.setBool('hasBikeShared',false);
        globalHasBikeShared = false;
        TrocarPontos(true);
        return true;
      }else {
        print("error");
        return false;
      }
    }catch (e){
      print("exception");
      return false;
    }
  }

  static Future<Solicitation> search(String userid) async {
    Solicitation Solicitation_;
    try {
      String stringconection="${Env.url}/solicitations/last/byuserid?id=$userid";
      var url= Uri.parse(stringconection);

      var response = await http.get(url, headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      });
      final SlMap = jsonDecode(response.body);
       Solicitation_=Solicitation.fromJson(SlMap); //
    } catch (e) {
      throw SocketException(e.toString());
    }
    return Solicitation_;
  }

  static Future<void> TrocarPontos(bool bonus) async {
    double? value = SharedPreferencesManager.sharedPreferences.getDouble("credit");
    if(bonus){
      value=(value! + 0.5)!;
    }else{
      value=(value! - 1)!;
    }
    SharedPreferences sharedPreference = SharedPreferencesManager.sharedPreferences;
    await sharedPreference.setDouble('credit', value);
  }

}