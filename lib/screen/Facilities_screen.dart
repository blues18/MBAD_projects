import 'dart:ui';

import 'package:flutter/material.dart';

import '../secondary_screen/gym_location_booking.dart';

class facilities_Screen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor:Color.fromARGB(45, 66, 45, 4),
      appBar: AppBar(
        title:  Row(
          children: [
            Text('Facilities',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Icon(Icons.sports_gymnastics_rounded)
          ],
        )
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15),
              height:100,
              width: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('image_assets/gym.jpg'),
                    fit:BoxFit.cover)),
              child: TextButton(
                onPressed: () => Navigator.of(context).pushNamed(gym_Location_screen.routeName),

                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Text('GYM',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 35, color: Colors.white),textAlign: TextAlign.center,),
                  ],
                )
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              height:100,
              width: 400,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('image_assets/swimming.jpg'),
                      fit:BoxFit.cover)),
              child: TextButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Swimming',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 35, color: Colors.black),textAlign: TextAlign.center,),
                    ],
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              height:100,
              width: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('image_assets/meeting_room.jpg'),
                      fit:BoxFit.cover)),
              child: TextButton(
                  onPressed: () {
                    print('meeting');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Meeting Room',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 35, color: Colors.black),textAlign: TextAlign.center,),
                    ],
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              height:100,
              width: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('image_assets/mutil_purpose_Hall.jpg'),
                      fit:BoxFit.cover)),
              child: TextButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Multi Purpose Hall',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 35, color: Colors.white),textAlign: TextAlign.center,),
                    ],
                  )
              ),
            ),
          ],
        ),
    ));
  }
}
