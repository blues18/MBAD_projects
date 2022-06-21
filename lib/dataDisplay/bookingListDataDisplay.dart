import 'package:facilitiesbookingapp/firebase_services/firestore_service.dart';
import 'package:facilitiesbookingapp/models/class_bookingItem_firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class display_data_list extends StatefulWidget {

  @override
  State<display_data_list> createState() => _display_data_listState();
}

class _display_data_listState extends State<display_data_list> {
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
                      fsService.removedBookingSlot(id);
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
  Widget build(BuildContext context) {
    return StreamBuilder <List<bookingItem>>(
      stream:fsService.getBookingTicketGym(),
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
                        height: 100,
                        width: 300,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.lightGreen
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data![i].location, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                            Text('Date: ' + snapshot.data![i].dateSlot, style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal)),
                            Text('Time: ' + snapshot.data![i].timeSlot, style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal))
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
