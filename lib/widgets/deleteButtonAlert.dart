import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../AuthenticationScreen/testScreen.dart';

class deleteAlertButton extends StatelessWidget {
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
                  title: Text("Are you sure you wanna delete Account?"),
                  content: Text(
                      "you will be forced sign out and can no longer login to this account again"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushNamed(test.routeName),
                      child: Text('Yes'),
                    )
                  ],
                )),
        child: Text(
          'Delete Account',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
