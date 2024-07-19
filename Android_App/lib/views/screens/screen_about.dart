
//import 'dart:convert';

import 'package:bikeshared/views/screens/screen_home.dart';
import 'package:bikeshared/views/screens/screen_preloading.dart';
import 'package:flutter/material.dart';


class ScreenAbout extends StatefulWidget {
  const ScreenAbout({super.key});

  @override
  State<ScreenAbout> createState() => _ScreenAboutState();
}

class _ScreenAboutState extends State<ScreenAbout> {

  @override
  Widget build(BuildContext context) {
    
    return 
    Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar(){
    return AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => const ScreenHome(),
            ));
          },
        ),
      foregroundColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 0, 14, 27),
        title: const Text('Sobre BikeShared'),
        //centerTitle: true,
      );
  }


  buildBody(){
    Size size = MediaQuery.of(context).size;
    return 
        Stack(children: [
          
          Container(
            color: Colors.white,//const Color(0xff89d5b1),
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(children: [
                
                const Center(child: Text("Info "),),

                SizedBox(
                  width: size.width*0.8,
                  height: 40.0,
                  child: const Text("Bike Shared Team\n\n1. Elizabeth Mateus (Documentation)\n2. Leopoldo Francisco (Project Maneger)\n3. Jone Lengo (Designer) \n4. Pedro Cunha (Developer)")
                ),
              ])      
            ),
          ),
        ]);
  }


}