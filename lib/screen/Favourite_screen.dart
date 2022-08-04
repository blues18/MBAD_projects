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
              body: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end:  Alignment.bottomRight,
                        colors: [
                          Color(0xFF094241),
                          Color(0xFF1A809A),
                        ]
                      )
                    ),
                    child: Stack(
                    children: <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black,
                                          width: 3.0
                                      )
                                  ),
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color(0xFF094241),
                                        Color(0xFF042932),
                                      ]
                                  )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 60),
                                  Text('Favourite',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 30,
                                          color: Colors.white
                                      )
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                                children: [
                                  Text('Gym', style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                    textAlign: TextAlign.left,
                                  ),
                                  //Icon(Icons.event_available_rounded),
                                  Spacer(),
                                  FlatButton(
                                    onPressed: () {},
                                    child: const Text('View All',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white
                                      ),
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
                                  color: Colors.blueGrey,
                                    gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xFF0FACA8),
                                      Color(0xFF1190AC),
                                  ]
                                 ),
                              ),
                              child: SingleChildScrollView(
                                child: favouriteLocationGymList(),
                              ),
                            ),
                            Row(
                                children: <Widget>[
                                  Text('Swimming', style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    )
                                  ),
                                  //Icon(Icons.),
                                  Spacer(),
                                  FlatButton(
                                    onPressed: () {},
                                    child: const Text('View All',
                                      style: TextStyle(fontSize: 15, color: Colors.white),
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
                                  color: Colors.blueGrey,
                                    gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xFF0FACA8),
                                          Color(0xFF1190AC),
                                        ]
                                    ),
                              ),
                              child: SingleChildScrollView(
                                child: favouriteSwimmingList(),
                              ),
                            ),
                            Row(
                                children: <Widget>[
                                  Text('Meeting Rooms', style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                                  //Icon(Icons.),
                                  Spacer(),
                                  FlatButton(
                                    onPressed: () {},
                                    child: const Text('View All',
                                      style: TextStyle(fontSize: 15,color: Colors.white),
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
                                  color: Colors.blueGrey,
                                    gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xFF0FACA8),
                                          Color(0xFF1190AC),
                                        ]
                                    ),
                              ),
                                child: SingleChildScrollView(
                                  child: favouriteMeetingRoomList(),
                                ),
                            ),
                            Row(
                                children: <Widget>[
                                  Text('Multi Purpose Hall', style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                                  //Icon(Icons.),
                                  Spacer(),
                                  FlatButton(
                                    onPressed: () {},
                                    child: const Text('View All',
                                      style: TextStyle(fontSize: 15,color: Colors.white),
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
                                  color: Colors.blueGrey,
                                    gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xFF0FACA8),
                                          Color(0xFF1190AC),
                                        ]
                                    ),
                              ),
                            ),
                          ]),
                    ],
                  )
                ),
              )
          );
        }}
