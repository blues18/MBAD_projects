import 'package:flutter/material.dart';

import '../models/class_bookingItem_for_provider.dart';

class allBookings with ChangeNotifier{
  List<bookingItem> myBookings = [];

  List<bookingItem> getBooking() {
    return myBookings;
  }

  void addBooking(location, bkandlevel, opening_hours, facilities_type, dateslot, timeslot){
    myBookings.insert(0, bookingItem(location:location, bkandLevel:bkandlevel, opening_Hour:opening_hours,
    facilities_type:facilities_type, dateSlot:dateslot, timeSlot:timeslot,));
    notifyListeners();
  }

  void removedBooking(i) {
    myBookings.removeAt(i);
    notifyListeners();
  }


}