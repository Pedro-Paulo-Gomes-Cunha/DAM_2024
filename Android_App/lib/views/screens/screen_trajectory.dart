
import 'dart:math';

import 'package:bikeshared/models/station.dart';
import 'package:bikeshared/repositories/station_repository.dart';
import 'package:bikeshared/views/screens/screen_login.dart';
import 'package:bikeshared/views/screens/screen_solicitations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ScreenTrajectory extends StatefulWidget {
  final Station start_;// = LatLng(-8.8905235, 13.2274002);
  final Station end_; //= LatLng(-8.8649484, 13.2939577);
  const ScreenTrajectory({super.key, required this.start_, required this.end_});

  @override
  State<ScreenTrajectory> createState() => _ScreenTrajectoryState();
}


class _ScreenTrajectoryState extends State<ScreenTrajectory> {
  GoogleMapController? mapController;

  // final LatLng _start = LatLng(-8.839987, 13.289437); // Ponto de partida
  // final LatLng _end = LatLng(-8.8147, 13.2307); // Ponto de chegada


  void setPolylines() async {
    // _start = LatLng(widget.sourceLocation.latitude, widget.sourceLocation.longitude); // Ponto de partida
    // _end = LatLng(widget.destination.latitude, widget.destination.longitude); //
  }




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
          target: LatLng(widget.start_.lat, widget.start_.long),
          zoom: 12.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId(widget.start_.stationId),
            position: LatLng(widget.start_.lat,widget.start_.long),
            infoWindow: InfoWindow(title: widget.start_.name +' (Partida)'),
          ),
          Marker(
            markerId: MarkerId(widget.end_.stationId),
            position: LatLng(widget.end_.lat, widget.end_.long),
            infoWindow: InfoWindow(title: widget.end_.name+' (Chegada)'),
          ),
        },
        polylines: {
          Polyline(
            polylineId: PolylineId('route'),
            points: [LatLng(widget.start_.lat,widget.start_.long), LatLng(widget.end_.lat, widget.end_.long)],
            color: Colors.blue,
            width: 5,
          ),
        },
      ),
    );
  }


  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => const ScreenSolicitations(),
          ));
        },
      ),
      title: const Text("Trajectória"),

      foregroundColor: Colors.white,
      //Colors.black,
      backgroundColor: const Color.fromARGB(255, 0, 14, 27),
    );
  }
}
  
  /*Widget modalSolicitation(BuildContext context, Station station){
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.20,
      margin: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      child: Column(
        children: [
          
          const Text('Estação', style: TextStyle(color: Color.fromARGB(255, 19, 19, 19), fontWeight: FontWeight.bold, fontSize: 20),),
          const SizedBox(height: 20,),

          SizedBox(
            width: size.width,
            child: Text(
              station.address,
              style: const TextStyle(
                fontSize: 17,
                color: Color.fromARGB(221, 163, 163, 163)
              ),
              textAlign: TextAlign.left,
            )
          ),
          const SizedBox(height: 3,),         
          SizedBox(
            width: size.width,
            child: Row(
              children: [
                const Icon(
                  Icons.location_pin,
                  color: Color.fromARGB(255, 192, 14, 1),
                ),
                Text(
                  station.name,
                  style: const TextStyle(fontSize: 15),
                  textAlign: TextAlign.left,
                )
              ],
            ) 
          ),
          const SizedBox(height: 25,),
        ],
      ),
    );
  }

  Widget confirmLogout(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.15,
      margin: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      child: Column(
        children: [
          const Text('Confirmar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(                  
                  padding: MaterialStateProperty.all(const EdgeInsets.only(left:30, right: 30, top: 5, bottom: 5)),
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,  
                  children: [
                    Icon(Icons.logout_outlined,color: Colors.redAccent,),
                    Text(
                      "Sim", 
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                    )
                  ],
                ),
                onPressed: () async{
                  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
                  await sharedPreference.clear();
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => const ScreenLogin(),
                  ));
                },

              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.only(left:30, right: 30, top: 5, bottom: 5)),
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,  
                  children: [
                    Icon(Icons.cancel, color: Colors.blueAccent,),
                    Text(
                      "Não", 
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                    )
                  ],
                ),
                onPressed: () async{
                  Navigator.of(context).pop();
                },

              ),
              
              
            ],
          )
        ],
      ),
    );
  }*/


