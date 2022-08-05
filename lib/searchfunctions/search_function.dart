import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Detail(firebase).dart';
import 'package:flutter/cupertino.dart';

class search_function with ChangeNotifier{

  List<Facilities_Details> storeListfirst = []; //create a list first

  List<Facilities_Details> getSearchResults(){
    return storeListfirst;
  }

  String searchQuery = '';

  List<Facilities_Details> storeSwimmingLocationList = []; //test see if can store the list

  search_function() {
    FirebaseFirestore.instance.collection('Facilities Location and Details')
        .snapshots()
        .listen((event){
      for (var change in event.docChanges) {
        Facilities_Details location = Facilities_Details.formMap(change.doc.data()!, change.doc.id);
        switch (change.type) {
          case DocumentChangeType.added:
            storeSwimmingLocationList.add(location);
            print(storeSwimmingLocationList.length);
            break;
          case DocumentChangeType.modified:
            storeSwimmingLocationList.removeWhere((element) => element.id == location.id);
            storeSwimmingLocationList.add(location);
            break;
          case DocumentChangeType.removed:
            storeSwimmingLocationList.removeWhere((element) => element.id == location.id);
            break;

        }
        notifyListeners();
      }
    });
  }

}