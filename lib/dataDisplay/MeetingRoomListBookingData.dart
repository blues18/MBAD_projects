import 'package:facilitiesbookingapp/EditScreen(MeetingRoom)/MeetingRoomBookingEdit.dart';
import 'package:facilitiesbookingapp/firebase_services/firestore_service.dart';
import 'package:facilitiesbookingapp/models/individual%20category%20Class%20Booking/Class_bookingItems.dart';
import 'package:flutter/material.dart';

class meetingRoomDataList extends StatefulWidget {

  @override
  State<meetingRoomDataList> createState() => meetingRoomDataListState();
}

class meetingRoomDataListState extends State<meetingRoomDataList>{
  FirestoreService fsService = FirestoreService();

  void removedItem(String id){
    showDialog<Null>(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Comfirmation'),
            content: Text('Are you sure to want to delete?'),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      fsService.removedBookingSlotMeetingRoom(id);
                    });
                    Navigator.of(context).pop();
                  }, child: Text('Yes')),
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text('No')),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context){
    return StreamBuilder <List<bookingMeetingRoom>>(
        stream:fsService.getMeetingRoomBookingItem(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else {
            return ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (ctx, i) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 150,
                        width: 300,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end:  Alignment.bottomLeft,
                                colors: [
                                  Color(0xFF3C786C),
                                  Color(0xFF295249),
                                ]
                            )
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(snapshot.data![i].location, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white)),
                                SizedBox(height: 10),
                                Text('Date: ' + snapshot.data![i].dateSlot, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white70)),
                                SizedBox(height: 5),
                                Text('Time: ' + snapshot.data![i].timeSlot, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white70)),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.deepOrangeAccent,
                                      ),
                                      child: Text(snapshot.data![i].facilities_type,style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white)),
                                    ),
                                    SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () =>
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => editBookingSlot_MeetingRoom(selected: snapshot.data![i],)))
                                      ,
                                      child: Text('Edit Bookings'),
                                      style:  ElevatedButton.styleFrom(
                                        primary: Colors.black87, // background
                                        onPrimary: Colors.white, // foreground
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                    ),
                    Container(
                      height: 100,
                      width: 40,
                      margin: EdgeInsets.all(0),
                      child: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.close_rounded),
                          onPressed: () {
                            removedItem(snapshot.data![i].id);
                          }
                      ),
                    )
                  ],
                );
              },
              itemCount: snapshot.data!.length,
              separatorBuilder: (ctx, i) {
                return Divider(height: 3, color: Colors.blueGrey);
              },
            );
          }
        }
    );
  }
}