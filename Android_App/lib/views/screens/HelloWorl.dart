
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

  GoogleMapController? _controller;
  LatLng? _myPosition;
  MapType _mapType = MapType.normal;
  String? _mapStyle;
  String meuSaldo = '';
  String footerMessage = '';
  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    if (_mapStyle != null) {
      _controller!.setMapStyle(_mapStyle!);
    }
  }

  void _getCurrentLocation() async {
    if (true) {
      setState(() {
        footerMessage = "Sem bicicleta";
      });
    } else {
      setState(() {
        footerMessage = "Com bicicleta";
      });
    }
    Position position = await _determinePosition();
    setState(() {
      _myPosition = LatLng(position.latitude, position.longitude);
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         centerTitle: true,
         title: const Text('Mapa'),
         backgroundColor: Colors.blueAccent,
       ),
       body: _myPosition == null
           ? const Center(child: CircularProgressIndicator())
           : GoogleMap(
         onMapCreated: _onMapCreated,
         initialCameraPosition: CameraPosition(
           target: _myPosition!,
           zoom: 15,
         ),
         mapType: _mapType,
         markers: _myPosition == null
             ? Set<Marker>.identity()
             : {
           Marker(
             markerId: MarkerId('MyPosition'),
             position: _myPosition!,
           ),
         },
       ),
       floatingActionButton: FloatingActionButton(
         onPressed: () {
           setState(() {
             _mapType =
             _mapType == MapType.normal ? MapType.satellite : MapType.normal;
           });
         },
         child: Icon(Icons.layers),
         backgroundColor: Colors.blue,
       ),
       floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
     );
  }
}