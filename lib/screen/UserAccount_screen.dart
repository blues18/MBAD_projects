import 'dart:io';
import 'package:facilitiesbookingapp/firebase_services/authentication_services.dart';
import 'package:facilitiesbookingapp/models/User_auth_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/deleteButtonAlert.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:path/path.dart';


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
  File? image;

  Future<void> pickImage() {
    ImageSource chosenSource = ImageSource.gallery;
    return ImagePicker()
        .pickImage(source: chosenSource, maxWidth: 600, imageQuality: 50,
        maxHeight: 150)
        .then((imageFile) {
      if (imageFile != null) {
        setState(() {
          image = File(imageFile.path);
        });
      }
    });
  }

  void insertImage(){
    Authentication_services authService = Authentication_services();

    email = user.email;

    FirebaseStorage.instance.ref('profile_image/').child(DateTime.now().toString()+'_'+basename(
        image!.path)).
    putFile(image!).then((task) {
      task.ref.getDownloadURL().then((url_image) {
        authService.addImage(email,url_image);
      });
    });
  }



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

/*
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text('Successfully changed'))
      );
 */
    }
  }

  MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {
    final getColor = (Set<MaterialState> states) {
      if(states.contains(MaterialState.pressed)){
        return colorPressed;
      }else{
        return color;
      }
    };
    return MaterialStateProperty.resolveWith(getColor);
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("My Account", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: Colors.black)),

                    ElevatedButton.icon(
                        label: Text('Edit Profile'),
                        icon: const Icon(
                          Icons.edit_rounded,
                          size: 17,
                          color: Colors.green,
                        ),
                        style: ButtonStyle(
                            foregroundColor: getColor(Colors.black, Colors.white),
                            backgroundColor: getColor(Colors.white, Colors.green)
                        ),
                        onPressed: (){
                          setState(() => {
                            isEditable = !isEditable
                          });
                        }
                    ),
                  ],
                ),

                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [BoxShadow(
                      color: Color.fromARGB(90,20, 20, 20),
                      //blurRadius: 20,
                      offset: Offset(6,6),
                      )
                    ]
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 1,
                  ),
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 15,
                    right: 15,
                  ),
                  child: Column(
                    children: [

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
                    ],
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
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(90,20, 20, 20),
                                blurRadius: 20,
                                offset: Offset(6,6),
                              )
                            ]
                        ),
                        child:RaisedButton(
                          color:Color(0xfff6f6f6)
                          ,onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => CupertinoAlertDialog(
                                title: Text('Comfirm Update'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        updateProfile();
                                        setState(() {
                                          isEditable = false;
                                        });
                                      },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              )),
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
    Authentication_services authService = Authentication_services();

    return StreamBuilder<userModel>(
        stream: authService.getUserAuthenticationData(),
        builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            else{
              return Scaffold(
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
                          Text(snapshot.data!.userName,style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
                          SizedBox(height: 10),
                          CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage("${snapshot.data!.imageUrl}"),
                          ),
                          IconButton(
                              onPressed: () =>
                                showDialog(
                                    context: context,
                                    builder: (context)=> AlertDialog(
                                      title: Text('Pick Image'),
                                      content: Row(
                                        children: [
                                        Container(
                                        width: 120,
                                        height: 100,
                                        decoration: BoxDecoration(color: Colors.grey),
                                        child: image != null ? FittedBox(fit: BoxFit.fill,
                                            child: Image.file(image!)) : Center()
                                          ),
                                          TextButton.icon(
                                              onPressed: () {
                                                pickImage();
                                              },
                                              icon: Icon(Icons.edit_rounded),
                                              label: Text('Add Image'))
                                        ],
                                  ),
                                  actions:[
                                    TextButton(onPressed: () {
                                      insertImage();
                                    },
                                        child: Text('Okay')),

                                    TextButton(onPressed: () {
                                      Navigator.pop(context);
                                      },
                                        child: Text('Cancel'))
                                  ]
                                    ),
                                ),
                              icon: const Icon(
                                Icons.edit_rounded
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
        }
        );
  }
}
