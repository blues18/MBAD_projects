import 'package:facilitiesbookingapp/firebase_services/firestore_service.dart';
import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Detail(firebase).dart';
import 'package:facilitiesbookingapp/secondary_screen/Meeting_Room_section/MeetingRoom_screen.dart';
import 'package:flutter/material.dart';

class meetingRoom_location_screen  extends StatefulWidget {
  static String routeName = '/meetingRoom_Location_Screen';



  @override
  State<meetingRoom_location_screen> createState() => _meetingRoom_location_screenState();
}
class _meetingRoom_location_screenState extends State<meetingRoom_location_screen>{


  Widget displayFacilitiesLocation(){
    FirestoreService fsService = FirestoreService();
    return StreamBuilder<List<Facilities_Details>>(
        stream: fsService.getDetailsOfFacilities_meetingRoom(), //need to change!
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else {
            return Visibility(
              visible: true,
              child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                  itemBuilder: (ctx, i){
                    return Card(
                      color: Colors.lightBlue,
                      borderOnForeground: true,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: InkWell(
                        splashColor: Colors.red.withAlpha(40),
                        onTap: () =>
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> MeetingRoomBookingScreen(selected: snapshot.data![i]))),
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data![i].location,
                                                style: TextStyle(
                                                    fontSize: 17, color: Colors.black),
                                                textAlign: TextAlign.left),
                                            Text(snapshot.data![i].block_And_Level,
                                                style: TextStyle(
                                                    fontSize: 15, color: Colors.black),
                                                textAlign: TextAlign.left),
                                            Text("Opening Hours: " +
                                                snapshot.data![i].Opening_Hour,
                                                style: TextStyle(
                                                    fontSize: 15, color: Colors.black),
                                                textAlign: TextAlign.left)
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
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
                  itemCount: snapshot.data!.length),
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
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              displayFacilitiesLocation()
            ],
          )
      ),
    );
  }
}
