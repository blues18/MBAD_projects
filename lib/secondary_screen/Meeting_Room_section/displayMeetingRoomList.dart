import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Details_For_MeetingRoom.dart';
import 'package:facilitiesbookingapp/searchfunctions/search_function_meeting_room.dart';
import 'package:facilitiesbookingapp/secondary_screen/Meeting_Room_section/MeetingRoom_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class display_MeetingRoomResults extends StatelessWidget {
  display_MeetingRoomResults(this.storeList,this.isDescending, {Key? key, required this.searchController}) : super(key: key);
  List<Facilities_Details_Meeting_Room> storeList;
  final TextEditingController searchController;

  bool isDescending = false;

  Widget GetAlldsiplayCard(){
    return Consumer(
        builder: (context, search_function_meetingRoom provider, Widget? child){
          if (searchController.text.isEmpty){
            storeList = provider.storeMeetingRoomLocationList;
          } else {
            storeList = provider.storeMeetingRoomLocationList.where((element) =>
                element.Location.toLowerCase().contains(searchController.text.toLowerCase())).toList();
          }
          return ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              itemBuilder: (ctx, i) {
                final sortItems = isDescending ? storeList.reversed.toList() : storeList;
                final item = sortItems[i];
                return InkWell(
                  splashColor: Colors.red,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MeetingRoomBookingScreen(selected: item))),
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
                              Text(item.Location, style: TextStyle(fontSize: 20, color:Colors.black)),
                              SizedBox(height: 2),
                              Text(item.Block_And_Level,style: TextStyle(fontSize: 14,color:Colors.grey)),
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
              itemCount: storeList.length);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetAlldsiplayCard();
  }
}
