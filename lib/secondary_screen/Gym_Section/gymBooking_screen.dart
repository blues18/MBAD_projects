import 'dart:ui';
import 'package:facilitiesbookingapp/DatePicker_folder/date_picker_timeline.dart';
import 'package:facilitiesbookingapp/firebase_services/firestore_service.dart';
import 'package:facilitiesbookingapp/models/FacilitiesDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class gymbookingScreen extends StatefulWidget {
static String routeName = '/gymBookingScreen';
final detail selected;

gymbookingScreen({
  Key? key,
  required this.selected,s
}): super(key: key);


  @override
  State<gymbookingScreen> createState() => _gymbookingScreenState();
}

MaterialStateProperty<Color>getColor(Color color,Color colorPressed){
  final getColor = (Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return colorPressed;
    }else{
      return color;
    }
  };
  return MaterialStateProperty.resolveWith(getColor);
}


class _gymbookingScreenState extends State<gymbookingScreen> {
  var form = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;
  DateTime _selectedValue = DateTime.now();
  String fomattedDate = "";
  List dateinput = [];
  List Bookingtimeslot = [];


  String? location;
  String? opening_hours;
  String? dateSlot;
  String? bkandLevel;
  String? timeSlot;
  String? facilities_type;
  String? Email;

  void addtofavourite(){
    location = widget.selected.place;
    bkandLevel = widget.selected.location;
    opening_hours = widget.selected.opening_hours;
    facilities_type = widget.selected.facilites_type;
    Email = user.email;

    print(location);
    print(opening_hours);
    print(bkandLevel);
    print(facilities_type);

    FirestoreService fsService = FirestoreService();
    fsService.addtofavourite(location, opening_hours, bkandLevel,facilities_type,Email);

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:Text('Successfully added to Favourite'))
    );
  }

  void createbooking(){
    location = widget.selected.place;
    bkandLevel = widget.selected.location;
    timeSlot = Bookingtimeslot.removeLast();
    dateSlot = dateinput.removeLast();
    facilities_type =widget.selected.facilites_type;
    Email= user.email;

    print(location);
    print(bkandLevel);
    print(timeSlot);
    print(dateSlot);
    print(facilities_type);
    print(Email);


    FirestoreService fsService = FirestoreService();
    fsService.addBookingTofirebase(location, bkandLevel, facilities_type, dateSlot, timeSlot,Email);

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content:Text('Successfully booked')),
    );
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.teal,
          //title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Successful Booked', style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.lightBlueAccent)),
                SizedBox(height: 20),
                Icon(Icons.book_rounded,size: 30, color: Colors.lightBlueAccent),
                SizedBox(height: 20),
                Text('Have a Nice Day', style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.lightBlueAccent)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok', style: TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget cfmButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FlatButton(
          onPressed: () {
            addtofavourite();
          },
          color: Colors.lightBlue,
          child: Row(
            children: [
              Icon(Icons.star),
              Text('Add to Favourite'),
            ],
          ),
        ),
        FlatButton(
          onPressed: () { createbooking(); showMyDialog(); },
          color: Colors.lightBlue,
          child: Row(
            children: [
              Text('Book'),
              Icon(Icons.arrow_forward_ios_rounded),
            ],
          ),
        ),
      ],
    );
  }

  Widget Datepicking(){
    return Container(
        height: 160,
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        child: Column(
            children: <Widget>[
              Text(fomattedDate.toString()),
              //Text(storedtest.join(',')),
              DatePickerTimeline(_selectedValue, onDateChange: (date) {
                setState(() {
                  _selectedValue = date;
                  fomattedDate = DateFormat.yMMMEd().format(_selectedValue);
                  dateinput.add(fomattedDate);
                  if(dateinput.length == 2){
                    dateinput.removeLast();
                  }
                });
              }, key: null, )
            ]
        ));
  }



  Widget timeSlotButton() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  overlayColor: getColor(Colors.white, Colors.teal)
              ),
              child: Text('07:00'),
              onPressed: () {
                setState(() {
                  String testlistslot1 = '07:00';
                  Bookingtimeslot.insert(0,testlistslot1);
                  if (Bookingtimeslot.length == 2){
                    Bookingtimeslot.removeLast();
                  }
                });
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  overlayColor: getColor(Colors.white, Colors.teal)
              ),
              child: Text('09:00'),
              onPressed: () {
                setState(() {
                  String testlistslot1 = '09:00';
                  Bookingtimeslot.insert(0,testlistslot1);
                  if (Bookingtimeslot.length == 2){
                    Bookingtimeslot.removeLast();
                  }
                });
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  overlayColor: getColor(Colors.white, Colors.teal)
              ),
              child: Text('11:00'),
              onPressed: () {
                setState(() {
                  String testlistslot1 = '11:00';
                  Bookingtimeslot.insert(0,testlistslot1);
                  if (Bookingtimeslot.length == 2){
                    Bookingtimeslot.removeLast();
                  }
                });
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  overlayColor: getColor(Colors.white, Colors.teal)
              ),
              child: Text('13:00'),
              onPressed: () {
                setState(() {
                  String testlistslot1 = '13:00';
                  Bookingtimeslot.insert(0,testlistslot1);
                  if (Bookingtimeslot.length == 2){
                    Bookingtimeslot.removeLast();
                  }
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  overlayColor: getColor(Colors.white, Colors.teal)
              ),
              child: Text('15:00'),
              onPressed: () {
                setState(() {
                  String testlistslot1 = '15:00';
                  Bookingtimeslot.insert(0,testlistslot1);
                  if (Bookingtimeslot.length == 2){
                    Bookingtimeslot.removeLast();
                  }
                });
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  overlayColor: getColor(Colors.white, Colors.teal)
              ),
              child: Text('17:00'),
              onPressed: () {
                setState(() {
                  String testlistslot1 = '17:00';
                  Bookingtimeslot.insert(0,testlistslot1);
                  if (Bookingtimeslot.length == 2){
                    Bookingtimeslot.removeLast();
                  }
                });
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  overlayColor: getColor(Colors.white, Colors.teal)
              ),
              child: Text('19:00'),
              onPressed: () {
                setState(() {
                  String testlistslot1 = '19:00';
                  Bookingtimeslot.insert(0,testlistslot1);
                  if (Bookingtimeslot.length == 2){
                    Bookingtimeslot.removeLast();
                  }
                });
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  overlayColor: getColor(Colors.white, Colors.teal)
              ),
              child: Text('21:00'),
              onPressed: () {
                setState(() {
                  String testlistslot1 = '21:00';
                  Bookingtimeslot.insert(0,testlistslot1);
                  if (Bookingtimeslot.length == 2){
                    Bookingtimeslot.removeLast();
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //allBookings booklist = Provider.of<allBookings>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.selected.place),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 350,
                width: double.infinity,
                //margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Text(widget.selected.place, style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10),
                    Text(widget.selected.location,
                        style: TextStyle(fontSize: 15)),
                    SizedBox(height: 10),
                    Text(widget.selected.opening_hours,
                        style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              //horizontal_date_picker(),
              Datepicking(),
              timeSlotButton(),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Date ' + fomattedDate),
                  Text('TimeSlot Selected:' + Bookingtimeslot.join(',')),
                ],
              ),
              SizedBox(height: 30),
              cfmButton(),
              //Text(valueEntered.toString()),
            ],
          ),
        )
    );
  }
}
