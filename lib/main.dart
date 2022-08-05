import 'package:facilitiesbookingapp/AuthenticationScreen/reset_Password_Screen.dart';
import 'package:facilitiesbookingapp/firebase_services/authentication_services.dart';
import 'package:facilitiesbookingapp/screen/Facilities_screen.dart';
import 'package:facilitiesbookingapp/screen/Favourite_screen.dart';
import 'package:facilitiesbookingapp/searchfunctions/search_function.dart';
import 'package:facilitiesbookingapp/searchfunctions/search_function_meeting_room.dart';
import 'package:facilitiesbookingapp/secondary_screen/Meeting_Room_section/meeting_RoomList.section.dart';
import 'package:facilitiesbookingapp/secondary_screen/view_all_screen/view_all(homepage).dart';
import 'package:facilitiesbookingapp/splashScreen/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:facilitiesbookingapp/screen/HomePage_screen.dart';
import 'package:facilitiesbookingapp/screen/UserAccount_screen.dart';
import 'package:provider/provider.dart';

import 'AuthenticationScreen/Login_Screen.dart';
import 'AuthenticationScreen/Register_Screen.dart';
import 'searchfunctions/search_function_gym.dart';
import 'secondary_screen/Gym_Section/gym_locationList_.dart';
import 'secondary_screen/Swimming_section/swimming_locationList.dart';


void main() {

  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider<search_function>(create:(context)=>search_function()),
        ChangeNotifierProvider<search_function_meetingRoom>(create:(context)=>search_function_meetingRoom()),
        ChangeNotifierProvider<search_function_Gym>(create:(context)=>search_function_Gym()),
      ],
        child:MyApp()
      )
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Authentication_services authServices = Authentication_services();
  TextEditingController searchFunctionQuery = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting ?
          Center(child: CircularProgressIndicator()):
        StreamBuilder<User?>(
          stream: authServices.getAuthenticationUser(),
          builder: (context, snapshot){
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: snapshot.connectionState == ConnectionState.waiting ?
                Center(child: CircularProgressIndicator()) :
                snapshot.hasData ? splashScreen(): LoginScreen(),
            routes: {
              LoginScreen.routeName: (_) {
                return LoginScreen();
              },
              register_Screen.routeName: (_){
                return register_Screen();
              },
              reset_screen.routeName: (_){
                return reset_screen();
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
              homePage_screen.routeName : (_) {
                return homePage_screen();
                },
              userAccount_Screen.routeName : (_){
                return userAccount_Screen();
                },
              },
            );
          }
      ),
    );
  }
}



class MainScreen extends StatefulWidget {
  //static String routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int selectedIndex = 0;

  final screens = [
    homePage_screen(),
    facilities_Screen(),
    favourite_Screen(),
    userAccount_Screen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black87,
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: FloatingNavbar(
          backgroundColor: Colors.cyan,
          items:  [
            FloatingNavbarItem(
                icon: Icons.home_outlined,
                title: 'Home',
            ),
            FloatingNavbarItem(
              icon: Icons.sports_gymnastics_rounded,
              title: 'Facilities',
            ),
            FloatingNavbarItem(
              icon: Icons.favorite_border_rounded,
              title: 'Favourite',
            ),
            FloatingNavbarItem(
              icon: Icons.person_outline_rounded,
              title: 'Account'
            )
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.orangeAccent[800],
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
    );
  }
}



