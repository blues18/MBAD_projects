import 'package:facilitiesbookingapp/DatePicker_folder/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../secondary_screen/Gym_Section/gymBooking_screen.dart';

class horizontal_date_picker extends StatefulWidget {

  @override
  State<horizontal_date_picker> createState() => _horizontal_date_pickerState();
}


class _horizontal_date_pickerState extends State<horizontal_date_picker> {
  DateTime _selectedValue = DateTime.now();
  String fomattedDate = "";
  List storedtest = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 160,
          width: double.infinity,
            padding: EdgeInsets.all(20.0),
            child: Column(
                children: <Widget>[
                  Text(fomattedDate.toString()),
                  Text(storedtest.join(',')),
                  DatePickerTimeline(_selectedValue, onDateChange: (date) {
                    setState(() {
                      _selectedValue = date;
                      fomattedDate = DateFormat.yMMMEd().format(_selectedValue);
                      storedtest.add(fomattedDate);
                    });
                  }, key: null, )
                ]
            ));
  }
}

