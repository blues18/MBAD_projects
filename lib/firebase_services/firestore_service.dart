import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facilitiesbookingapp/models/Favourite_location.dart';
import '../models/booking_class_for_gym.dart';

class FirestoreService {

  addbookingSlot(location, opening_hours, bkandlevel, timeslot, dateslot) {
    return FirebaseFirestore.instance.collection('fitness_booking')
        .add({'location':location,'opening_hours':opening_hours,'bkandlevel':bkandlevel,
    'timeSlot':timeslot,'dateSlot':dateslot});
  }

  removedBookingSlot(id){
    return FirebaseFirestore.instance
        .collection('fitness_booking')
        .doc(id)
        .delete();
  }

  Stream<List<bookingGym>> getGymBooking() {
    return FirebaseFirestore.instance
        .collection('fitness_booking')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map<bookingGym>((doc) => bookingGym.fromMap(doc.data(),doc.id))
        .toList());
  }

  editbookingSlot(id, location, opening_hours, bkandlevel, timeslot, dateslot){
    return FirebaseFirestore.instance
        .collection('fitness_booking')
        .doc(id)
        .set({'location':location,'opening_hours':opening_hours,'bkandlevel':bkandlevel, 'timeslot':timeslot, 'dateslot':dateslot});
  }

  //favourite locations

  addtofavourite(location, opening_hours, bkandlevel){ //facilities location favourite
    return FirebaseFirestore.instance.collection('favourite')
        .add({'location': location,'opening_hour': opening_hours, 'Block and Level':bkandlevel});
  }

  Stream<List<favourite_Location>> getfavouritelocation() {
    return FirebaseFirestore.instance
        .collection('favourite')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map<favourite_Location>((doc) => favourite_Location.fromMap(doc.data(), doc.id))
        .toList());
  }

  //Stream<List<facilities_location_and_details>> getFacilities(){
    //return FirebaseFirestore.instance
      //  .collection('Facilities_location')
      //  .snapshots()
      //  .map((snapshot) => snapshot.docs
      //  .map<facilities_location_and_details>((doc) => facilities_location_and_details.fromMap(doc.data(),doc.id))
      //  .toList());
 // }
}

