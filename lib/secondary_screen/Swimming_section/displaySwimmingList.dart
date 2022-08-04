import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Detail(firebase).dart';
import 'package:facilitiesbookingapp/searchfunctions/search_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class displaySearchData extends StatefulWidget {
  displaySearchData(this.storeList, {Key? key, required this.searchController}) : super(key: key);
  List<Facilities_Details> storeList;
  final TextEditingController searchController;


  @override
  State<displaySearchData> createState() => _displaySearchDataState();
}

class _displaySearchDataState extends State<displaySearchData> {

  @override
  Widget build(BuildContext context) {
    return Container(
      /*
        child: Consumer(
        builder: (context, search_function provider, Widget? child) {
          if (searchController.text.isEmpty){
            storeList = provider.storeSwimmingLocationList;
          } else {
            storeList = provider.storeSwimmingLocationList.where((element) =>
                element.location.toLowerCase().contains(searchController.text.toLowerCase())).toList();
          }
          return Container(
            margin: EdgeInsets.only(top: 30),
            child:ListView.separated(
                itemBuilder: itemBuilder,
                separatorBuilder: separatorBuilder,
                itemCount: storeList.length)
          );
        }
      )

       */
    );
  }
}
