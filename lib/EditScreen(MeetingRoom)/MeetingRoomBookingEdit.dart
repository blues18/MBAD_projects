import 'package:facilitiesbookingapp/DatePicker_folder/date_picker_timeline.dart';
import 'package:facilitiesbookingapp/firebase_services/firestore_service.dart';
import 'package:facilitiesbookingapp/main.dart';
import 'package:facilitiesbookingapp/models/individual%20category%20Class%20Booking/Class_bookingItems.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class editBookingSlot_MeetingRoom extends StatefulWidget {
  final bookingMeetingRoom selected; //Constructors

  editBookingSlot_MeetingRoom({
    Key? key,
    required this.selected,
}) : super (key: key);

  @override
  State<editBookingSlot_MeetingRoom> createState() => _editBookingSlot_MeetingRoomState();
}

class _editBookingSlot_MeetingRoomState extends State<editBookingSlot_MeetingRoom> {
  FirestoreService fsService = FirestoreService();
  TextEditingController timeinput = TextEditingController(); //for time field
  TextEditingController textarea = TextEditingController(); // for text field
  DateTime _selectedValue = DateTime.now(); //date
  TimeOfDay selectedTime = TimeOfDay.now(); //time
  String fomattedDate = "";
  String? dateselected_change;
  String? timeSlot_change; //

  String? location;
  String? opening_hours;
  String? dateSlot;
  String? bkandLevel;
  String? timeSlot;
  String? facilities_type;
  bool isChecked = false;

  Widget timePicker(){
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              _selectTime(context);
            },
            child: Text("Choose Time"),
          ),
          //Text("${selectedTime.hour}:${selectedTime.minute}"),
        ],
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,

    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        timeSlot_change = selectedTime.format(context);
        print(timeSlot_change);
      });
    }
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
                  dateselected_change = fomattedDate;
                  print(dateselected_change);
                  }
                );
              }, key: null, )
            ]
        ));
  }

  Widget editButton(){
    return Container(
      width: 170,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      child:ElevatedButton(
        onPressed: () {
          showMyDialog(); changesSent(widget.selected.id);
        },
        child: Row(
          children: [
            Text('ComfirmChanges'),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }

  void changesSent(String id){
    location = widget.selected.location;
    bkandLevel = widget.selected.bkandLevel;
    timeSlot = timeSlot_change;
    dateSlot = dateselected_change;
    facilities_type =widget.selected.facilities_type;

    print(location);
    print(bkandLevel);
    print(timeSlot);
    print(dateSlot);
    print(facilities_type);

    FirestoreService fsService = FirestoreService();
    fsService.editBookingMeetingRoom(id, location, bkandLevel, facilities_type, dateSlot, timeSlot);

    Navigator.push(context, new MaterialPageRoute(builder: (context) =>  new MyApp())); // return back to homepage
  }//edit functions to firebase

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
                Text('Successful Changed', style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.lightBlueAccent)),
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

  @override
  Widget build(BuildContext context) {

    return StreamBuilder <List<bookingMeetingRoom>>(
      stream: fsService.getMeetingRoomBookingItem(),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else{
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.selected.location),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                   margin: EdgeInsets.only(top: 10),
                   height: 200,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20),
                     color: Colors.lightBlueAccent
                   ),
                    child:Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(widget.selected.location,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                        Text('Booking Date: ' + widget.selected.dateSlot, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                        Text('Booking Time: ' + widget.selected.timeSlot, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                        Text('Facilities Type: ' + widget.selected.facilities_type, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                  Datepicking(),
                  timePicker(),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: double.infinity,
                          margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date slot change to: ' + fomattedDate,style: TextStyle(fontSize: 15)),
                              Text('Time slot change to:  ${timeSlot_change}',style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      editButton()
                    ],
                  )
                ],

              )
            ),

          );
        }
      },
    );
  }
}
