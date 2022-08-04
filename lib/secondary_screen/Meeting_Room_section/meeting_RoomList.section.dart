import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facilitiesbookingapp/firebase_services/firestore_service.dart';
import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Detail(firebase).dart';
import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Details_For_MeetingRoom.dart';
import 'package:facilitiesbookingapp/secondary_screen/Meeting_Room_section/MeetingRoom_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class meetingRoom_location_screen  extends StatefulWidget {
  static String routeName = '/meetingRoom_Location_Screen';


  @override
  State<meetingRoom_location_screen> createState() => _meetingRoom_location_screenState();
}
class _meetingRoom_location_screenState extends State<meetingRoom_location_screen>{
  bool isDescending = false;

 String? collapsedButtontext; //store for later functions

  Widget SortbyAlphabetically() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ExpensionfilterButton(),
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green
          ),
          child: TextButton.icon(
            icon: const RotatedBox(
              quarterTurns: 1,
              child: Icon(Icons.compare_arrows, size: 28),
            ),
            label: Text(isDescending ? 'Descending By Alphabetically ' : 'Ascending By Alphabetically ',
                style: TextStyle(fontSize: 20, color: Colors.white)
            ),
            onPressed: () => setState(()
            => isDescending = !isDescending
            ),
          ),
        ),
        Expanded(child: displayFacilitiesLocation())
      ],
    );
  }

  Widget displayFacilitiesLocation(){
    FirestoreService fsService = FirestoreService();
    return StreamBuilder<List<Facilities_Details_Meeting_Room>>(
        stream: fsService.getDetailsOfFacilities_MeetingRooms(), //need to change!
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else {
            return ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, i) {
                    final sortItems = isDescending ? snapshot.data!.reversed
                        .toList() : snapshot.data!;
                    if(snapshot.data![i].Room_Size.toLowerCase() == collapsedButtontext){
                      print('Yes');
                    }return Card(
                          color: Colors.lightBlue,
                          borderOnForeground: true,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: InkWell(
                            splashColor: Colors.red.withAlpha(40),
                            onTap: () =>
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (
                                    context) =>
                                    MeetingRoomBookingScreen(selected: sortItems[i]))),
                            //passing data to the screen class
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: 400,
                                      height: 100,
                                      margin: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 250,
                                            height: 100,
                                            //color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(sortItems[i].Location,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black),
                                                    textAlign: TextAlign.left),
                                                Text(sortItems[i].Block_And_Level,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                    textAlign: TextAlign.left),
                                                Text("Opening Hours: " +
                                                    sortItems[i].Opening_Hour,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                    textAlign: TextAlign.left),
                                                Text("Room Capacity " +
                                                    sortItems[i].Room_Size.toString(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                    textAlign: TextAlign.left)
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(10),
                                              color: Colors.black,
                                              //image: DecorationImage(
                                              //image: AssetImage(),
                                              //fit: BoxFit.cover,
                                              // )
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ]
                            ),
                          ),
                        );
                  },
                  separatorBuilder: (ctx, i){
                    return Divider(height: 3, color: Colors.blueGrey,);
                  },
                );
          }
        }
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meeting Room'),
      ),
      body: Stack(
            children:[
              SortbyAlphabetically(),
            ],
          )
    );
  }

  Widget ExpensionfilterButton() {
    return Column(
      children: <Widget>[
        ExpansionTile(
            title: Text('Filter'),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed:() {
                        collapsedButtontext = 'small';

                      },
                      child: Text('Small')
                  ),
                  TextButton(
                      onPressed:() {
                        collapsedButtontext = 'medium';

                      },
                      child: Text('Medium')
                  ),
                  TextButton(onPressed:() {
                    collapsedButtontext = 'large';
                  }, child: Text('Large')
                  ),
                ],
              )
            ],
        )
      ],
    );
  }



}
