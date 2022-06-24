import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class timePickerWidget extends StatefulWidget {


  @override
  State<timePickerWidget> createState() => _timePickerWidgetState();
}

class _timePickerWidgetState extends State<timePickerWidget> {
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    //scaffold
    return Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _selectTime(context);
              },
              child: Text("Choose Time"),
            ),
            Text("${selectedTime.hour}:${selectedTime.minute}"),
          ],
        ),
      );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,

    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
}
