import 'package:facilitiesbookingapp/firebase_services/authentication_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Register_Screen.dart';
import 'reset_Password_Screen.dart';


class LoginScreen extends StatefulWidget {
  static String routeName = '/Login_Screen';

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen>{

  String? email;
  String? password;

  var form = GlobalKey<FormState>();

  Widget login_TextFrom(){
    return Form(
      key: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: InputDecoration(
                label: Text('E-mail Address' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
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
          SizedBox(height: 30),
          TextFormField(
            decoration: InputDecoration(label: Text('Password' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
              suffixIcon: Icon(Icons.password_rounded),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null)
                return 'Please provide a password.';
              else if (value.length < 9)
                return 'Password must be at least 9 characters.';
              else
                return null;
            },
            onSaved: (value) {
              password = value;
            },
          ),
          forgotRegister(),
          SizedBox(height: 40),
          SizedBox(
            width: 50,
            height: 50,
            child: ElevatedButton(
                onPressed: () {
                  login();
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

  login() {
    bool isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();

      Authentication_services authService = Authentication_services();
      return authService.login(email, password).then((value) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login successfully!'),
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

  Widget forgotRegister(){
    return TextButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(reset_screen.routeName);
        },
        child: Align(
          alignment: Alignment.centerRight,
          child: Text('Forget Password',style: TextStyle(fontSize: 15, color: HexColor.fromHex('#293D45'))),
        )
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
                            Text('Login',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.white)),

                            TextButton(
                              onPressed: () => Navigator.of(context).pushNamed(register_Screen.routeName),
                              child: Text('Register',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.green)),
                            ),
                          ],
                        ),
                        SizedBox(height: 90),
                        login_TextFrom(),
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

class HexColor {
  static Color fromHex(String hexString){
    final buffer = StringBuffer();
    if(hexString.length <= 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));

    return Color(int.parse(buffer.toString(),radix: 16));
  }
}



