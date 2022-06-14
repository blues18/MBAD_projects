import 'package:flutter/material.dart';

class navBottom extends StatefulWidget {

  @override
  State<navBottom> createState() => _navBottomState();
}

class _navBottomState extends State<navBottom> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            selectedIndex == 0? Text('Facilities '):
            selectedIndex == 1? Text('HomePage'):
            selectedIndex == 2? Text('Favourite'):
                Text('Account'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.sports_gymnastics_rounded),label: 'facilities',backgroundColor: Colors.blue),
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home',backgroundColor: Colors.blue),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border_rounded),label: 'Favourite',backgroundColor: Colors.blue),
          BottomNavigationBarItem(icon: Icon(Icons.account_box_rounded),label: 'Account',backgroundColor: Colors.blue),
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
