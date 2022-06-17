import 'package:facilitiesbookingapp/models/booking_class_for_gym.dart';
import 'package:flutter/material.dart';

import '../firebase_services/firestore_service.dart';

class testingStream extends StatefulWidget {
  @override
  State<testingStream> createState() => _testingStreamState();
}

class _testingStreamState extends State<testingStream> {
  FirestoreService fsService = FirestoreService();

  void removedItem(String id) {
    showDialog<Null>(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('are you sure you want to delete'),
          actions: [
            TextButton(onPressed: () {
              setState(() {
                fsService.removedBookingSlot(id);
              });
              Navigator.of(context).pop();
            },child: Text('Yes')),
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              },child: Text('No'),
                )
              ]
            );
      });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<bookingGym>>(
        stream: fsService.getGymBooking(), //why cannot read data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          } else {
            return ListView.separated(
              itemBuilder: (cix, i) {
                return Container(
                  height: 60,
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                      children:[
                        Container(
                          child: Column(
                            children: [
                              Text(snapshot.data![i].location),
                              Text(snapshot.data![i].datesslot),
                              Text(snapshot.data![i].timeslot),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: (){removedItem(snapshot.data![i].id);},
                        )
                      ]
                  ),
                );
              },
              itemCount: snapshot.data!.length,
              separatorBuilder: (ctx, i) {
                return const Divider(height: 3, color: Colors.blueGrey,);
              },
            );
          }
        }
    );
  }
}
