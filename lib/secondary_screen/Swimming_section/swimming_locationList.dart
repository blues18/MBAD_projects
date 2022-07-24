import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facilitiesbookingapp/firebase_services/firestore_service.dart';
import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Detail(firebase).dart';
import 'package:facilitiesbookingapp/secondary_screen/Swimming_section/SwimmingBooking_screen.dart';
import 'package:flutter/material.dart';

class swimming_location_screen extends StatefulWidget {
  static String routeName = '/swimming_Location_Screen';


  @override
  State<swimming_location_screen> createState() =>
      _swimming_location_screenState();
}



class _swimming_location_screenState extends State<swimming_location_screen> {
  final controller = TextEditingController();
  bool isDescending = false;


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
            //onChanged: searchLocation,
          ),
        ),
      ],
    );
  }

  Widget SortbyAlphabetically() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          Expanded(child: displayFacilitiesLocation())
        ],
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
                                          snapshot.data![i].Url_image,
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swimming Pool'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: (){
              showSearch(
                  context: context,
                  delegate: mySearchfield(),
              );
            },
          )
        ],
      ),
      body: Stack(
        children:[
          SortbyAlphabetically(),
          //displayFacilitiesLocation()
        ],
      )
    );
  }
}

class mySearchfield extends SearchDelegate{
  FirestoreService fsService = FirestoreService();


  List<String> tests = [];

  final TestLists = FirebaseFirestore.instance
      .collection('Meetings Room Facilities')
      .doc('id')
      .collection('Location')
      .snapshots();




  Widget testingStoring() {
    return StreamBuilder<List<Facilities_Details>>(
        stream:  fsService.getDetailsOfFacilities_Swimming(),
        builder: (context, snapshot){
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx,i){
              tests.add(snapshot.data![i].location);
              //print(tests);
              return ListTile(
                title: Text(snapshot.data![i].location),
              );
            },
          );
        }
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) =>[ //icon clear
    IconButton(
        onPressed: (){
          if(query.isEmpty){
            close(context,null);
          }else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear)
    ),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton( //leading icon which is back
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_rounded)
  );

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),
      ),
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List<String> suggestions = tests.where((test){
        final result = test.toLowerCase();
        final input = query.toLowerCase();
        print(TestLists);
        return result.contains(input);
    }).toList();

    Widget displayingResults() {
      return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, i){
          final suggestion = suggestions[i];

          return ListTile(
            title: Text(suggestion),
            onTap: () {
              showResults(context);
            },
          );
        },
      );
    }







      return Stack(
        children: [
          testingStoring(),
          displayingResults(),
        ],
      );
    }
  }

