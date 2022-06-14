import 'package:facilitiesbookingapp/main.dart';
import 'package:facilitiesbookingapp/models/Facilities_details.dart';
import 'package:facilitiesbookingapp/screen/Facilities_screen.dart';
import 'package:facilitiesbookingapp/screen/Favourite_screen.dart';
import 'package:facilitiesbookingapp/screen/HomePage_screen.dart';
import 'package:facilitiesbookingapp/screen/UserAccount_screen.dart';
import 'package:flutter/material.dart';

import 'AuthenticationScreen/testScreen.dart';
import 'secondary_screen/gymBooking_screen.dart';
import 'secondary_screen/gym_location_booking.dart';

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
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
      routes: {
        test.routeName : (_) {return test();},
        gym_Location_screen.routeName : (_) {return gym_Location_screen();},
        //gymbookingScreen.routeName:(_) {return gymbookingScreen();},
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  final screens=[
    homePage_screen(),
    facilities_Screen(),
    favourite_Screen(),
    userAccount_Screen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),
              label: 'Home',backgroundColor: Colors.blue),
          BottomNavigationBarItem(icon: Icon(Icons.sports_gymnastics_rounded),
              label: 'Facilities',backgroundColor: Colors.blue),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border_rounded),
              label: 'Favourite',backgroundColor: Colors.blue),
          BottomNavigationBarItem(icon: Icon(Icons.account_box_rounded),
              label: 'Account',backgroundColor: Colors.blue),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.orange[800],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
