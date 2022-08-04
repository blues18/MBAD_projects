import 'dart:ui';
import 'package:facilitiesbookingapp/secondary_screen/Meeting_Room_section/meeting_RoomList.section.dart';
import 'package:facilitiesbookingapp/secondary_screen/Swimming_section/swimming_locationList.dart';
import 'package:flutter/material.dart';
import '../secondary_screen/Gym_Section/gym_locationList_.dart';


class facilities_Screen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      /*
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title:  Row(
          children: [
            Text('Facilities',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black87)),
            Icon(Icons.sports_gymnastics_rounded, color: Colors.black87,)
          ],
        )
      ),
       */
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end:Alignment.bottomLeft,
            colors: [
              Color(0xFF0B3830),
              Color(0xFF4681AA),
            ],
          )
        ),
        child: Column(
          children: <Widget>[
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
                        Text('Facilities',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 30,
                                color: Colors.white
                            )
                        ),
                      ],
                    ),
                ),

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
                  onPressed: () => Navigator.of(context).pushNamed(swimming_location_screen.routeName),
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
                  onPressed: () => Navigator.of(context).pushNamed(meetingRoom_location_screen.routeName),
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
    ),
    );
  }
}
