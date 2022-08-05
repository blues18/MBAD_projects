import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Details_For_MeetingRoom.dart';
import 'package:flutter/cupertino.dart';

class search_function_meetingRoom with ChangeNotifier{

  List<Facilities_Details_Meeting_Room> storeList = []; //create a list first

  List<Facilities_Details_Meeting_Room> getSearchResults(){
    return storeList;
  }

  String searchQuery = '';

  List<Facilities_Details_Meeting_Room> storeMeetingRoomLocationList = []; //test see if can store the list

  search_function_meetingRoom() {
    FirebaseFirestore.instance.collection('Meeting Room Facilities Data')
        .snapshots()
        .listen((event){
      for (var change in event.docChanges) {
        Facilities_Details_Meeting_Room location = Facilities_Details_Meeting_Room.fromMap(change.doc.data()!, change.doc.id);
        switch (change.type) {
          case DocumentChangeType.added:
            storeMeetingRoomLocationList.add(location);
            print(storeMeetingRoomLocationList.length);
            break;
          case DocumentChangeType.modified:
            storeMeetingRoomLocationList.removeWhere((element) => element.id == location.id);
            storeMeetingRoomLocationList.add(location);
            break;
          case DocumentChangeType.removed:
            storeMeetingRoomLocationList.removeWhere((element) => element.id == location.id);
            break;

        }
        notifyListeners();
      }
    });
  }

}