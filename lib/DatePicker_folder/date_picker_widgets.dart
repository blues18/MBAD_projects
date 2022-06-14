import 'package:facilitiesbookingapp/DatePicker_folder/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class horizontal_date_picker extends StatefulWidget {

  @override
  State<horizontal_date_picker> createState() => _horizontal_date_pickerState();
}


class _horizontal_date_pickerState extends State<horizontal_date_picker> {
  DateTime _selectedValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
          width: double.infinity,
            padding: EdgeInsets.all(20.0),
            child: Column(
                children: <Widget>[
                  //Text("Selected Date"),
                  //Padding(
                    //padding: EdgeInsets.all(10),
                  //),
                  Text(_selectedValue.toString()),
                  DatePickerTimeline(_selectedValue, onDateChange: (date) {
                    setState(() {
                      _selectedValue = date;
                    });
                  }, key: null, )
                ]));
    
  }
}
