
import 'package:facilitiesbookingapp/firebase_services/authentication_services.dart';
import 'package:facilitiesbookingapp/firebase_services/firestore_service.dart';
import 'package:facilitiesbookingapp/models/User_auth_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/deleteButtonAlert.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class userAccount_Screen extends StatefulWidget {
  static String routeName ='/userAccount';

  @override
  State<userAccount_Screen> createState() => _userAccount_ScreenState();
}

class _userAccount_ScreenState extends State<userAccount_Screen> {
  final user = FirebaseAuth.instance.currentUser!;
  var form = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'SG';
  PhoneNumber number = PhoneNumber(isoCode: 'SG');

  bool isEditable = false;

  String? userName;
  String? UserPhoneNumber;
  String? email;

  void updateProfile() {
    bool isValid = form.currentState!.validate();

    if(isValid) {
      form.currentState!.save();

      email = user.email;

      print(userName);
      print(UserPhoneNumber);
      print(email);


      Authentication_services authService = Authentication_services();
      authService.UpdateUser(email, userName, UserPhoneNumber);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text('Successfully changed'))
      );
    }
  }

  Widget Profiletext(){
    Authentication_services authService = Authentication_services();
    return StreamBuilder<userModel>(
        stream: authService.getUserAuthenticationData(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else{
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    color: Colors.green,
                    splashColor: Colors.black54,
                    onPressed: (){
                      setState(() => {
                        isEditable = !isEditable
                      });
                    },
                    icon: Icon(Icons.edit_rounded)),


                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: TextFormField(
                    enabled: false,
                    style: TextStyle(color:Colors.black),
                    decoration: InputDecoration(
                      counterStyle: TextStyle(color: Colors.black),
                      focusColor: Colors.black,
                      icon: Icon(Icons.email),
                      hintText: user.email,
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
                    enabled: isEditable,
                    style: TextStyle(color:Colors.black),
                    decoration: InputDecoration(
                      counterStyle: TextStyle(color: Colors.black),
                      focusColor: Colors.black,
                      icon: Icon(Icons.person),
                      hintText: snapshot.data!.userName,
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
                    onChanged: (value) {userName = value;},
                  ),
                ),

                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {},
                  selectorConfig: SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                  ignoreBlank: false,
                  isEnabled: isEditable,
                  autoValidateMode: AutovalidateMode.disabled,
                  selectorTextStyle: TextStyle(color: Colors.black),
                  initialValue: number,
                  hintText: snapshot.data!.mobilePhone,
                  textFieldController: controller,
                  formatInput: false,
                  keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
                  inputBorder: OutlineInputBorder(),
                  validator: (value){
                    if(value == null)
                      return'Please Enter your phone Number';
                    else if (value.length < 7 || value.length > 8 )
                      return'please enter a vaild phone Number';
                    else
                      return null;
                  },
                  onSaved: (PhoneNumber value) {
                    UserPhoneNumber = value.toString();
                  },
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
                    logout(),
                  ],
                ),
              ],
            );
          }
        }
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
                      child: Profiletext(), //form
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
