import 'package:cloud_firestore/cloud_firestore.dart';
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////Class for Gym//////////////////////////

class bookingItem {
  String id;
  String location;
  String bkandLevel;
  String facilities_type;
  String dateSlot;
  String timeSlot;
  String email; // when user sign in it display the booking according to his/her email

  bookingItem(
      {required this.id, required this.location, required this.bkandLevel,
        required this.facilities_type, required this.dateSlot, required this.timeSlot, required this.email});

  bookingItem.fromMap(Map <String, dynamic> snapshot,String id) :
        id = id,
  location = snapshot['location'] ?? '',
  bkandLevel = snapshot['bkandLevel']??'',
  facilities_type = snapshot['facilities_type']??'',
  dateSlot = snapshot['dateSlot']??'',
  timeSlot = snapshot['timeSlot']??'',
  email = snapshot['Email']??''
;}
////////////////////////////////////////////////////////////////////////////////
///////////////////////////Class for Swimming////////////////////////////////////

class bookingSwim {
  String id;
  String location;
  String bkandLevel;
  String facilities_type;
  String dateSlot;
  String timeSlot;
  String email;

  bookingSwim(
  {required this.id, required this.location, required this.bkandLevel, required this.facilities_type,
  required this.timeSlot, required this.dateSlot, required this.email});

  bookingSwim.fromMap(Map <String, dynamic> snapshot, String id):
  id = id,
  location = snapshot['Location']??'',
  bkandLevel = snapshot['Block and Level']??'',
  facilities_type = snapshot['facilities_type']??'',
  dateSlot = snapshot['dateSlot']??'',
  timeSlot = snapshot['timeSlot']??'',
  email = snapshot['Email']??''
;}

////////////////////////////////////////////////////////////////////////////////
/////////////////////////Class for meeting /////////////////////////////////////
class bookingMeetingRoom {
  String id;
  String location;
  String bkandLevel;
  String facilities_type;
  String dateSlot;
  String timeSlot;
  String Room_Number;
  String Room_Size;
  String email;
  bool smart_tv;
  bool whiteboard;
  bool wifi;
  bool digitalAvSolution;
  bool officeSupplies;
  bool accessToRefreshment;


  bookingMeetingRoom(
      {required this.id, required this.location, required this.bkandLevel, required this.facilities_type
        , required this.timeSlot, required this.dateSlot, required this.Room_Number,required this.Room_Size,
        required this.email, required this.smart_tv,required this.whiteboard, required this.wifi, required this.digitalAvSolution
        ,required this.officeSupplies, required this.accessToRefreshment
      });

  bookingMeetingRoom.fromMap(Map <String, dynamic> snapshot, String id):
      id = id,
        location = snapshot['Location']??'',
        bkandLevel = snapshot['Block and Level']??'',
        facilities_type = snapshot['facilities_type']??'',
        dateSlot = snapshot['dateSlot']??'',
        timeSlot = snapshot['timeSlot']??'',
        Room_Number = snapshot['Room_number']??'',
        Room_Size = snapshot['Room_size']??'',
        email = snapshot['Email']??'',
        smart_tv = snapshot['Smart_tv']??'',
        whiteboard = snapshot['Whiteboard']??'',
        wifi = snapshot['Wifi']??'',
        digitalAvSolution = snapshot['DigitalAvSolution']??'',
        officeSupplies = snapshot['OfficeSupplies']??'',
        accessToRefreshment = snapshot['AccessToRefreshment']??''
  ;}
  //////////////////////////////////////////////////////////////////////////////
///////////////////////////////MeetingRoom//////////////////////////////////////////

