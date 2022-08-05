import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Detail(firebase).dart';
import 'package:flutter/cupertino.dart';

class search_function_Gym with ChangeNotifier{

  List<Facilities_Details> storeListGym = []; //create a list first

  List<Facilities_Details> getSearchResults(){
    return storeListGym;
  }

  String searchQuery = '';

  List<Facilities_Details> storeGymLocationList = []; //test see if can store the list

  search_function_Gym() {
    FirebaseFirestore.instance.collection('Facilities_gym')
        .snapshots()
        .listen((event){
      for (var change in event.docChanges) {
        Facilities_Details location = Facilities_Details.formMap(change.doc.data()!, change.doc.id);
        switch (change.type) {
          case DocumentChangeType.added:
            storeGymLocationList.add(location);
            print(storeGymLocationList.length);
            break;
          case DocumentChangeType.modified:
            storeGymLocationList.removeWhere((element) => element.id == location.id);
            storeGymLocationList.add(location);
            break;
          case DocumentChangeType.removed:
            storeGymLocationList.removeWhere((element) => element.id == location.id);
            break;

        }
        notifyListeners();
      }
    });
  }

}