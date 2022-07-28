import 'package:facilitiesbookingapp/AuthenticationScreen/Login_Screen.dart';
import 'package:facilitiesbookingapp/firebase_services/authentication_services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter/material.dart';

class register_Screen extends StatefulWidget {
  static String routeName = '/Register_screen';


  @override
  State<register_Screen> createState() => _register_ScreenState();
}

class _register_ScreenState extends State<register_Screen> {

  var formcheck = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'SG';
  PhoneNumber number = PhoneNumber(isoCode: 'SG');

  String? email;
  String? password;
  String? comfirmPassword;
  String? user_Name;
  String? mobile_Number;

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
        return authService.registerUser(email, user_Name, mobile_Number).then((
            value) {
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
      );
    }
  }

    Widget register_TextForm() {
      return Form(
        key: formcheck,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(label: Text('Email',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
              decoration: InputDecoration(label: Text('Name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                suffixIcon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null)
                  return "Please Enter your Full Name.";
                else
                  return null;
              },
              onSaved: (value) {
                user_Name = value;
              },
            ),
            SizedBox(height: 20),

            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                //print(number.phoneNumber);
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: number,
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
                mobile_Number = value.toString();
              },
            ),
            TextFormField(
              decoration: InputDecoration(label: Text('Password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
              decoration: InputDecoration(label: Text('Confirm Password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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

                  child: Text('Enter', style: TextStyle(fontSize: 20),)),
            )
          ],
        ),
      );
    }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
    await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'SG');

    setState(() {
      this.number = number;
    });
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
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )
                  ),
                  child: SingleChildScrollView(
                      child:Container(
                        child: Padding(padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pushNamed(
                                        LoginScreen.routeName),
                                child: Text('Login', style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green)),
                              ),

                              Text('Register', style: TextStyle(fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                            ],
                          ),
                          SizedBox(height: 60),
                          register_TextForm(),
                          SizedBox(height: 10),
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
                )
                ),
              )
          ],
          )
      );
    }
  }
