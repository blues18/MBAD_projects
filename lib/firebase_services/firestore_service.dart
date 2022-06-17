import 'package:cloud_firestore/cloud_firestore.dart';

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
    return FirebaseFirestore.instance.collection('fitness_booking')
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
}