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


  static Future<List<Solicitation>> SolicitionListbyUser(String userid) async{
    List<Solicitation> list =[];

    String stringconection="${Env.url}/solicitations/byuserid?id=$userid";
    var url= Uri.parse(stringconection);

    var response = await http.get(url, headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
    if (response.statusCode == 200) {
      final Map = jsonDecode(response.body);

      for (var item in Map) {
        list.add(Solicitation.fromJson(item));
      }}

    SolicitationRepository.list=list;
    return list;
  }


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
          body: jsonEncode(<String, dynamic>{
            "id": "00000000-0000-0000-0000-000000000000",
            "station" :stationId,
            "address": data.address,
            "latitutde": data.lat.toString(),
            "longitude":data.long.toString(),
            "hasBikeShared" :true,
            "stationReturn":"00000000-0000-0000-0000-000000000000",
            "userId":userid,
            "source":"",
            "destiny":"",
          }));

      final body = response.body;
      final statusCode = response.statusCode;
      //print(body.toString());
      if (statusCode == 200) {
        await SharedPreferencesManager.sharedPreferences.setString('stationSelected',stationId);
        await SharedPreferencesManager.sharedPreferences.setBool('hasBikeShared',true);
        await SharedPreferencesManager.sharedPreferences.setDouble('credit', TrocarPontos(false));
        globalHasBikeShared = true;

        var result = await search(userid);
        if(result==null || result.id==""){
          Station data = StationRepository.list.where((station) =>
              station.stationId.contains(stationId)).first;
          SolicitationRepository.list.add(result);
        }
        return statusCode;}else{ return statusCode;}

    } catch (e) {
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
          body: jsonEncode(<String, dynamic>{
            "id": result.id,
            "station" :result.station,
            "address":result.address,
            "latitutde": result.lat.toString(),
            "longitude":result.long.toString(),
            "hasBikeShared" :false,
            "stationReturn":stationId,
            "userId":userid,
            "source":"",
            "destiny":"",
          }));

      if(response.statusCode == 200){

        final body = response.body;
        SolicitationRepository.list.last.stationReturn = stationId;
        await SharedPreferencesManager.sharedPreferences.setString('stationSelected',"");
        await SharedPreferencesManager.sharedPreferences.setBool('hasBikeShared',false);
        await SharedPreferencesManager.sharedPreferences.setDouble('credit', TrocarPontos(true));
        globalHasBikeShared = false;
        return true;
      }else {
        return false;
      }
    }catch (e){
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
      if(Solicitation_!=null){
        globalHasBikeShared = Solicitation_.hasBikeShared;
      }else{
        globalHasBikeShared =false;
      }
    } catch (e) {
      globalHasBikeShared =false;
      throw SocketException(e.toString());
    }
    return Solicitation_;
  }

  static double TrocarPontos(bool bonus) {
    double? value =SharedPreferencesManager.sharedPreferences.getDouble("credit");
    SharedPreferencesManager.sharedPreferences.remove("credit");
    if(bonus){
      value=(value! + 0.5)!;
    }else{
      value=(value! - 1)!;
    }
    return value;
  }

  static Future<bool> HasActiveBike(String userId) async {
     await search(userId);
    return globalHasBikeShared;
  }
}