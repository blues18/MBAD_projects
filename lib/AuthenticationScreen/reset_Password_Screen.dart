import 'package:facilitiesbookingapp/AuthenticationScreen/Login_Screen.dart';
import 'package:facilitiesbookingapp/firebase_services/authentication_services.dart';
import 'package:flutter/material.dart';


class reset_screen extends StatefulWidget {
  static String routeName = '/reset_screen';

  @override
  State<reset_screen> createState() => _reset_screenState();
}

class _reset_screenState extends State<reset_screen> {
  String? email;
  var form = GlobalKey<FormState>();

  reset() {
    bool isValid = form.currentState!.validate();

    if (isValid) {
      form.currentState!.save();

      Authentication_services authService = Authentication_services();

      return authService.forgotPassword(email).then((value) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Pleasecheck your email for to reset your password!'),
        ));
        Navigator.of(context).pop();
      }).catchError((error) {
        FocusScope.of(context).unfocus();
        String message = error.toString();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor.fromHex('#293D45'),
        appBar: AppBar(
          backgroundColor: HexColor.fromHex('#293D45'),
        ),
        body: Stack(children: [
          Positioned(
            bottom: 0,
            child:Container(
                height: 640,
                width: 395,
                decoration: BoxDecoration(
                    color: HexColor.fromHex('#67E0FF'),
                    borderRadius:const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )
                ),
                child: Container(
                  child: Padding(padding: EdgeInsets.all(30),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text('Forget Password',
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: HexColor.fromHex('#293D45')),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 40),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Form(
                            key: form,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(label: Text('Email',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                                    suffixIcon: Icon(Icons.email_rounded),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null)
                                      return "Please provide an email address.";
                                    else if (!value.contains('@'))
                                      return "Please provide a valid email address.";
                                    else
                                      return null;
                                  },
                                  onSaved: (value) {
                                    email = value;
                                  },
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                    onPressed: () {
                                      reset();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: HexColor.fromHex('#293D45'),
                                      onPrimary: Colors.white,
                                    ),

                                    child: Text('Reset Password',style: TextStyle(fontSize: 17))
                                    ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 90),
                      ],
                    ),
                  ),
                )
            ),
          )
        ],
        )
    );
  }
}
