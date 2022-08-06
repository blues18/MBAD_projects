import 'package:facilitiesbookingapp/DatePicker_folder/date_picker_timeline.dart';
import 'package:facilitiesbookingapp/firebase_services/firestore_service.dart';
import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Details_For_MeetingRoom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class MeetingRoomBookingScreen extends StatefulWidget {
  static String routeName = '/meetingRoom Details';
  final Facilities_Details_Meeting_Room selected; //constructor data that is passed from previous screen

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
  String dateinput_meetingRoom = 'None';
  String Bookingtimeslot_meetingRoom = 'None';
  String other_request = 'None';
  final user = FirebaseAuth.instance.currentUser!;

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

  //////////////////////////////////////////// TimePicker ///////////////////////
  Widget timePicker(){
    return Column(
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
        ],
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
                  dateinput_meetingRoom = fomattedDate;
                });
              }, key: null, )
            ]
        ));
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
        ElevatedButton(
            onPressed: () {
              Office_contacts();
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent
            ),
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
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white
      ),
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
                ),
            ),
            onChanged: (value) {other_request = value;},
          ),
        ],
      ),
    );
  }

  Widget Comfirmation_and_Favourtie_Button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FlatButton(
          onPressed: () {
            addtofavourite();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.cyan,
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.white,),
              Text('Add to Favourite', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        FlatButton(
          onPressed: () {
            createbooking();
            showMyDialog();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.orangeAccent,
          child: Row(
            children: [
              Text('Book',  style: TextStyle(color: Colors.white)),
              Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
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
    location = widget.selected.Location;
    bkandLevel = widget.selected.Block_And_Level;
    opening_hours = widget.selected.Opening_Hour;
    facilities_type = widget.selected.Facilities_Type;
    facilities_image = widget.selected.Url_image;
    Email = user.email;

    print(location);
    print(opening_hours);
    print(bkandLevel);
    print(facilities_type);

    FirestoreService fsService = FirestoreService();
    fsService.addtoMeetingRoomFavourite(location, opening_hours, bkandLevel, facilities_type,facilities_image,Email);

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:Text('Successfully added to Favourite'))
    );
  }

  void createbooking(){
    location = widget.selected.Location;
    opening_hours = widget.selected.Opening_Hour;
    bkandLevel = widget.selected.Block_And_Level;
    timeSlot = Bookingtimeslot_meetingRoom;
    dateSlot = dateinput_meetingRoom;
    facilities_type =widget.selected.Facilities_Type;
    Room_size = widget.selected.Room_Size;
    Room_number = widget.selected.Room_Number;
    User_request = other_request;
    Email= user.email;
    tickBox_smartTv = widget.selected.smart_tv;
    tickBox_Whiteboard = widget.selected.whiteboard;
    tickBox_Wifi = widget.selected.wifi;
    tickBox_digitalAvSolution = widget.selected.digitalAvSolution;
    tickBox_officeSupplies = widget.selected.officeSupplies;
    tickBox_accessToRefreshment = widget.selected.accessToRefreshment;

    print(location);
    print(bkandLevel);
    print(timeSlot);
    print(dateSlot);
    print(facilities_type);
    print(Email);

    print(tickBox_smartTv);
    print(tickBox_Whiteboard);
    print(tickBox_Wifi);
    print(tickBox_digitalAvSolution);
    print(tickBox_officeSupplies);
    print(tickBox_accessToRefreshment);


    FirestoreService fsService = FirestoreService();
    fsService.addBookingToFirebase_MeetingRoom(location, bkandLevel, facilities_type, dateSlot, timeSlot
    ,Room_number,Room_size,User_request,Email,tickBox_smartTv,tickBox_Whiteboard,tickBox_Wifi,tickBox_digitalAvSolution
    ,tickBox_officeSupplies,tickBox_accessToRefreshment);

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

    tickBox_smartTv = widget.selected.smart_tv;
    tickBox_Whiteboard = widget.selected.whiteboard;
    tickBox_Wifi = widget.selected.wifi;
    tickBox_digitalAvSolution = widget.selected.digitalAvSolution;
    tickBox_officeSupplies = widget.selected.officeSupplies;
    tickBox_accessToRefreshment = widget.selected.accessToRefreshment;

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
                      value: tickBox_smartTv,
                      onChanged: (value) {
                        setState(() {
                          tickBox_smartTv = value!;
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
                      value: tickBox_Whiteboard,
                      onChanged: (value) {
                        setState(() {
                          tickBox_Whiteboard = value!;
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
                      value: tickBox_Wifi,
                      onChanged: (value) {
                        setState(() {
                          tickBox_Wifi = value!;
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
                      value: tickBox_digitalAvSolution,
                      onChanged: (value) {
                        setState(() {
                          tickBox_accessToRefreshment = value!;
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
                      value: tickBox_officeSupplies,
                      onChanged: (bool? value) {
                        setState(() {
                          tickBox_officeSupplies = value!;
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
                      value: tickBox_accessToRefreshment,
                      onChanged: (bool? value) {
                        setState(() {
                          tickBox_accessToRefreshment = value!;
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
            child: Text('Date Selected: ' + dateinput_meetingRoom,
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
            child: Text('TimeSlot Selected: ' + Bookingtimeslot_meetingRoom,
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white)
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selected.Location),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color:Colors.black,
                    width: 2.0
                )
            ),
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
                Color(0xFF256F62),
                Color(0xFF337095),
              ]
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Stack(                  //might have to change to stack instead
               children: [
                 Container(
                   height: 200,
                   width: double.infinity,
                   margin: EdgeInsets.only(
                       left: 10,
                       right: 10
                   ), //can be top and left
                   decoration: BoxDecoration(
                     color:Colors.green
                   ),
                   child: Image.network(widget.selected.Url_image,fit: BoxFit.cover),
                 ),
               ],
              ),
              Container(
                height: 200,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(
                  left: 10,
                  right: 10
                ), //can be top and left only
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.selected.Location,style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800,color: Colors.white)),
                    SizedBox(height: 10),
                    Text('Meeting Room: '+ widget.selected.Room_Number,style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400,color: Colors.white)),
                    SizedBox(height: 4),
                    Text('Room Size: ' + widget.selected.Room_Size,style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400,color: Colors.white)),
                    SizedBox(height: 4),
                    Text('Block: ' + widget.selected.Block_And_Level,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w400,color: Colors.white)),
                    SizedBox(height: 4),
                    Text('Opening Hour:' + widget.selected.Opening_Hour,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w400,color: Colors.white)),
                  ],
                ),
              ),

              SizedBox(height: 15),
              Text('Equimpment and Items',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.left,),
              add_ons_and_office_Button(),
              SizedBox(height: 10),
              Container(
                height: 150,
                padding: EdgeInsets.all(10),
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
                    color: Colors.white
                ),
                child: Text(widget.selected.Facilities_Notice),
              ),
              SizedBox(height: 15),
              Text('Choose your Date',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.left,),
              Datepicking(),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Choose your Timing',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.left,),
                  SizedBox(width: 60),
                  timePicker(),
                ],
              ),
              display_selected_time_and_sort(),
              SizedBox(height: 10),
              TextfieldRemarks(),
              SizedBox(height: 20),
              Comfirmation_and_Favourtie_Button(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}