
import 'package:bikeshared/views/screens/screen_home.dart';
import 'package:flutter/material.dart';

class ScreenHelloWorld extends StatefulWidget {
  const ScreenHelloWorld({super.key});

  @override
  State<ScreenHelloWorld> createState() => _ScreenHelloWorld();
}

class _ScreenHelloWorld extends State<ScreenHelloWorld> {

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
        resizeToAvoidBottomInset: false,
        //appBar: buildAppBar(),
        body: buildBody(),
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
                  child:  const Text("Hello World"),
                  ),
              ])
          ),
        ),
      ]);
  }


}