import 'dart:ui';
import 'package:facilitiesbookingapp/DatePicker_folder/date_picker_timeline.dart';
import 'package:facilitiesbookingapp/models/testdata.dart';

import 'package:flutter/material.dart';

import '../DatePicker_folder/date_picker_widgets.dart';

class gymbookingScreen extends StatefulWidget {
static String routeName = '/gymBookingScreen';
final detail selected;

gymbookingScreen({
  Key? key,
  required this.selected,
}): super(key: key);

  @override
  State<gymbookingScreen> createState() => _gymbookingScreenState();
}

class _gymbookingScreenState extends State<gymbookingScreen> {
DateTime _selectedValue = DateTime.now();

Widget Cfmdate(){
  return Container(
      height: 140,
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      child: Column(
          children: <Widget>[
            //Text("Selected Date"),
            //Padding(
            //padding: EdgeInsets.all(10),
            //),
            Text(_selectedValue.toString()),
            DatePickerTimeline(_selectedValue, onDateChange: (date) {
              setState(() {
                _selectedValue = date;
              });
            }, key: null, )
          ]));
}

Widget cfmButton(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    //crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      FlatButton(
        onPressed: (){print(_selectedValue);},
        color: Colors.lightBlue,
        child: Row(
          children: [
            Icon(Icons.star),
            Text('Add to Favourite'),
          ],
        ),
      ),
      FlatButton(
        onPressed: (){},
        color: Colors.lightBlue,
        child: Row(
          children: [
            Text('Proceed'),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selected.place),
      ),
      body: SingleChildScrollView(
        child: Column(
        children:<Widget>[
          Container(
            height: 350,
            width: double.infinity,
            //margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
              Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
                Text(widget.selected.place,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 10),
                Text(widget.selected.location, style: TextStyle(fontSize: 15)),
                SizedBox(height: 10),
                Text(widget.selected.opening_hours, style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
          SizedBox(height: 10,),
          horizontal_date_picker(),
          cfmButton(),
          ],
        ),
      )
    );
  }
}
