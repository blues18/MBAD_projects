import 'dart:ui';
import 'package:facilitiesbookingapp/DatePicker_folder/date_picker_timeline.dart';
import 'package:facilitiesbookingapp/firebase_services/firestore_service.dart';
import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Detail(firebase).dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class gymbookingScreen extends StatefulWidget {
static String routeName = '/gymBookingScreen';
final Facilities_Details selected;

gymbookingScreen({
  Key? key,
  required this.selected,
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
  final user = FirebaseAuth.instance.currentUser!;
  DateTime _selectedValue = DateTime.now();
  String fomattedDate = "";
  String dateinput = 'None';
  String Bookingtimeslot = 'None';


  String? location;
  String? opening_hours;
  String? dateSlot;
  String? bkandLevel;
  String? timeSlot;
  String? facilities_type;
  String? facilities_image;
  String? Email;

  void addtofavourite(){
    location = widget.selected.location;
    bkandLevel = widget.selected.location;
    opening_hours = widget.selected.Opening_Hour;
    facilities_type = widget.selected.Facilities_Type;
    facilities_image = widget.selected.Url_image;
    Email = user.email;

    print(location);
    print(opening_hours);
    print(bkandLevel);
    print(facilities_type);

    FirestoreService fsService = FirestoreService();
    fsService.addtofavourite(location, opening_hours,bkandLevel,facilities_type,facilities_image,Email);

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:Text('Successfully added to Favourite'))
    );
  }

  void createbooking(){
    location = widget.selected.location;
    bkandLevel = widget.selected.location;
    timeSlot = Bookingtimeslot;
    dateSlot = dateinput;
    facilities_type =widget.selected.Facilities_Type;
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
          color: Colors.deepPurpleAccent,
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
                  dateinput = fomattedDate;
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
                  backgroundColor: getColor(Colors.cyan, Colors.white),
                  overlayColor: getColor(Colors.white, Colors.teal),
              ),
              child: Text('07:00'),
              onPressed: () {
                setState(() {
                  String testlistslot1 = '07:00';
                  Bookingtimeslot =testlistslot1;
                });
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: getColor(Colors.cyan, Colors.white),
                  overlayColor: getColor(Colors.white, Colors.teal)
              ),
              child: Text('09:00'),
              onPressed: () {
                setState(() {
                  String testlistslot1 = '09:00';
                  Bookingtimeslot =testlistslot1;
                });
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: getColor(Colors.cyan, Colors.white),
                  overlayColor: getColor(Colors.white, Colors.teal)
              ),
              child: Text('11:00'),
              onPressed: () {
                setState(() {
                  String testlistslot1 = '11:00';
                  Bookingtimeslot =testlistslot1;
                });
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: getColor(Colors.cyan, Colors.white),
                  overlayColor: getColor(Colors.white, Colors.teal)
              ),
              child: Text('13:00'),
              onPressed: () {
                setState(() {
                  String testlistslot1 = '13:00';
                  Bookingtimeslot =testlistslot1;
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
                  backgroundColor: getColor(Colors.cyan, Colors.white),
                  overlayColor: getColor(Colors.white, Colors.teal)
              ),
              child: Text('15:00'),
              onPressed: () {
                setState(() {
                  String testlistslot1 = '15:00';
                  Bookingtimeslot =testlistslot1;
                });
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: getColor(Colors.cyan, Colors.white),
                  overlayColor: getColor(Colors.white, Colors.teal)
              ),
              child: Text('17:00'),
              onPressed: () {
                setState(() {
                  String testlistslot1 = '17:00';
                  Bookingtimeslot =testlistslot1;
                });
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: getColor(Colors.cyan, Colors.white),
                  overlayColor: getColor(Colors.white, Colors.teal)
              ),
              child: Text('19:00'),
              onPressed: () {
                setState(() {
                  String testlistslot1 = '19:00';
                  Bookingtimeslot =testlistslot1;
                });
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: getColor(Colors.cyan, Colors.white),
                  overlayColor: getColor(Colors.white, Colors.teal)
              ),
              child: Text('21:00'),
              onPressed: () {
                setState(() {
                  String testlistslot1 = '21:00';
                  Bookingtimeslot =testlistslot1;
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
    return Scaffold(
        backgroundColor: Colors.black87 ,
        appBar: AppBar(
          title: Text(widget.selected.location),
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
            child:SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 250,
                              margin: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ), // Image border
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(48), // Image radius
                                  child: Image.network(widget.selected.Url_image, fit: BoxFit.cover),
                                ),
                              )
                          ),
                          Container(
                              height: 130,
                              margin: EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              //margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end:  Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF1C5A52),
                                        Color(0xFF2C898E),
                                      ]
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.selected.location, style: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),),
                                  SizedBox(height: 10),
                                  Text(widget.selected.block_And_Level,
                                      style: TextStyle(fontSize: 18, color: Colors.white)),
                                  SizedBox(height: 10),
                                  Text('Opening Hours: '+ widget.selected.Opening_Hour,
                                      style: TextStyle(fontSize: 18, color: Colors.white)),
                                ],
                              )
                          ),
                          //horizontal_date_picker(),
                          Datepicking(),
                          SizedBox(height: 10),
                          timeSlotButton(),
                          SizedBox(height: 30,),
                          Container(
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
                                  child: Text('Date Selected: ' + dateinput,
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
                                  child: Text('TimeSlot Selected: ' + Bookingtimeslot,
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white)
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          cfmButton(),
                          SizedBox(height: 30),
                        ],
                      ),
                    ])
            )
        )
    );
  }
}
