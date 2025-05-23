
import 'package:bikeshared/models/station.dart';

class StationRepository {
    static List<Station> list = [];
    static final List<Station> list1 =[];
    static final List<Station> list2 = [
    Station(
      stationId: "D01_Station",
      name: 'Escola Nacional de Policia',//'Departamento da Computação',
      address: 'Camama 1',
      lat: -8.8905235,
      long: 13.2274002,
      capacity: 10,
      freeDocks: 3,
      totalGets: 0,
      totalReturns: 0,
      availableBikeShared: 2,
    ),
    Station(
      stationId: "D02_Station",
      name: 'Espaço Lazer Nandex',//'Departamento de Física',
      address: 'Camama 1',
      lat: -8.8649484,
      long: 13.2939577,
      capacity: 10,
      freeDocks: 3,
      totalGets: 0,
      totalReturns: 0,
      availableBikeShared: 10,
    ),
    Station(
      stationId: "D03_Station",
      name: 'Departamento de Química',
      address: 'Camama 1',
      lat: -8.7663581,
      long: 13.2482776,
      capacity: 10,
      freeDocks: 3,
      totalGets: 0,
      totalReturns: 0,
      availableBikeShared: 5,
    )
    ];
}