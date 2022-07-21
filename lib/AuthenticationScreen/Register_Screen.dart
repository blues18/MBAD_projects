import 'package:facilitiesbookingapp/AuthenticationScreen/Login_Screen.dart';
import 'package:facilitiesbookingapp/firebase_services/authentication_services.dart';
import 'package:flutter/material.dart';

class register_Screen extends StatefulWidget {
  static String routeName = '/Register_screen';


  @override
  State<register_Screen> createState() => _register_ScreenState();
}

class _register_ScreenState extends State<register_Screen> {

  var formcheck = GlobalKey<FormState>();

  String? email;
  String? password;
  String? comfirmPassword;
  String? mobile_number;

  register() {
    bool isValid = formcheck.currentState!.validate();
    if (isValid) {
      formcheck.currentState!.save();

      if (password != comfirmPassword) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Password and Confirm Password does not match!'),
        ));
      }

      Authentication_services authService = Authentication_services();

      return authService.register(email, password).then((value) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User Registered successfully!'),
        ));
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

  Widget register_TextForm(){
    return Form(
      key: formcheck,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: InputDecoration(label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
              suffixIcon: Icon(Icons.email),
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
          TextFormField(
            decoration: InputDecoration(label: Text('Password',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
              suffixIcon: Icon(Icons.password_rounded),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null)
                return 'Please provide a password.';
              else if (value.length < 6)
                return 'Password must be at least 6 characters.';
              else
                return null;
            },
            onSaved: (value) {
              password = value;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(label: Text('Confirm Password' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
              suffixIcon: Icon(Icons.password_rounded),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null)
                return 'Please provide a password.';
              else if (value.length < 6)
                return 'Password must be at least 6 characters.';
              else
                return null;
            },
            onSaved: (value) {
              comfirmPassword = value;
            },
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 50,
            height: 50,
            child: ElevatedButton(
                onPressed: () {
                  register();
                },
                style: ElevatedButton.styleFrom(
                  primary: HexColor.fromHex('#293D45'),
                  onPrimary: Colors.white,
                ),

                child: Text('Enter',style: TextStyle(fontSize: 20),)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: HexColor.fromHex('#293D45'),

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
                      children: [
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            TextButton(
                              onPressed: () => Navigator.of(context).pushNamed(LoginScreen.routeName),
                              child: Text('Login',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.green)),
                            ),

                            Text('Register',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.white)),

                          ],
                        ),
                        SizedBox(height: 90),
                        register_TextForm(),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Or login with ')
                          ],
                        )

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
