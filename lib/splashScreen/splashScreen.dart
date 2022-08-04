import 'dart:async';

import 'package:facilitiesbookingapp/main.dart';
import 'package:flutter/material.dart';

class splashScreen extends StatefulWidget {


  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), ()=>Navigator.pushReplacement
      (context, MaterialPageRoute(builder: (context) => MainScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF5B8675),
              Color(0xFF3F6172),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  width: 225.0,
                  height: 255.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('image_assets/BlueBook2.webp'),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                SizedBox(height: 30),
                Text("BlueBook",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
