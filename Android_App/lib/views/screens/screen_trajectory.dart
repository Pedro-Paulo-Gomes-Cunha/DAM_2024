
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
  final LatLng sourceLocation;// = LatLng(-8.8905235, 13.2274002);
  final LatLng destination; //= LatLng(-8.8649484, 13.2939577);
  const ScreenTrajectory({super.key, required this.sourceLocation, required this.destination});

  @override
  State<ScreenTrajectory> createState() => _ScreenTrajectoryState();
}


class _ScreenTrajectoryState extends State<ScreenTrajectory> {

  //variavel que vai controlar o mapa
  late GoogleMapController _mapsController;
  String googleKey = "AIzaSyBwXK0RP9bdcdz63bwo6y2MBO6FX6J0EcQ";//"AIzaSyDFbFxPiczX2GO_iVLeTbzoBGSsw6ma938";//
  
  double lat = 0.0;
  
  double long = 0.0;
  String error = '';

  late LatLng sourceLocation2;// = LatLng(-8.8905235, 13.2274002);
  late LatLng destination2;// = LatLng(-8.8649484, 13.2939577);

  //variavel para marcacao de estacoes
  Set<Marker> markers = <Marker>{};

  //variaveis para marcação de coordenadas
  final Set<Polyline> _polylines = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    double earthRadius = 6371; // em quilômetros

    double dLat = degreesToRadians(lat2 - lat1);
    double dLon = degreesToRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(degreesToRadians(lat1)) * cos(degreesToRadians(lat2)) *
        sin(dLon / 2) * sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;
    return distance;
  }

  void setPolylines() async{
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleKey, 
      PointLatLng(widget.sourceLocation.latitude, widget.sourceLocation.longitude), 
      PointLatLng(widget.destination.latitude, widget.destination.longitude));
      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.add(
            LatLng(point.latitude, point.longitude)
          );
        }

        setState(() {
          _polylines.add(
            Polyline(
            width: 3,
            polylineId: const PolylineId('polyLine'),
            color: const Color.fromARGB(255, 9, 67, 82),
            points: polylineCoordinates)
          );
        });
        
      
      }
  }

  Future<Position>_positionCurrent() async{
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

  void getPosition() async{
    try {
      Position position = await _positionCurrent();
      lat = position.latitude;
      long = position.longitude;
      
      _mapsController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
    } catch (e) {
      error = e.toString();
    }
    
  }

  void loadingStation () {
    final stations = StationRepository.list;
    for (var station in stations) { 
      markers.add(
        Marker(
          markerId: MarkerId(station.name),
          position: LatLng(station.lat,station.long),
          onTap: ()=>{
            showModalBottomSheet(
              context: context, builder: (context)=> modalSolicitation(context, station),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              anchorPoint: const Offset(4, 5),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            )
          },
        )
      );
    }
  }

  @override
  void initState(){
    
    super.initState();

    polylinePoints = PolylinePoints();
    sourceLocation2 = widget.sourceLocation;
    destination2 = widget.destination;


    getPosition();
    loadingStation();

    calculateDistance(widget.sourceLocation.latitude, widget.sourceLocation.longitude,
     widget.destination.latitude, widget.destination.longitude);
  }

  @override
  Widget build(BuildContext context) {
    

    return 
    Scaffold(
      //key: appKey,
      resizeToAvoidBottomInset: false,
      //backgroundColor: const Color(0xff13a962),
      appBar: buildAppBar(),
      body: /*ChangeNotifierProvider<StationController>(
        
        create: (context)=>StationController(),*/
        Builder(builder: (context){
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: /*sourceLocation*/LatLng(lat, long),
              zoom: 18,
            ),
            zoomControlsEnabled: true,
            mapType: MapType.terrain,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            //onMapCreated: local.onMapCreated,
            markers: markers,
            onMapCreated: (GoogleMapController gController) async{
              _mapsController = gController;
              getPosition();
              loadingStation();
              setPolylines();
            },
            polylines: _polylines,
          );
          
        }),
      
    );
  }

  
  AppBar buildAppBar(){
    return AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => const ScreenSolicitations(),
            ));
          },
        ),
        title: const Text("Trajectória"),
        
        foregroundColor: Colors.white,//Colors.black,
        backgroundColor: const Color.fromARGB(255, 0, 14, 27),
      );
  }

  
  Widget modalSolicitation(BuildContext context, Station station){
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
  }

}
