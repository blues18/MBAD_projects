import 'package:facilitiesbookingapp/DatePicker_folder/date_picker_timeline.dart';
import 'package:facilitiesbookingapp/firebase_services/firestore_service.dart';
import 'package:facilitiesbookingapp/main.dart';
import 'package:facilitiesbookingapp/models/individual%20category%20Class%20Booking/Class_bookingItems.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late String dateselected_change = widget.selected.dateSlot;
  late String timeSlot_change = widget.selected.timeSlot;
  String? other_request;
  final user = FirebaseAuth.instance.currentUser!;


  ///tickbox_chnages///
  late bool smartTv = widget.selected.smart_tv;
  late bool whiteBoard = widget.selected.whiteboard;
  late bool Wifi = widget.selected.wifi;
  late bool digitalAvSolution = widget.selected.digitalAvSolution;
  late bool officeSupplies = widget.selected.officeSupplies;
  late bool accesstoRefreshment = widget.selected.accessToRefreshment;

  String? location;
  String? opening_hours;
  String? dateSlot;
  String? bkandLevel;
  String? timeSlot;
  String? facilities_type;
  String? Room_size;
  String? Room_number;
  String? Email;
  String? facilities_image;
  String? User_request;
  bool? tickBox_smartTv;
  bool? tickBox_Whiteboard;
  bool? tickBox_Wifi;
  bool? tickBox_digitalAvSolution;
  bool? tickBox_officeSupplies;
  bool? tickBox_accessToRefreshment;


  Widget editButton(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.orangeAccent,
      ) ,
      onPressed: () {
        showMyDialog(); changesSent(widget.selected.id);
      },
      child: Row(
        children: [
          Text('ComfirmChanges'),
          Icon(Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }

  void changesSent(String id){  //this part need to change edit or it will read null
    location = widget.selected.location;
    bkandLevel = widget.selected.bkandLevel;
    timeSlot = timeSlot_change;
    dateSlot = dateselected_change;
    facilities_type =widget.selected.facilities_type;
    Room_size = widget.selected.Room_Size;
    Room_number = widget.selected.Room_Number;
    Email = user.email;
    User_request = other_request;
    tickBox_smartTv =  smartTv;
    tickBox_Whiteboard = whiteBoard;
    tickBox_Wifi = Wifi;
    tickBox_digitalAvSolution = digitalAvSolution;
    tickBox_officeSupplies = officeSupplies;
    tickBox_accessToRefreshment = accesstoRefreshment;


    FirestoreService fsService = FirestoreService();
    fsService.editBookingMeetingRoom(id, location, bkandLevel, facilities_type, dateSlot, timeSlot
        ,Room_number,Room_size,User_request,Email,tickBox_smartTv,tickBox_Whiteboard,tickBox_Wifi,tickBox_digitalAvSolution
        ,tickBox_officeSupplies,tickBox_accessToRefreshment);

    Navigator.push(context, new MaterialPageRoute(builder: (context) =>  new MyApp())); // return back to homepage
  }//edit functions to firebase

  void add_ons_checkBox(){

    smartTv = smartTv;
    whiteBoard = whiteBoard;
    Wifi = Wifi;
    digitalAvSolution = digitalAvSolution;
    officeSupplies = officeSupplies;
    accesstoRefreshment = accesstoRefreshment;

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
                      title: Text('Smart_Tv'),
                      subtitle: Text('items examples'),
                      //tileColor: Colors.lightBlueAccent,
                      value: smartTv,
                      onChanged: (value) {
                        setState(() {
                          smartTv = value!;
                        });
                      },
                      activeColor: Colors.lightBlueAccent,
                      checkColor: Colors.redAccent,
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('Whitebaord'),
                      subtitle: Text('items examples'),
                      //tileColor: Colors.lightBlueAccent,
                      value: whiteBoard,
                      onChanged: (value) {
                        setState(() {
                          whiteBoard = value!;
                        });
                      },
                      activeColor: Colors.lightBlueAccent,
                      checkColor: Colors.redAccent,
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('Wifi'),
                      subtitle: Text('items examples'),
                      //tileColor: Colors.lightBlueAccent,
                      value: Wifi,
                      onChanged: (value) {
                        setState(() {
                          Wifi = value!;
                        });
                      },
                      activeColor: Colors.lightBlueAccent,
                      checkColor: Colors.redAccent,
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('Digital Av Solution'),
                      subtitle: Text('items examples'),
                      //tileColor: Colors.lightBlueAccent,
                      value: digitalAvSolution,
                      onChanged: (value) {
                        setState(() {
                          digitalAvSolution = value!;
                        });
                      },
                      activeColor: Colors.lightBlueAccent,
                      checkColor: Colors.redAccent,
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('Offices Supplies'),
                      subtitle: Text('items examples'),
                      //tileColor: Colors.lightBlueAccent,
                      value: officeSupplies,
                      onChanged: (bool? value) {
                        setState(() {
                          officeSupplies = value!;
                        });
                      },
                      activeColor: Colors.lightBlueAccent,
                      checkColor: Colors.redAccent,
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('Access To Refreshment'),
                      subtitle: Text('items examples'),
                      //tileColor: Colors.lightBlueAccent,
                      value: accesstoRefreshment,
                      onChanged: (bool? value) {
                        setState(() {
                          accesstoRefreshment = value!;
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

  Widget add_ons_and_office_Button(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                add_ons_checkBox();
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent
              ),
              child: Row(
                children:[
                  Text('Add-Ons'),
                  Icon(Icons.add_circle_rounded)
                ],
              )
          ),
        ]
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

  Widget Datepicking(){
    return Container(
        height: 145,
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF558D81),
                  Color(0xFF3A9C9E)
                ]
            )
        ),
        child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Swipe',style: TextStyle(fontSize: 20, color: Colors.white)),
                  Icon(Icons.arrow_forward, color:Colors.white,)
                ],
              ),
              DatePickerTimeline(_selectedValue, onDateChange: (date) {
                setState(() {
                  _selectedValue = date;
                  fomattedDate = DateFormat.yMMMEd().format(_selectedValue);
                  dateselected_change  = fomattedDate;
                });
              }, key: null, )
            ]
        ));
  }

  Widget display_selected_time_and_sort(){
    return Container(
      height: 140,
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width:double.infinity,
            padding:EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.cyan
            ),
            child: Text('Date Slot change to : ${dateselected_change} ',
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white)
            ),
          ),
          Container(
            width:double.infinity,
            padding:EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.cyan
            ),
            child: Text('TimeSlot change to : ${timeSlot_change}' ,
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white)
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

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

    Widget timePicker(){
      return Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end:  Alignment.bottomRight,
              colors: [
                Color(0xFF1BBFA3),
                Color(0xFF11ADB8),
              ]
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                ),
              ),
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


    return Scaffold(
            appBar: AppBar(
              title: Text(widget.selected.location),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end:  Alignment.bottomRight,
                      colors: [
                        Color(0xFF135A4F),
                        Color(0xFF174A63),
                      ]
                  ),
                ),
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end:  Alignment.bottomRight,
                    colors: [
                      Color(0xFF1BBFA3),
                      Color(0xFF11ADB8),
                    ]
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                     margin: EdgeInsets.all(10),
                     height: 180,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.only(
                             bottomRight: Radius.circular(10),
                             bottomLeft: Radius.circular(10)
                         ),
                       gradient: LinearGradient(
                           begin: Alignment.topLeft,
                           end:  Alignment.bottomRight,
                           colors: [
                             Color(0xFF1C5A52),
                             Color(0xFF2C898E),
                           ]
                       ),
                     ),
                      child:Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.selected.location,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.white)),
                          SizedBox(height: 10),
                          Text('Booking Date: ' + widget.selected.dateSlot, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.white70)),
                          SizedBox(height: 5),
                          Text('Booking Time: ' + widget.selected.timeSlot, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.white70)),
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.deepOrangeAccent,
                            ),
                            child: Text(widget.selected.facilities_type, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Datepicking(),
                    SizedBox(height: 20),
                    Text('Change time', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.left,),
                    timePicker(),
                    SizedBox(height: 20),
                    Text('Change Add-ons and Equipment',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.left,),

                    add_ons_and_office_Button(),

                    display_selected_time_and_sort(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        editButton()
                      ],
                    )
                  ],

                )
              ),
            ),

          );
        }
}
