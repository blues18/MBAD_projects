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
        bkandlevel = snapshot['Block and level'] ?? '',
        timeslot= snapshot['timeSlot'] ?? '',
        datesslot= (snapshot['DateSlot'] ?? Timestamp.now() as Timestamp).toDate();
}