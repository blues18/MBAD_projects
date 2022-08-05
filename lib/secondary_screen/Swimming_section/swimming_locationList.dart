
import 'package:facilitiesbookingapp/firebase_services/firestore_service.dart';
import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Detail(firebase).dart';
import 'package:facilitiesbookingapp/secondary_screen/Swimming_section/SwimmingBooking_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:facilitiesbookingapp/searchfunctions/search_function.dart';
import 'package:facilitiesbookingapp/secondary_screen/Swimming_section/swimming_locationList.dart';

import 'displaySwimmingList.dart';

class swimming_location_screen extends StatefulWidget {
  static String routeName = '/swimming_Location_Screen';


  @override
  State<swimming_location_screen> createState() =>
      _swimming_location_screenState();
}



class _swimming_location_screenState extends State<swimming_location_screen> {
  TextEditingController searchController = TextEditingController();
  bool isDescending = false;


  @override
  Widget build(BuildContext context) {

    search_function storeListfirst = Provider.of<search_function>(context);

    Widget searchfield(){
      return TextField(
        controller: searchController,
        onChanged: (value){
          setState((){
            storeListfirst.searchQuery = value.toLowerCase(); //Calls the searchString in movieshowList
          });
        },
        decoration: InputDecoration(
          hintText: "Search",
          suffixIcon: Icon(Icons.search),
        ),
      );
    }


    Widget displaytest(){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 600,
                child: display_SearchResults(
                  storeListfirst.getSearchResults(), searchController: searchController,
                ),
            )
          ],
        ),
      );
    }



    Widget displayFacilitiesLocation() {
      FirestoreService fsService = FirestoreService();
      return StreamBuilder<List<Facilities_Details>>(
          stream: fsService.getDetailsOfFacilities_Swimming(), //need to change!
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            else {
              return Visibility(
                visible: true,
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (ctx, i) {
                      final sortItems = isDescending ? snapshot.data!.reversed.toList() : snapshot.data!;
                      final item = sortItems[i];
                      return Card(
                        color: Colors.lightBlue,
                        borderOnForeground: true,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          splashColor: Colors.red.withAlpha(40),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => swimmingBookingScreen(
                                      selected: item))), //passing data to the screen class
                          child: Column(
                              children: [
                                Container(
                                    width: 400,
                                    height: 100,
                                    margin: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 100,
                                          //color: Colors.white,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(item.location,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.left),
                                              Text(
                                                  item.block_And_Level,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.left),
                                              Text(
                                                  "Opening Hours: " +
                                                      item.Opening_Hour,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.left)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: 100,
                                          child:Image.network(
                                            item.Url_image,
                                            height: 150,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    )),
                              ]),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, i) {
                      return Divider(
                        height: 3,
                        color: Colors.blueGrey,
                      );
                    },
                    itemCount: snapshot.data!.length),
              );
            }
          });
    }

    Widget SortbyAlphabetically() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          searchfield(),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green
            ),
            child: TextButton.icon(
              icon: const RotatedBox(
                quarterTurns: 1,
                child: Icon(Icons.compare_arrows, size: 28),
              ),
              label: Text(isDescending ? 'Descending By Alphabetically ' : 'Ascending By Alphabetically ',
                  style: TextStyle(fontSize: 20, color: Colors.white)
              ),
              onPressed: () => setState(()
              => isDescending = !isDescending
              ),
            ),
          ),
          Expanded(child: displaytest())
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Swimming Pool'),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          searchfield(),
          Stack(
            children:[
              displaytest()
            ],
          )
        ],
      )
    );
  }
}


