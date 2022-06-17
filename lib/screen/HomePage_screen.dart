import 'dart:ui';

import 'package:facilitiesbookingapp/models/booking_class_for_gym.dart';
import 'package:flutter/material.dart';

import '../firebase_services/firestore_service.dart';
import '../test screen/testing_Firebase_to_homepage.dart';

class homePage_screen extends StatefulWidget {
  static String routeName = '/homepage';

  @override
  State<homePage_screen> createState() => _homePage_screenState();
}

class _homePage_screenState extends State<homePage_screen> {
  @override
  Widget build(BuildContext context) {
    FirestoreService fsService = FirestoreService();

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
                    height: 200,
                    width: double.infinity,
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey
                    ),
                    child:testingStream()
                    ),
                ],
              ),
            );
      }
}


