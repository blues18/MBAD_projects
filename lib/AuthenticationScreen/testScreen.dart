import 'package:flutter/material.dart';

class test extends StatelessWidget {
  static String routeName = '/testscreen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.lightBlue,
      appBar: AppBar(
        title: Stack(
          children:[
            Text(('Working'))
          ]
        ),
      ),
    );
  }
}
