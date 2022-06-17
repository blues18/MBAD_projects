import 'package:flutter/material.dart';
import 'package:facilitiesbookingapp/screen/HomePage_screen.dart';
import 'package:facilitiesbookingapp/screen/Facilities_screen.dart';
import 'package:facilitiesbookingapp/screen/Favourite_screen.dart';
import 'package:facilitiesbookingapp/screen/UserAccount_screen.dart';

class bottomNav extends StatefulWidget {

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
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined),
                label: 'Home', backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.sports_gymnastics_rounded),
                label: 'Facilities', backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_rounded),
                label: 'Favourite', backgroundColor: Colors.blue),
            BottomNavigationBarItem(icon: Icon(Icons.account_box_rounded),
                label: 'Account', backgroundColor: Colors.blue),
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
