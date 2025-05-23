import 'package:bikeshared/controllers/StationController.dart';
import 'package:bikeshared/services/shared_preferences_manager.dart';
import 'package:bikeshared/services/user_service.dart';
import 'package:flutter/material.dart';

import '../../services/solicitation_service.dart';


class ScreenProfile extends StatefulWidget {

  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  final String? name = SharedPreferencesManager.sharedPreferences.getString("name");

  final String? email = SharedPreferencesManager.sharedPreferences.getString("email");

  late double? balance = SharedPreferencesManager.sharedPreferences.getDouble("credit");

  final bool? hasBikeShared = SharedPreferencesManager.sharedPreferences.getBool("hasBikeShared");
  late Future <bool> credit= UserService.HasCredit();
  @override
  void initState(){
    super.initState();
    //credit = (SharedPreferencesManager.sharedPreferences.getDouble('credit')! > 0 ?true:false) as Future<bool>;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(hasBikeShared);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 0, 14, 27),
        title: const Text("Perfil do Utilizador"),
      ),
      body: FutureBuilder<bool>(
        future: credit,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            balance = SharedPreferencesManager.sharedPreferences.getDouble("credit");
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nome:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    name!,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Email:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    email!,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Saldo:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "$balance Pontos",
                    style: const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    "Bike Alugada:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),

                  
                  (SolicitationService.globalHasBikeShared==false)?
                  const Text(
                    "Nenhuma",
                    style: TextStyle(fontSize: 18),
                  ):
                  const Text(
                    "Sim",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            );
          }
          return SizedBox(
            width: size.width,
            height: size.height,
            child: const Center(child: CircularProgressIndicator())
          );
        }),
      )
    );
  }
}
