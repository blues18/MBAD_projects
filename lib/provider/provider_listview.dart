import 'package:facilitiesbookingapp/provider/testbooking_on_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class display_data_list extends StatefulWidget {

  @override
  State<display_data_list> createState() => _display_data_listState();
}

class _display_data_listState extends State<display_data_list> {
  void removedItem(int i, allBookings myBookings){
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
                      myBookings.removedBooking(i);
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
    allBookings booklist = Provider.of<allBookings>(context);
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
                      Text(booklist.getBooking()[i].location, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      Text('Date: ' + booklist.getBooking()[i].dateSlot, style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal)),
                      Text('Time: ' + booklist.getBooking()[i].timeSlot, style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal))
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
                    removedItem(i, booklist);
                  }
                ),
              )
            ],
          );
        },
        separatorBuilder: (ctx, i) {
          return Divider(height: 3, color: Colors.blueGrey);
        },
        itemCount: booklist
            .getBooking()
            .length
    );
  }
}

