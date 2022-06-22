import 'dart:ui';

import 'package:facilitiesbookingapp/dataDisplay/favouriteListViewData.dart';
import 'package:facilitiesbookingapp/dataDisplay/favouriteListViewData_swimming.dart';
import 'package:facilitiesbookingapp/firebase_services/firestore_service.dart';
import 'package:facilitiesbookingapp/models/Class_Favourite_location.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_navigation.dart';

class favourite_Screen extends StatelessWidget {
FirestoreService fsService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(
                  title: Row(
                      children: [
                        Text('Favourite', style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                        Icon(Icons.favorite),
                      ]
                  )
              ),
              body: SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                children: [
                                  Text('Gym', style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold,),
                                    textAlign: TextAlign.left,),
                                  //Icon(Icons.event_available_rounded),
                                  Spacer(),
                                  FlatButton(
                                    onPressed: () {},
                                    child: const Text('View All',
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.right,),
                                  )
                                ]),
                            Container(
                              height: 200,
                              width: 400,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blueGrey
                              ),
                              child: SingleChildScrollView(
                                child: favouriteLocationGymList(),
                              ),
                            ),
                            Row(
                                children: <Widget>[
                                  Text('Swimming', style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                                  //Icon(Icons.),
                                  Spacer(),
                                  FlatButton(
                                    onPressed: () {},
                                    child: const Text('View All',
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.right,),
                                  )
                                ]),

                            Container(
                              height: 200,
                              width: 400,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blueGrey
                              ),
                              child: SingleChildScrollView(
                                child: favouriteSwimmingList(),
                              ),
                            ),
                            Row(
                                children: <Widget>[
                                  Text('Meeting Rooms', style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                                  //Icon(Icons.),
                                  Spacer(),
                                  FlatButton(
                                    onPressed: () {},
                                    child: const Text('View All',
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.right,),
                                  )
                                ]),

                            Container(
                              height: 200,
                              width: 400,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blueGrey
                              ),
                            ),
                            Row(
                                children: <Widget>[
                                  Text('Multi Purpose Hall', style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                                  //Icon(Icons.),
                                  Spacer(),
                                  FlatButton(
                                    onPressed: () {},
                                    child: const Text('View All',
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.right,),
                                  )
                                ]),

                            Container(
                              height: 200,
                              width: 400,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blueGrey
                              ),
                            ),
                          ]),
                    ],
                  )
              ),
          );
        }}
