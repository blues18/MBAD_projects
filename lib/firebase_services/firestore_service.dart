import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Detail(firebase).dart';
import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Details_For_MeetingRoom.dart';
import 'package:facilitiesbookingapp/models/individual%20category%20Class%20Booking/Class_Favourite_location.dart';
import 'package:facilitiesbookingapp/models/individual%20category%20Class%20Booking/Class_bookingItems.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreService {
  ///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////// Facilities Location ///////////////////////

///////////////////////////////homepage Event image display//////////////////
Stream<List<eventurldisplay>> getEventImage(){
 return FirebaseFirestore.instance
     .collection('Event_Images')
     .snapshots()
     .map((snapshot) => snapshot.docs
     .map<eventurldisplay>(
         (doc) => eventurldisplay.formMap(doc.data(), doc.id)).toList());
}

///////////////////////////Swimming Complex ////////////////////////////////////
  Stream<List<Facilities_Details>> getDetailsOfFacilities_Swimming() {
    return FirebaseFirestore.instance
        .collection('Facilities Location and Details')
        .orderBy('Location', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<Facilities_Details>(
                (doc) => Facilities_Details.formMap(doc.data(), doc.id))
            .toList());
  }



  /////////////////////////////////////////////////////////////////////////////
  ////////////////////////////New_meeting_Room class////////////////////////////////

Stream<List<Facilities_Details_Meeting_Room>> getDetailsOfFacilities_MeetingRooms(){
  return FirebaseFirestore.instance
      .collection('Meeting Room Facilities Data')
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map<Facilities_Details_Meeting_Room>(
          (doc) => Facilities_Details_Meeting_Room.fromMap(doc.data(), doc.id))
      .toList());
}


