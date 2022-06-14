import 'dart:ui';

import 'package:flutter/material.dart';

class homePage_screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('HomePage',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
            Icon(Icons.home),
          ],
        )
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text('Events',style:TextStyle(fontSize: 30, fontWeight: FontWeight.bold,)),
              Icon(Icons.event_available_rounded),
            ]),
          Container(
            height: 150,
            width:  400,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueGrey
            ),
          ),
          Row(
            children: <Widget>[
              Text('Your Booking',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Icon(Icons.book_outlined),
              Spacer(),
              FlatButton(
                onPressed: () {},
                child: const Text('View All',style:TextStyle(fontSize: 15),textAlign: TextAlign.right,),
              )
            ]),
          Container(
            padding: EdgeInsets.all(100.0),
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              color: Colors.blueGrey
            ),
          )
        ],
      ),
    );
  }
}
