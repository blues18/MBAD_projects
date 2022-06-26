import 'package:facilitiesbookingapp/dataDisplay/MeetingRoomListBookingData.dart';
import 'package:facilitiesbookingapp/dataDisplay/SwimmingListBookingData.dart';
import 'package:facilitiesbookingapp/dataDisplay/GymListDataData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class View_all_At_homePage extends StatefulWidget {
  static String routeName = '/View_all_for_homepage';

  @override
  State<View_all_At_homePage> createState() => _View_all_At_homePageState();
}
class _View_all_At_homePageState extends State<View_all_At_homePage> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              Text('Your Booking', style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold)),
              Icon(Icons.book_rounded),
            ],
          )
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          )
        ),
        child:SingleChildScrollView(
          child: Column(
            children: [
              /*
              Container(
                height: 75,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      )
                  ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.filter_1_rounded,size: 40,),
                    SizedBox(width: 140,),
                  ],
                )
              ),
               */
              display_data_list(),
              swimmingDataList(),
              meetingRoomDataList(),
            ],
          ),
        )
      ),
    );
  }

}
