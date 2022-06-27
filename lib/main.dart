import 'package:facilitiesbookingapp/secondary_screen/Meeting_Room_section/meeting_RoomList.section.dart';
import 'package:facilitiesbookingapp/secondary_screen/view_all_screen/view_all(homepage).dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'AuthenticationScreen/testScreen.dart';
import 'firebase_services/firestore_service.dart';
import 'models/individual category Class Booking/Class_bookingItems.dart';
import 'secondary_screen/Gym_Section/gym_locationList_.dart';
import 'secondary_screen/Swimming_section/swimming_locationList.dart';
import 'widgets/bottom_navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MainScreen(),
            routes: {
              test.routeName: (_) {
                return test();
              },
              gym_Location_screen.routeName: (_) {
                return gym_Location_screen();
              },
              swimming_location_screen.routeName : (_) {
                return swimming_location_screen();
                },
              meetingRoom_location_screen.routeName: (_) {
                return meetingRoom_location_screen();
              },
              View_all_At_homePage.routeName: (_) {
                return View_all_At_homePage();
              },

              //homePage_screen.routeName : (_) {return homePage_screen();}
            },
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  static String routeName = '/';
  int selectedIndex = 0;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    FirestoreService fsService = FirestoreService();

    return StreamBuilder<List<bookingItem>>(
      stream: fsService.getBookingTicketGym(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else {
          return Scaffold(
            body: Column(
              children: [],
            ),
            bottomNavigationBar: bottomNav(),
          );
        } //else
      },
    );
  }
}