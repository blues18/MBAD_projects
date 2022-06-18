import 'package:cloud_firestore/cloud_firestore.dart';

class bookingGym {
  String id;
  String location;
  String opening_hours;
  String bkandlevel;
  String timeslot;
  String datesslot;

  bookingGym(
      {required this.id, required this.location, required this.opening_hours,
        required this.bkandlevel, required this.timeslot, required this.datesslot});

  bookingGym.fromMap(Map <String, dynamic> snapshot, String id):
        id = id,
        location = snapshot['location'] ?? '',
        opening_hours = snapshot['opening_hours'] ?? '',
        bkandlevel = snapshot['bkandlevel'] ?? '',
        timeslot= snapshot['timeSlot'] ?? '',
        datesslot= (snapshot['dateSlot'] ?? Timestamp.now() as Timestamp).toDate();
}