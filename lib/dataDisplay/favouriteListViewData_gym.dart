import 'package:facilitiesbookingapp/firebase_services/firestore_service.dart';
import 'package:facilitiesbookingapp/models/individual%20category%20Class%20Booking/Class_Favourite_location.dart';
import 'package:flutter/material.dart';

class favouriteLocationGymList extends StatefulWidget {

  @override
  State<favouriteLocationGymList> createState() => _favouriteLocationGymListState();
}

class _favouriteLocationGymListState extends State<favouriteLocationGymList>{
  FirestoreService fsService = FirestoreService();

  void removedItem(String id){
    showDialog<Null>(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Comfirmation'),
            content: Text('Are you sure to want to remove this from your favourite List?'),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      fsService.removedFavouriteListItem(id);
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
    FirestoreService fsService = FirestoreService();

    return StreamBuilder <List<favourite_Location>>(
        stream:fsService.getFavouritelocation(),
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.lightGreen
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data![i].favourite_location, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                            Text('Opening Hour: ' + snapshot.data![i].favourite_opening_hours, style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal)),
                            Text('Facilities:' + snapshot.data![i].favourite_facilities_type, style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal))
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
