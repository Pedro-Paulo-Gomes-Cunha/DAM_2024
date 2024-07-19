
import 'dart:convert';

import 'package:bikeshared/env.dart';
import 'package:bikeshared/models/solicitation.dart';
import 'package:bikeshared/models/station.dart';
import 'package:bikeshared/repositories/solicitation_repository.dart';
import 'package:bikeshared/repositories/station_repository.dart';
import 'package:bikeshared/services/shared_preferences_manager.dart';
import 'package:bikeshared/views/components/station_details.dart';
import 'package:bikeshared/views/screens/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class StationController extends ChangeNotifier{
  static double lat = 0.0;
  static double long = 0.0;
  static bool globalHasBikeShared = false;
  String error = '';
  //Marcadores de estacoes
  static Set<Marker> markers = <Marker>{};
  //variavel que vai controlar o mapa
  late GoogleMapController _mapsController;
String googleKey = "AIzaSyAyutQcGJEDgu1E8uLYIvXxsYjbfIeLdDw";
  
  final Set<Polyline> _polylines = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  /*StationController(){
    getPosition();
  }*/

  get mapsController=> _mapsController;

  onMapCreated(GoogleMapController gController) async{
    _mapsController = gController;
    getPosition();
    loadingStation();
  }

  static loadingStation() {
    final stations = StationRepository.list1;
    stations.forEach((station) async { 
      markers.add(
        Marker(
          markerId: MarkerId(station.name),
          position: LatLng(station.lat,station.long),
          onTap: ()=>{
            showModalBottomSheet(
              context: appKey.currentState!.context, builder: (context)=> StationDetails(station: station),
              backgroundColor: const Color.fromARGB(255, 2, 130, 250),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              anchorPoint: const Offset(4, 5),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
            )
          },
        )
      );
    });
  }

  setPolylines() async{
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleKey, 
      const PointLatLng(-8.8905235, 13.2274002), 
      const PointLatLng(-8.8649484, 13.2939577));

      if (result.points.isEmpty) {
        result.points.forEach((point) {
          polylineCoordinates.add(
            LatLng(point.latitude, point.longitude)
          );
        });

        _polylines.add(Polyline(
          width: 10,
          polylineId: const PolylineId('polyLine'),
          color: const Color(0xFF08A5CB),
          points: polylineCoordinates));
      }
  }

  getPosition() async{
    try {
      Position position = await _positionCurrent();
      lat = position.latitude;
      long = position.longitude;
      
      _mapsController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
    } catch (e) {
      error = e.toString();
    }
    notifyListeners();
  }

  static getLocation() async{
    try {
      Position position = await _positionCurrent();
      lat = position.latitude;
      long = position.longitude;
    } catch (e) {
      lat = 0;
      long = 0;
    }
  }

  static Future<Position>_positionCurrent() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Serviço de localização está desativado');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Acesso a localização com permissão negado');     
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Acesso a localização com permissão negado para sempre, Você precisa autorizar o acesso.');     
    }
    return await Geolocator.getCurrentPosition();
  }

  static Future<bool> testPing() async{
        return true;
  }

  static Future<bool> listStations() async{
    //SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    try {

      String stringconection="${Env.url}/stations";
      var url= Uri.parse(stringconection);

      http.Response response = await http.get(url, headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      });
      if (response.statusCode == 200) {
        final Map = jsonDecode(response.body);
        StationRepository.list =[];
        for (var item in Map) { //Adicionar as estações no repositório local
          StationRepository.list.add(Station.fromJson(item));
        }

        return true;
      }else{
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<List<Station>> listStations2() async{
    //SharedPreferences sharedPreference = await SharedPreferences.getInstance();

      String stringconection="${Env.url}/stations";
      var url= Uri.parse(stringconection);
      List<Station> list =[];

      http.Response response = await http.get(url, headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      });
      if (response.statusCode == 200) {
        final Map = jsonDecode(response.body);

        for (var item in Map) { //Adicionar as estações no repositório local
          list.add(Station.fromJson(item));
        }}
            StationRepository.list=list;
      return list;
  }
}