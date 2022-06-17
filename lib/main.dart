import 'package:facilitiesbookingapp/main.dart';
import 'package:facilitiesbookingapp/models/Facilities_details.dart';
import 'package:facilitiesbookingapp/screen/Facilities_screen.dart';
import 'package:facilitiesbookingapp/screen/Favourite_screen.dart';
import 'package:facilitiesbookingapp/screen/HomePage_screen.dart';
import 'package:facilitiesbookingapp/screen/UserAccount_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'AuthenticationScreen/testScreen.dart';
import 'firebase_services/firestore_service.dart';
import 'models/booking_class_for_gym.dart';
import 'secondary_screen/gymBooking_screen.dart';
import 'secondary_screen/gym_location_booking.dart';
import 'widgets/bottom_navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (ctx, snapshot) => MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
      routes: {
        test.routeName : (_) {return test();},
        gym_Location_screen.routeName : (_) {return gym_Location_screen();},
        homePage_screen.routeName : (_) {return homePage_screen();}
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    FirestoreService fsService = FirestoreService();

    return StreamBuilder<List<bookingGym>>(
      stream: fsService.getGymBooking(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else {
          return Scaffold(
            body: Column(
              children: [

              ],
            ),
            bottomNavigationBar: bottomNav(),
          );
        }//else
      }
    );
  }
}
