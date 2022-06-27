import 'dart:ui';
import 'package:facilitiesbookingapp/dataDisplay/MeetingRoomListBookingData.dart';
import 'package:facilitiesbookingapp/dataDisplay/SwimmingListBookingData.dart';
import 'package:facilitiesbookingapp/dataDisplay/GymListDataData.dart';
import 'package:facilitiesbookingapp/secondary_screen/view_all_screen/view_all(homepage).dart';
import 'package:flutter/material.dart';
import '../firebase_services/firestore_service.dart';

class homePage_screen extends StatefulWidget {
  static String routeName = '/homepage';

  @override
  State<homePage_screen> createState() => _homePage_screenState();
}

class _homePage_screenState extends State<homePage_screen> {
  FirestoreService fsService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white70,
              title: Row(
                children: [
                  Text('HomePage', style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black54)),
                  Icon(Icons.home, color: Colors.black54,),
                ],
              )
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end:  Alignment.bottomRight,
                  colors: [
                    Colors.white70,
                    Colors.lightBlueAccent
               ]
              ),
            ),
              child:Column(
            children: [
              Row(
                  children: [
                    Text('Events', style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold,)),
                    Icon(Icons.event_available_rounded),
                  ]),
              Container(
                height: 150,
                width: 400,
                margin: EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(60),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.deepPurple,
                        Colors.redAccent,
                      ]
                    )
                ),
              ),
              Row(
                  children: <Widget>[
                    Text('Your Booking', style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                    Icon(Icons.book_outlined),
                    Spacer(),
                    FlatButton(
                      onPressed: () => Navigator.of(context).pushNamed(View_all_At_homePage.routeName),

                      child: const Text(
                        'View All', style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.right,),
                    )
                  ]),
              Container(
                  height: 300,
                  width: double.infinity,
                  margin: EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(60),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.deepPurple,
                            Colors.redAccent,
                          ]
                      )
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        display_data_list(),
                        swimmingDataList(),
                        meetingRoomDataList(),
                      ],
                    )
                    ),
                  )
            ],
          ),
          ),
        );
      }
  }




