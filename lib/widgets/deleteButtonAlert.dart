import 'package:facilitiesbookingapp/firebase_services/authentication_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class deleteAlertButton extends StatefulWidget {

  @override
  State<deleteAlertButton> createState() => _deleteAlertButton();

}

class _deleteAlertButton extends State <deleteAlertButton> {

  logOut() {
    Authentication_services authService = Authentication_services();
    return authService.loginOut().then((value) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Logout successfully!'),
      ));
    }).catchError((error) {
      FocusScope.of(context).unfocus();
      String message = error.toString as String;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 100,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(25), boxShadow: [
        BoxShadow(
          color: Color.fromARGB(90, 20, 20, 20),
          blurRadius: 20,
          offset: Offset(6, 6),
        )
      ]),
      child: RaisedButton(
        color: Color(0xfff6f6f6),
        onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
                  title: Text("Are you sure you want Log out"),
                  content: Text(
                      "you will be redirected back to login screen"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        logOut();
                      },
                        child: Text('Yes'),
                    )
                  ],
                )),
        child: Text(
          'Log Out',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}


