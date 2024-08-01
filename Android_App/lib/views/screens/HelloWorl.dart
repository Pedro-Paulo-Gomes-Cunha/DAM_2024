
import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:flutter_map/flutter_map.dart';
//import 'package:latlong2/latlong.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


import '../../Values/TextStyles.dart';
class ScreenHelloWorld extends StatefulWidget {
  const ScreenHelloWorld({super.key});

  @override
  State<ScreenHelloWorld> createState() => _ScreenHelloWorld();
}

class _ScreenHelloWorld extends State<ScreenHelloWorld> {
  GoogleMapController? mapController;

  final LatLng _start = LatLng(-8.839987, 13.289437); // Ponto de partida
  final LatLng _end = LatLng(-8.8147, 13.2307); // Ponto de chegada

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Trajetória no Google Maps'),
       ),
       body: GoogleMap(
         onMapCreated: (GoogleMapController controller) {
           mapController = controller;
         },
         initialCameraPosition: CameraPosition(
           target: _start,
           zoom: 12.0,
         ),
         markers: {
           Marker(
             markerId: MarkerId('start'),
             position: _start,
             infoWindow: InfoWindow(title: 'Ponto de Partida'),
           ),
           Marker(
             markerId: MarkerId('end'),
             position: _end,
             infoWindow: InfoWindow(title: 'Ponto de Chegada'),
           ),
         },
         polylines: {
           Polyline(
             polylineId: PolylineId('route'),
             points: [_start, _end],
             color: Colors.blue,
             width: 5,
           ),
         },
       ),
     );
  }
}