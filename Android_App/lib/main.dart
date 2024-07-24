import 'package:bikeshared/env.dart';
import 'package:bikeshared/views/start.dart';
import 'package:bikeshared/views/screens/HelloWorl.dart';
import 'package:flutter/material.dart';

import 'services/shared_preferences_manager.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager.init();
  if(SharedPreferencesManager.sharedPreferences.getString('token')!=null){
  }
  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
              primaryColor: const Color.fromARGB(255, 255, 255, 255),
              visualDensity: VisualDensity.adaptivePlatformDensity
          ),
          home:const StartPage()//ScreenHelloWorld()//StartPage()
      )
  );
}