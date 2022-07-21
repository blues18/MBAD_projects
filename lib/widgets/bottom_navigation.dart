import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:facilitiesbookingapp/screen/HomePage_screen.dart';
import 'package:facilitiesbookingapp/screen/Facilities_screen.dart';
import 'package:facilitiesbookingapp/screen/Favourite_screen.dart';
import 'package:facilitiesbookingapp/screen/UserAccount_screen.dart';

class bottomNav extends StatefulWidget {
  static String routeName = '/navBottom';

  @override
  State<bottomNav> createState() => _bottomNavState();
}

class _bottomNavState extends State<bottomNav> {

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
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined, color: Colors.black87),
                label: 'Home', backgroundColor: Colors.white70),
            BottomNavigationBarItem(
                icon: Icon(Icons.sports_gymnastics_rounded, color: Colors.black87),
                label: 'Facilities'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_rounded, color: Colors.black87),
                label: 'Favourite'),
            BottomNavigationBarItem(icon: Icon(Icons.account_box_rounded, color: Colors.black87),
                label: 'Account'),
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
