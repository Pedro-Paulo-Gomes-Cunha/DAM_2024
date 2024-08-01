import 'package:bikeshared/controllers/StationController.dart';
import 'package:bikeshared/models/station.dart';
import 'package:bikeshared/services/shared_preferences_manager.dart';
import 'package:flutter/material.dart';

import '../../repositories/station_repository.dart';
import '../../services/solicitation_service.dart';
import '../screens/reportScreen.dart';
import '../screens/screen_profile.dart';

class StationDetails extends StatefulWidget {
  final Station station;
  const StationDetails({super.key, required this.station});

  @override
  State<StationDetails> createState() => _StationDetailsState();
}

class _StationDetailsState extends State<StationDetails> {
  bool isLoading = false;
  late Station station_copy= widget.station;
  String? qrResult="";
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //bool? hasBikeShared = SharedPreferencesManager.sharedPreferences.getBool("hasBikeShared");
    //String? stationSelected = SharedPreferencesManager.sharedPreferences.getString("stationSelected");
    
    return Container(
      width: double.infinity,
      height: size.height * 0.40,
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
              station_copy.name,
              style: const TextStyle(
                fontSize: 17,
                color: Color.fromARGB(221, 78, 78, 78)
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
                  station_copy.address,
                  style: const TextStyle(fontSize: 15),
                  textAlign: TextAlign.left,
                )
              ],
            ) 
          ),

          const SizedBox(height: 3,),         
          SizedBox(
            width: size.width,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text(
                  '${station_copy.availableBikeShared} Bicicletas / ${station_copy.capacity} Docas',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                )
              ],
            ) 
          ),
          const SizedBox(height: 25,),
          
          ElevatedButton(
            style: ButtonStyle(                  
              padding: MaterialStateProperty.all(const EdgeInsets.only(left:30, right: 30, top: 5, bottom: 5)),
              backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 0, 0, 0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            child: isLoading?const CircularProgressIndicator(color: Colors.white,strokeWidth: 3.0,):
            Column(
              mainAxisAlignment: MainAxisAlignment.center,  
              children: [
                SolicitationService.globalHasBikeShared == true /*&& stationSelected == widget.station.stationId*/?
                const Text(
                  "Devolver", 
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ):
                 const Text(
                  "Solicitar", 
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                )
              ],
            ),
            onPressed: () async{
              /*setState(() {
                isLoading = true;
              });*/
              await Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => QRViewScanner(
                onQRCodeScanned: (result) {
                setState(() {
                qrResult = result;
                isLoading = true;

                });},
                ),
                ));
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QRViewScanner()),
              );*/ station_copy= StationRepository.list.where((station) =>
                  station.stationId.contains(qrResult!)).first;

              if(qrResult == "" || station_copy==null){
                showModal('Estação não encontrada', context);}
              else{
                print("_>>>>1111");
                String? UserId = SharedPreferencesManager.sharedPreferences.getString("UserId");
                print("_>>>>2222");
                if(SolicitationService.globalHasBikeShared == false){
                  print("okk333");
                  if(station_copy.availableBikeShared>0){
                    print("_>>>>444");
                    int status = await SolicitationService.solicitation(station_copy.stationId, UserId);
                    print("_>555"+status.toString());
                    if(status == 200){
                      //await StationController.listStations();
                      setState(() {
                        station_copy.availableBikeShared--;
                      });
                      StationController.listStations();
                      showModal('Bina alugada com sucesso!', context);
                    }else if (status == 0) {
                      showModal('O utilizador não existe', context);
                    }else if (status == 1) {
                      showModal('O seu crédito é insuficiente', context);
                    }else if(status == 2){
                      showModal('Utilizador já possui bina', context);
                    }else if(status == 3){
                      showModal('Estação não encontrada', context);
                    }else if(status == 500){
                    //  await StationController.listStations();
                      setState(() {
                        station_copy.availableBikeShared--;
                      });
                      showModal('Bina alugada com sucesso!', context);
                    }
                  }else{
                    showModal('Sem Bina disponível!', context);
                  }

                }else{

                  if(station_copy.freeDocks>0){
                    bool? status = await SolicitationService.returnedBike(station_copy.stationId, UserId);
                    if(status == true){
                      setState(() {
                        station_copy.availableBikeShared++;
                      });
                      StationController.listStations();
                      showModal('Bina devolvida com sucesso!', context);
                    }else if (status == false) {
                      showModal('Bina nao devolvida', context);
                    }
                  }else{
                    showModal('Sem docas vazias!', context);
                  }
                }
              }

              Future.delayed(const Duration(seconds: 1),() {
                setState(() {
                  isLoading = false;
                });
              });


              /*SharedPreferences sharedPreference = await SharedPreferences.getInstance();
              await sharedPreference.clear();
              Navigator.of(context).pop();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => const ScreenLogin(),
              ));*/
            },

          ),

        ],
      ),
    );

    
  }

  showModal(message, context){
    return showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      context: context, 
      builder: (context)=>SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Center(child: Text(message)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      anchorPoint: const Offset(4, 5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
        ),
      ),
    );
  }
}