///////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////Gym CRUD /////////////////////////////////////////

  addBookingTofirebase(
      location, bkandlevel, facilites_type, dateslot, timeSlot,email) {
    return FirebaseFirestore.instance.collection('fitness_Booking_Collection').add({
      'location': location,
      'bkandLevel': bkandlevel,
      'facilities_type': facilites_type,
      'dateSlot': dateslot,
      'timeSlot': timeSlot,
      'Email': email,
    });
  }

  removedBookingSlot(id) {
    return FirebaseFirestore.instance
        .collection('fitness_Booking_Collection')
        .doc(id)
        .delete();
  }

  Stream<List<bookingItem>> getBookingTicketGym() {
    return FirebaseFirestore.instance
        .collection('fitness_Booking_Collection').where('Email',isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<bookingItem>((doc) => bookingItem.fromMap(doc.data(), doc.id))
            .toList());
  }

  /////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////Swimming CRD////////////////////////////
  addBookingToFirebase_Swimming(
      location, bkandLevel, facilities_type, dateSlot, timeSlot, email) {
    return FirebaseFirestore.instance.collection('Swimming_Booking_Collection').add({
      'Location': location,
      'Block and Level': bkandLevel,
      'facilities_type': facilities_type,
      'dateSlot': dateSlot,
      'timeSlot': timeSlot,
      'Email':email,
    });
  }

  removedBookingSlotSwimming(id) {
    return FirebaseFirestore.instance
        .collection('Swimming_Booking_Collection')
        .doc(id)
        .delete();
  }

  Stream<List<bookingSwim>> getSwimmingBookingItem() {
    return FirebaseFirestore.instance
        .collection('Swimming_Booking_Collection').where('Email',isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<bookingSwim>((doc) => bookingSwim.fromMap(doc.data(), doc.id))
            .toList());
  }

  ////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////Meeting Room CRD/////////////////////////////////

  addBookingToFirebase_MeetingRoom(
      location, bkandLevel, facilities_type, dateSlot, timeSlot, Room_Number, Room_Size, email,
      smart_tv, whiteboard, wifi, digitalAvSolution, officeSupplies, accessToRefreshment) {
    return FirebaseFirestore.instance.collection('MeetingRoom_Booking_Collection').add({
      'Location': location,
      'Block and Level': bkandLevel,
      'facilities_type': facilities_type,
      'dateSlot': dateSlot,
      'timeSlot': timeSlot,
      'Room_number':Room_Number,
      'Room_size': Room_Size,
      'Email': email,
      'Smart_tv': smart_tv,
      'Whiteboard':whiteboard,
      'Wifi':wifi,
      'DigitalAvSolution':digitalAvSolution,
      'OfficeSupplies':officeSupplies,
      'AccessToRefreshment':accessToRefreshment,
    });
  }

  removedBookingSlotMeetingRoom(id) {
    return FirebaseFirestore.instance
        .collection('MeetingRoom_Booking_Collection')
        .doc(id)
        .delete();
  }

  Stream<List<bookingMeetingRoom>> getMeetingRoomBookingItem() {
    return FirebaseFirestore.instance
        .collection('MeetingRoom_Booking_Collection').where('Email',isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<bookingMeetingRoom>(
                (doc) => bookingMeetingRoom.fromMap(doc.data(), doc.id))
            .toList());
  }

  editBookingMeetingRoom(
      id, location, bkandLevel, facilities_type, dateSlot, timeSlot, Room_Number, Room_Size, email,
      smart_tv, whiteboard, wifi, digitalAvSolution, officeSupplies, accessToRefreshment) {
    return FirebaseFirestore.instance
        .collection('MeetingRoom_Booking_Collection')
        .doc(id)
        .set({
      'Location': location,
      'Block and Level': bkandLevel,
      'facilities_type': facilities_type,
      'dateSlot': dateSlot,
      'timeSlot': timeSlot,
      'Room_number':Room_Number,
      'Room_size': Room_Size,
      'Email': email,
      'Smart_tv': smart_tv,
      'Whiteboard':whiteboard,
      'Wifi':wifi,
      'DigitalAvSolution':digitalAvSolution,
      'OfficeSupplies':officeSupplies,
      'AccessToRefreshment':accessToRefreshment,
    });
  }

  //favourite locations///////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////
  addtofavourite(location, opening_hours, bkandLevel, facilities_type, email) {
    //facilities location favourite
    return FirebaseFirestore.instance
        .collection('Favourite_gym_Facilities_Location')
        .add({
      'Location': location,
      'Opening_hour': opening_hours,
      'Block and Level': bkandLevel,
      'Facilities_Type': facilities_type,
      'Email': email,
    });
  }

  removedFavouriteListItem(id) {
    return FirebaseFirestore.instance
        .collection('Favourite_gym_Facilities_Location')
        .doc(id)
        .delete();
  }

  Stream<List<favourite_Location>> getFavouritelocation() {
    return FirebaseFirestore.instance
        .collection('Favourite_gym_Facilities_Location').where('Email',isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<favourite_Location>(
                (doc) => favourite_Location.fromMap(doc.data(), doc.id))
            .toList());
  }

  //////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////Swimming Favourite collection///////////////////

  addtoSwimmingFavourite(location, opening_hours, bkandLevel, facilities_type, email) {
    //facilities location favourite
    return FirebaseFirestore.instance
        .collection('Favourite_swimming_Facilities_Location')
        .add({
      'Location': location,
      'Opening_hour': opening_hours,
      'Block and Level': bkandLevel,
      'Facilities_Type': facilities_type,
      'Email': email,
    });
  }

  removedFavouriteSwimmingItem(id) {
    return FirebaseFirestore.instance
        .collection('Favourite_swimming_Facilities_Location')
        .doc(id)
        .delete();
  }

  Stream<List<favourite_Location>>
      getFavouriteLocation_form_Swimming_Collection() {
    return FirebaseFirestore.instance
        .collection('Favourite_swimming_Facilities_Location').where('Email',isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<favourite_Location>(
                (doc) => favourite_Location.fromMap(doc.data(), doc.id))
            .toList());
  }

//////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////MeetingRoom Favourite Collection///////////////

  addtoMeetingRoomFavourite(
      location, opening_hours, bkandLevel, facilities_type, email) {
    //facilities location favourite
    return FirebaseFirestore.instance
        .collection('Favourite_MeetingRoom_Facilities_Location')
        .add({
      'Location': location,
      'Opening_hour': opening_hours,
      'Block and Level': bkandLevel,
      'Facilities_Type': facilities_type,
      'Email':email
    });
  }

  removedFavouriteMeetingRoomItem(id) {
    return FirebaseFirestore.instance
        .collection('Favourite_MeetingRoom_Facilities_Location')
        .doc(id)
        .delete();
  }

  Stream<List<favourite_Location>>
      getFavouriteLocation_from_MeetingRoom_Collection() {
    return FirebaseFirestore.instance
        .collection('Favourite_MeetingRoom_Facilities_Location').where('Email',isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<favourite_Location>(
                (doc) => favourite_Location.fromMap(doc.data(), doc.id))
            .toList());
  }
}
