import '../Helpers/Parse.dart';
class Solicitation{
  String id;
  String station;
  String address;
  double lat;
  double long;
  bool hasBikeShared;
  String stationReturn;
  String userid;
  String source;
  String destiny;

  Solicitation({
    required this.id,
    required this.station,
    required this.address,
    required this.lat,
    required this.long,
    required this.hasBikeShared,
    required this.stationReturn,
    required this.userid,
    required this.source,
    required this.destiny
  });
  /*Solicitation(
    this.id,
    this.station,
    this.address,
    this.lat,
    this.long,
    this.hasBikeShared,
    this.stationReturn,
    this.userid
  );*/

  Solicitation.fromJson(Map<String, dynamic> json)
      : id= json['id'] as String,
        station = json['station'] as String,
        address = json['address'] as String,
        lat =  Helping.checkDouble(json['latitutde']),// as double,
        long = Helping.checkDouble(json['longitude']),// as double, //Helping.checkDouble(json['credit']),
        hasBikeShared = json['hasBikeShared'] as bool,
        stationReturn = json['stationReturn'] as String,
        source = json['source'] as String,
        destiny = json['destiny'] as String,
        userid= json['userId'] as String;
}