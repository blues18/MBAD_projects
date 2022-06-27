import 'dart:ui';

import 'package:facilitiesbookingapp/dataDisplay/favouriteListViewData_gym.dart';
import 'package:facilitiesbookingapp/dataDisplay/favouriteListViewData_meetingRoom.dart';
import 'package:facilitiesbookingapp/dataDisplay/favouriteListViewData_swimming.dart';
import 'package:facilitiesbookingapp/firebase_services/firestore_service.dart';
import 'package:flutter/material.dart';

class favourite_Screen extends StatelessWidget {
FirestoreService fsService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white70,
                  title: Row(
                      children: [
                        Text('Favourite', style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black87)),
                        Icon(Icons.favorite, color: Colors.black87),
                      ]
                  )
              ),
              body: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end:  Alignment.bottomRight,
                        colors: [
                          Colors.white70,
                          Colors.lightBlueAccent
                        ]
                      )
                    ),
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
                                child: SingleChildScrollView(
                                  child: favouriteMeetingRoomList(),
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
              )
          );
        }}
