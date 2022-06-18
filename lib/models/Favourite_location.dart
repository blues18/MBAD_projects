import 'package:cloud_firestore/cloud_firestore.dart';

class favourite_Location{
  String id;
  String favourite_location;
  String favourite_bkandlevel;
  int favourite_opening_hours;

  favourite_Location({
    required this.id, required this.favourite_location, required this.favourite_bkandlevel,
    required this.favourite_opening_hours});

  favourite_Location.fromMap(Map <String, dynamic> snapshot, String id):
      id = id,
      favourite_location= snapshot['location'] ?? '',
      favourite_bkandlevel = snapshot['Block and level'] ?? '',
      favourite_opening_hours = (snapshot['opening_hour']?? Timestamp.now() as
  Timestamp).toDate();
}