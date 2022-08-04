import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:facilitiesbookingapp/dataDisplay/MeetingRoomListBookingData.dart';
import 'package:facilitiesbookingapp/dataDisplay/SwimmingListBookingData.dart';
import 'package:facilitiesbookingapp/dataDisplay/GymListDataData.dart';
import 'package:facilitiesbookingapp/firebase_services/authentication_services.dart';
import 'package:facilitiesbookingapp/models/User_auth_model/user_model.dart';
import 'package:facilitiesbookingapp/models/facilities%20Location%20Models/facilities_Detail(firebase).dart';
import 'package:facilitiesbookingapp/secondary_screen/view_all_screen/view_all(homepage).dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../firebase_services/firestore_service.dart';

class homePage_screen extends StatefulWidget {
  static String routeName = '/homepage';


  @override
  State<homePage_screen> createState() => _homePage_screenState();
}

class _homePage_screenState extends State<homePage_screen> {
  FirestoreService fsService = FirestoreService();
  final user = FirebaseAuth.instance.currentUser!;
  String? getEmail;

  displayUsername(){
    Authentication_services authService = Authentication_services();
    return StreamBuilder<userModel>(
      stream: authService.getUserAuthenticationData(),
      builder: (context, snapshot){
        return Text('${snapshot.data?.userName}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white
          )
        );
      }
    );
  }

  displayProfilePic(){
    Authentication_services authService = Authentication_services();
    return StreamBuilder<userModel>(
        stream: authService.getUserAuthenticationData(),
        builder: (context, snapshot){
          return CircleAvatar(
              radius: 30.0,
              backgroundImage:
              NetworkImage("${snapshot.data?.imageUrl}"),
              backgroundColor: Colors.grey,
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    getEmail=user.email;
    FirestoreService fsService = FirestoreService();
    return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end:  Alignment.bottomRight,
                  colors: [
                    Color(0xFF256F62),
                    Color(0xFF337095),
               ]
              ),
            ),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 3.0
                    )
                  ),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFF094241),
                          Color(0xFF042932),
                        ]
                    )
                ),
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Text('Welcome Back',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 30,
                                color: Colors.white
                            )
                        ),
                        displayUsername()
                      ],
                    ),
                    SizedBox(height: 10,width: 40,),
                    displayProfilePic()
                  ],
                )
              ),
              SizedBox(height: 20),
              Row(
                  children: [
                    Text('Events', style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                      )
                    ),
                    Icon(Icons.event_available_rounded, color: Colors.white),
                  ]),
              Container(
                height: 150,
                width: 400,
                margin: EdgeInsets.all(10.0),
                decoration:  BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20
                    ),
                    border:Border.all(
                      width: 2,
                      color: Colors.black
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF0FACA8),
                        Color(0xFF1190AC),
                      ]
                    )
                ),
                child: StreamBuilder<List<eventurldisplay>>(
                  stream: fsService.getEventImage(),
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    else{
                      return CarouselSlider.builder(
                          itemCount: snapshot.data!.length,
                          options: CarouselOptions(
                              height: 140,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.height
                          ),
                          itemBuilder: (context, i , realIndex){
                            final url_image = snapshot.data![i].imageAsset;
                            return buildImage(url_image, i);
                          }
                      );
                    }
                  },
                )
              ),
              Row(
                  children: <Widget>[
                    Text('Your Booking', style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    ),
                    Icon(Icons.book_outlined, color: Colors.white),
                    Spacer(),
                    FlatButton(
                      onPressed: () => Navigator.of(context).pushNamed(View_all_At_homePage.routeName),

                      child: const Text(
                        'View All', style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.right,),
                    )
                  ]),
              Container(
                  height: 270,
                  width: double.infinity,
                  margin: EdgeInsets.all(10.0),
                  decoration:  BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                      border:Border.all(
                          width: 2,
                          color: Colors.black
                      ),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xFF0FACA8),
                            Color(0xFF1190AC),
                          ]
                      )
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        display_data_list(),
                        swimmingDataList(),
                        meetingRoomDataList(),
                      ],
                    )
                    ),
                  )
            ],
          ),
          ),
        );
      }
  }

  Widget buildImage(String url_image, int i){
   return Container(
     margin: EdgeInsets.symmetric(horizontal: 1),
     color: Colors.grey,
     child: Image.network(
       url_image,
       fit: BoxFit.cover,
     ),
   );
}




