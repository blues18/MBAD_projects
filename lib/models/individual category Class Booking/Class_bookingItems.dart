import 'package:cloud_firestore/cloud_firestore.dart';
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////Class for Gym//////////////////////////

class bookingItem {
  String id;
  String location;
  String bkandLevel;
  //String opening_Hour;
  String facilities_type;
  String dateSlot;
  String timeSlot;

  bookingItem(
      {required this.id, required this.location, required this.bkandLevel, //required this.opening_Hour,
        required this.facilities_type, required this.dateSlot, required this.timeSlot});

  bookingItem.fromMap(Map <String, dynamic> snapshot,String id) :
        id = id,
  location = snapshot['location'] ?? '',
  bkandLevel = snapshot['bkandLevel']??'',
  //opening_Hour = snapshot['opening_hours']??'',
  facilities_type = snapshot['facilities_type']??'',
  dateSlot = snapshot['dateSlot']??'',
  timeSlot = snapshot['timeSlot']??''
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

  bookingSwim(
  {required this.id, required this.location, required this.bkandLevel, required this.facilities_type,
  required this.timeSlot, required this.dateSlot});

  bookingSwim.fromMap(Map <String, dynamic> snapshot, String id):
  id = id,
  location = snapshot['Location']??'',
  bkandLevel = snapshot['Block and Level']??'',
  facilities_type = snapshot['facilities_type']??'',
  dateSlot = snapshot['dateSlot']??'',
  timeSlot = snapshot['timeSlot']??'';
}

////////////////////////////////////////////////////////////////////////////////
/////////////////////////Class for meeting /////////////////////////////////////
class bookingMeetingRoom{
  String id;
  String location;
  String bkandLevel;
  String facilities_type;
  String dateSlot;
  String timeSlot;

  bookingMeetingRoom(
  {required this.id, required this.location, required this.bkandLevel, required this.facilities_type
    , required this.timeSlot, required this.dateSlot
});

}