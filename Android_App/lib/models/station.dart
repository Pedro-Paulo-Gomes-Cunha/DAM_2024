import '../Helpers/Parse.dart';
class Station{
  String stationId;
  String name;
  String address;
  double lat;
  double long;
  int capacity;
  int freeDocks;
  int totalGets;
  int totalReturns;
  int availableBikeShared;

  Station({
    required this.stationId,
    required this.name,
    required this.address,
    required this.lat,
    required this.long,
    required this.capacity,
    required this.freeDocks,
    required this.totalGets,
    required this.totalReturns,
    required this.availableBikeShared,
  });

  Station.fromJson(Map<String, dynamic> json)
      : stationId= json['id'] as String,
        name = json['name'] as String,
        address = json['address'] as String,
        lat = Helping.checkDouble(json['latitutde']),// as double,
        long =Helping.checkDouble(json['longitude']),// as double, //Helping.checkDouble(json['credit']),
        capacity = json['capacity'] as int,
        freeDocks = json['freeDocks'] as int,
        totalGets= json['totalGets'] as int,
        totalReturns = json['totalReturns'] as int,
        availableBikeShared = json['availableBikeShared'] as int;

}