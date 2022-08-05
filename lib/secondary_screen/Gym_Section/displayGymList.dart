import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Detail(firebase).dart';
import 'package:facilitiesbookingapp/searchfunctions/search_function_gym.dart';
import 'package:facilitiesbookingapp/secondary_screen/Gym_Section/gymBooking_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class display_GymResults extends StatelessWidget {
  display_GymResults(this.storeListGym,this.isDescending, {Key? key, required this.searchController}) : super(key: key);
  List<Facilities_Details> storeListGym;
  final TextEditingController searchController;

  bool isDescending = false;

  Widget GetAlldsiplayCard(){
    return Consumer(
        builder: (context, search_function_Gym provider, Widget? child){
          if (searchController.text.isEmpty){
            storeListGym = provider.storeGymLocationList;
          } else {
            storeListGym = provider.storeGymLocationList.where((element) =>
                element.location.toLowerCase().contains(searchController.text.toLowerCase())).toList();
          }
          return ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              itemBuilder: (ctx, i) {
                final sortItems = isDescending ? storeListGym.reversed.toList() : storeListGym;
                final item = sortItems[i];
                return InkWell(
                  splashColor: Colors.red,
                  //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => gymbookingScreen(selected: item))),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 260,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                color: Colors.grey
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ), // Image border
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(48), // Image radius
                                child: Image.network(item.Url_image, fit: BoxFit.cover),
                              ),
                            )
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              color: Colors.white
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.purple
                                ),
                                child: Text(item.Facilities_Type, style: TextStyle(fontSize: 16,color: Colors.white)),
                              ),
                              Text(item.location, style: TextStyle(fontSize: 20, color:Colors.black)),
                              SizedBox(height: 2),
                              Text(item.block_And_Level,style: TextStyle(fontSize: 14,color:Colors.grey)),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Icon(Icons.access_time),
                                  Text(item.Opening_Hour)
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, i) {
                return Divider(
                  height: 3,
                  color: Colors.blueGrey,
                );
              },
              itemCount: storeListGym.length);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetAlldsiplayCard();
  }
}
