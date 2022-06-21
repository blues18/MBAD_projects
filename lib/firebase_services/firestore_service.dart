import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facilitiesbookingapp/models/Class_Favourite_location.dart';
import 'package:facilitiesbookingapp/models/class_bookingItem_firebase.dart';
import 'package:facilitiesbookingapp/models/facilities_Detail(firebase).dart';

class FirestoreService {

  ///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////// Facilities Location ///////////////////////

  Stream<List<Facilities_Details>> getDetailsOfFacilities(){
    return FirebaseFirestore.instance
        .collection('Facilities Location and Details')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs
            .map<Facilities_Details>((doc)=>
            Facilities_Details.formMap(doc.data(), doc.id))
            .toList());
  }
///////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////Gym CRUD /////////////////////////////////////////

  addBookingTofirebase(location, bkandlevel, facilites_type, dateslot,
      timeSlot) {
    return FirebaseFirestore.instance
        .collection('fitness_booking')
        .add({
      'location': location,
      'bkandLevel': bkandlevel,
      //'opening_hours':opening_hours,
      'facilities_type': facilites_type,
      'dateSlot': dateslot,
      'timeSlot': timeSlot,
    });
  }

  removedBookingSlot(id) {
    return FirebaseFirestore.instance
        .collection('fitness_booking')
        .doc(id)
        .delete();
  }

  Stream<List<bookingItem>> getBookingTicketGym() {
    return FirebaseFirestore.instance
        .collection('fitness_booking')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map<bookingItem>((doc) =>
            bookingItem.fromMap(doc.data(), doc.id))
            .toList());
  }

  /////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////Swimming CRD////////////////////////////
  addBookingToFirebase_Swimming(location, bkandLevel, facilities_type, dateSlot, timeSlot){
    return FirebaseFirestore.instance
        .collection('Swimming Collection')
        .add({
      'Location': location,
      'Block and Level': bkandLevel,
      'facilities_type': facilities_type,
      'dateSlot': dateSlot,
      'timeSlot': timeSlot,
    });
  }
  removedBookingSlotSwimming(id) {
    return FirebaseFirestore.instance
        .collection('Swimming Collection')
        .doc(id)
        .delete();
  }

  Stream<List<bookingSwim>> getSwimmingBookingItem(){
    return FirebaseFirestore.instance
        .collection('Swimming Collection')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map<bookingSwim>((doc)=>
        bookingSwim.fromMap(doc.data(), doc.id))
        .toList());
  }



  //favourite locations///////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////
  addtofavourite(location, opening_hours, bkandLevel, facilities_type) {
    //facilities location favourite
    return FirebaseFirestore.instance.collection('favourite')
        .add({
      'Location': location,
      'Opening_hour': opening_hours,
      'Block and Level': bkandLevel,
      'Facilities_Type': facilities_type,
    });
  }

  removedFavouriteListItem(id) {
    return FirebaseFirestore.instance
        .collection('favourite')
        .doc(id)
        .delete();
  }

  Stream<List<favourite_Location>> getFavouritelocation() {
    return FirebaseFirestore.instance
        .collection('favourite')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs
            .map<favourite_Location>((doc) =>
            favourite_Location.fromMap(doc.data(), doc.id))
            .toList());
  }
}

