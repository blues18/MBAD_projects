import 'package:facilitiesbookingapp/DatePicker_folder/date_picker_timeline.dart';
import 'package:facilitiesbookingapp/firebase_services/firestore_service.dart';
import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Detail(firebase).dart';
import 'package:facilitiesbookingapp/widgets/timePicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class MeetingRoomBookingScreen extends StatefulWidget {
  static String routeName = '/swimmingBookingScreen';
  final Facilities_Details selected; //constructor data that is passed from previous screen

  MeetingRoomBookingScreen({  //
    Key? key,
    required this.selected,
}) : super(key:key);

  @override
  State<MeetingRoomBookingScreen> createState() => _MeetingRoomBookingScreenState();
}

Color getColor(Set<MaterialState> states) {   ///checkBox
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return Colors.red;
}

class _MeetingRoomBookingScreenState extends State<MeetingRoomBookingScreen>{
  TextEditingController timeinput = TextEditingController(); //for time field
  TextEditingController textarea = TextEditingController(); // for text field
  DateTime _selectedValue = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String fomattedDate = "";
  List dateinput_meetingRoom = [];
  String? Bookingtimeslot_meetingRoom;

  String? location;
  String? opening_hours;
  String? dateSlot;
  String? bkandLevel;
  String? timeSlot;
  String? facilities_type;
  bool isChecked = false;


  //////////////////////////////////////////// TimePicker ///////////////////////
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
          Text("${selectedTime.hour}:${selectedTime.minute}"),
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
        Bookingtimeslot_meetingRoom = selectedTime.format(context);
        print(Bookingtimeslot_meetingRoom);
      });
    }
  }
////////////////////////////////////////////////// TimePicker////////////////////
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
                  dateinput_meetingRoom.add(fomattedDate);
                  if(dateinput_meetingRoom.length == 2){
                    dateinput_meetingRoom.removeLast();
                  }
                });
              }, key: null, )
            ]
        ));
  }

  Widget add_ons_and_office_Button(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              add_ons_checkBox();
            },
            child: Row(
            children:[
              Text('Add-Ons'),
              Icon(Icons.add_circle_rounded)
            ],
          )
        ),
        ElevatedButton(
            onPressed: () {
              Office_contacts();
            },
            child: Row(
              children:[
                Text('Office Contacts'),
                Icon(Icons.contact_page_rounded)
              ],
            )
        ),
      ]
    );
  }

  Widget TextfieldRemarks(){
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: textarea,
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            decoration: InputDecoration(
                hintText: "Other Request",
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.redAccent)
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget Comfirmation_and_Favourtie_Button() {
    //allBookings booklist = Provider.of<allBookings>(context);
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
          onPressed: () {
            createbooking(); showMyDialog();
          },
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

  Widget previousScreenButton(){
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Icon(Icons.arrow_back_rounded)
      ],
    );
  }

  void addtofavourite(){
    location = widget.selected.location;
    bkandLevel = widget.selected.block_And_Level;
    opening_hours = widget.selected.Opening_Hour;
    facilities_type = widget.selected.Facilities_Type;

    print(location);
    print(opening_hours);
    print(bkandLevel);
    print(facilities_type);

    FirestoreService fsService = FirestoreService();
    fsService.addtoMeetingRoomFavourite(location, opening_hours, bkandLevel, facilities_type);

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:Text('Successfully added to Favourite'))
    );
  }

  void createbooking(){
    location = widget.selected.location;
    opening_hours = widget.selected.Opening_Hour;
    bkandLevel = widget.selected.block_And_Level;
    timeSlot = Bookingtimeslot_meetingRoom;
    dateSlot = dateinput_meetingRoom.removeLast();
    facilities_type =widget.selected.Facilities_Type;

    print(location);
    print(bkandLevel);
    print(timeSlot);
    print(dateSlot);
    print(facilities_type);

    /*
    print(location.runtimeType);
    print('1');
    print(bkandLevel.runtimeType);
    print('3');
    print(timeSlot.runtimeType);
    print('4');
    print(dateSlot.runtimeType);
    print('5');
    print(facilities_type.runtimeType);
    print('6');
    */

    FirestoreService fsService = FirestoreService();
    fsService.addBookingToFirebase_MeetingRoom(location, bkandLevel, facilities_type, dateSlot, timeSlot);

  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
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

  void add_ons_checkBox(){
    showDialog(
        context: context,
        builder:(context){
          return StatefulBuilder(
              builder: (context,setState){
                return SimpleDialog(
                  title: Text('Add-ons'),
                  children: [
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('items'),
                      subtitle: Text('items examples'),
                      //tileColor: Colors.lightBlueAccent,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      activeColor: Colors.lightBlueAccent,
                      checkColor: Colors.redAccent,
                    ),
                  ],
                );
              }
          );
        }
    );
  }

  void Office_contacts(){
    showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            children: [
              Text('For more details or enquiry please contact the office or email them.',
                style:TextStyle(fontSize: 20 ,fontWeight: FontWeight.w700)),
              SizedBox(height: 20),
              Text('Email:' + widget.selected.Opening_Hour),
              SizedBox(height: 20,),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Stack(                  //might have to change to stack instead
             children: [
               Container(
                 height: 200,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   color:Colors.green
                 ),
                 child: Image.asset('image_assets/meeting_room.jpg',fit: BoxFit.cover),
               ),
               previousScreenButton(),
             ],
            ),
            Container(
              height: 240,
              width: double.infinity,
              margin: EdgeInsets.all(20), //can be top and left only
              decoration: BoxDecoration(
                color: Colors.deepPurple
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.selected.location,style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800)),
                  Text(widget.selected.block_And_Level,style: TextStyle(fontSize: 23,fontWeight: FontWeight.w400)),
                  Text('Opening Hour:' + widget.selected.Opening_Hour,style: TextStyle(fontSize: 23,fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            SizedBox(height: 20,),
            add_ons_and_office_Button(),
            Datepicking(),
            Container(
              height: 150,
              margin: EdgeInsets.only(
                right: 20,
                left: 20,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black54,
                  width: 4,
                ),
                color: Colors.green
              ),
              child: Text('Notices'),
            ),
            timePicker(),
            SizedBox(height: 10),
            TextfieldRemarks(),
            SizedBox(height: 20),
            Comfirmation_and_Favourtie_Button(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}