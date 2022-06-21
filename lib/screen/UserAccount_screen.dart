import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/deleteButtonAlert.dart';

class userAccount_Screen extends StatefulWidget {

  @override
  State<userAccount_Screen> createState() => _userAccount_ScreenState();
}

class _userAccount_ScreenState extends State<userAccount_Screen> {
  var form = GlobalKey<FormState>();

  String? name;
  int? mobileNumber;
  String? email;
  String? password;

  void updateProfile() {
    bool isValid = form.currentState!.validate();

    if(isValid) {
      form.currentState!.save();
      print(name);
      print(mobileNumber);
      print(email);
      print(password);
    }
  }


  Widget _Formfield(){
    return Column(
     mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: TextFormField(
            style: TextStyle(color:Colors.black),
            decoration: InputDecoration(
              counterStyle: TextStyle(color: Colors.black),
              focusColor: Colors.black,
              icon: Icon(Icons.person),
              hintText: 'Name',
              hintStyle: TextStyle(
                  color: Colors.black,fontWeight: FontWeight.bold
              ),
            ),
            validator: (value){
              if(value == null) {
                return 'please Enter your name';
              }else if(value.length < 1){
                return 'please Enter your name';
              } else
                return null;
            },
            onChanged: (value) {name = value;},
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: TextFormField(
            style: TextStyle(color:Colors.black),
            decoration: InputDecoration(
              counterStyle: TextStyle(color: Colors.black),
              focusColor: Colors.black,
              icon: Icon(Icons.phone_android_rounded),
              hintText: 'Mobile No',
              hintStyle: TextStyle(
                  color: Colors.black,fontWeight: FontWeight.bold
              ),
            ),
            keyboardType: TextInputType.number,
            validator: (value){
              if(value == null) {
                return 'Enter your mobile number';
              } else if(value.length < 7) {
               return 'please enter a singapore number';
             } else
               return null;
            },
            onChanged: (value) {mobileNumber = int.parse(value);},
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: TextFormField(
            style: TextStyle(color:Colors.black),
            decoration: InputDecoration(
              counterStyle: TextStyle(color: Colors.black),
              focusColor: Colors.black,
              icon: Icon(Icons.email),
              hintText: 'Email',
              hintStyle: TextStyle(
                color: Colors.black,fontWeight: FontWeight.bold
              ),
            ),
            onChanged: (value) {email = value;},
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: TextFormField(
            style: TextStyle(color:Colors.black),
            decoration: InputDecoration(
              counterStyle: TextStyle(color: Colors.black),
              focusColor: Colors.black,
              icon: Icon(Icons.email),
              hintText: 'Password',
              hintStyle: TextStyle(
                  color: Colors.black,fontWeight: FontWeight.bold
              ),
            ),
            validator: (value) {
              if(value == null){
                return "change to another password";
              }
              else if (value.length < 10){
                return "Please Enter a longer password more then 10 characters";
              }
              else
                return null;
            },
            onChanged: (value) {password = value;},
          ),
        ),

        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 55,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(90,20, 20, 20),
                        blurRadius: 20,
                        offset: Offset(6,6),
                      )
                    ]
                ),
                child:RaisedButton(color:Color(0xfff6f6f6)
                  ,onPressed: (){updateProfile();},
                  child: Text('Update',style: TextStyle(color: Colors.black),
                  ),
                )
            ),
            deleteAlertButton(),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.green,
      body:Stack(
        children: [
          Container(
            color: Color(0xfff6f6f6),
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 250,
              left: 20,
              right: 20,
            ),
              child: SingleChildScrollView(
                  child:Container(
                    child: Form(
                      key: form,
                      child: _Formfield(),
                    ),
                )
              ),
          ),
          Container(
            height: 180,
            color: Colors.white,
          ),
          Container(
            width: double.infinity,
            height: 190,
            margin: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: Color(0xfff6f6f6),
              borderRadius: BorderRadius.circular(10),
              boxShadow:const [
                BoxShadow(
                  color: Color.fromARGB(90, 20, 20, 20),
                  blurRadius: 0.8,
                  offset: Offset(9,9),
                )
              ]
            ),
            child: Column(
              children: [
                SizedBox(height: 4),
                Text('Name',style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
                SizedBox(height: 10),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 45,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 50,
                    //backgroundImage: ,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
