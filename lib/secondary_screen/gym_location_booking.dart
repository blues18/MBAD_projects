import 'dart:ui';

import 'package:facilitiesbookingapp/models/testdata.dart';
import 'package:facilitiesbookingapp/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

//import '../models/Facilities_details.dart';
import '../models/testdata.dart';
import 'gymBooking_screen.dart';

class gym_Location_screen extends StatefulWidget {
  static String routeName = '/gymLocationScreen';

  @override
  State<gym_Location_screen> createState() => _gym_Location_screenState();
}

class _gym_Location_screenState extends State<gym_Location_screen> {
  final controller = TextEditingController();
  bool isDescending = false;

  //List<facilitiesDetail> facilitiesDetails = allfacilitiesDetail;

  List <detail> alldetails = [
    detail(place: 'Anchorvale communtiy ceneter',
        opening_hours: '07:00 - 23:00',
        location: 'Block 1 level 1 #01-112'),
    detail(place: 'Fernvale community center',
        opening_hours: '07:00 - 23:59',
        location: 'near main entrance'),
    detail(place: 'Hougang Community center',
        opening_hours: '07:00 - 23:00',
        location: 'Block 1 level 2 #02-001'),
  ];

  Widget SortbyAlphabetically() {
    return Container(
      margin: EdgeInsets.all(10),
      width: 370,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.lightGreen,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton.icon(icon: RotatedBox(
            quarterTurns: 1,
            child: Icon(Icons.compare_arrows, size: 28),
          ),
            label: Text(isDescending ? 'Descending' : 'Ascending',
                style: TextStyle(fontSize: 20)
            ),
            onPressed: () => setState(() => isDescending = !isDescending),
          ),
        ],
      ),
    );
  }

  Widget searchbar() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'search for Gym location',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.lightBlue),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 20),
            ),
            onChanged: searchLocation,
          ),
        ),
      ],
    );
  }

  void searchLocation(String query) {
    final suggestions = alldetails.where((detail) {
      final placeSearch = detail.place.toLowerCase();
      final input = query.toLowerCase();

      return placeSearch.contains(input);
    }).toList();

    setState(() => alldetails = suggestions);
  }


  Widget sortedCard() {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      itemCount: alldetails.length,
      itemBuilder: (BuildContext context,
          int index) { //in progress of creating a sort but check if can removed this part instead

        return Card(
          color: Colors.lightBlue,
          borderOnForeground: true,
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          child: InkWell(
            splashColor: Colors.red.withAlpha(40),
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context)=> gymbookingScreen(selected: alldetails[index])
                  )
                ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(alldetails[index].place,
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.black),
                                    textAlign: TextAlign.left),
                                Text(alldetails[index].location,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                    textAlign: TextAlign.left),
                                Text("Opening Hours: " +
                                    alldetails[index].opening_hours,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                    textAlign: TextAlign.left)
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                              //image: DecorationImage(
                              //image: AssetImage(),
                              //fit: BoxFit.cover,
                              // )
                            ),
                          )
                        ],
                      )
                  ),
                ]
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Gym', style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.left,),
          ],
        ),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //SortbyAlphabetically(),
              searchbar(),
              sortedCard(),
            ],
          )
      ),
    );
  }
}




