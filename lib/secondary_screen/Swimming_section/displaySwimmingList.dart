import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Detail(firebase).dart';
import 'package:facilitiesbookingapp/searchfunctions/search_function.dart';
import 'package:facilitiesbookingapp/secondary_screen/Swimming_section/SwimmingBooking_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class display_SearchResults extends StatelessWidget {
  display_SearchResults(this.storeListfirst, {Key? key, required this.searchController}) : super(key: key);
  List<Facilities_Details> storeListfirst;
  final TextEditingController searchController;
  bool isDescending = false;


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
            onPressed: () {
                 isDescending = !isDescending;
              }
            ),
          ),
        Expanded(child: GetAlldsiplayCard())
      ],
    );
  }

  Widget GetAlldsiplayCard(){
    return Consumer(
        builder: (context, search_function provider, Widget? child){
          if (searchController.text.isEmpty){
            storeListfirst = provider.storeSwimmingLocationList;
          } else {
            storeListfirst = provider.storeSwimmingLocationList.where((element) =>
                element.location.toLowerCase().contains(searchController.text.toLowerCase())).toList();
          }
          return ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              itemBuilder: (ctx, i) {
                final sortItems = isDescending ? storeListfirst.reversed.toList() : storeListfirst;
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
              itemCount: storeListfirst.length);
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return SortbyAlphabetically();
  }
}
