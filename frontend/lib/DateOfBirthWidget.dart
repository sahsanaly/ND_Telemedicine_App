import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';

class DateOfBirthWidget extends StatefulWidget {
  @override
  _DateOfBirthWidget createState() => _DateOfBirthWidget();
}

class _DateOfBirthWidget extends State<DateOfBirthWidget> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.grey[900]!,
                  Colors.black,
                ],
                stops: const [0.7, 1.0],
              )),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: DatePickerWidget(
                    looping: true,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1922), //DateTime(1960),
                     lastDate: DateTime.now(),
                    dateFormat:
                    "dd/MMMM/yyyy",
                    onChange: (DateTime newDate, _) {
                      setState(() {
                        _selectedDate = newDate;
                      });
                    },
                    pickerTheme: const DateTimePickerTheme(
                      backgroundColor: Colors.transparent,
                      itemTextStyle:
                      TextStyle(color: Colors.white, fontSize: 19),
                      dividerColor: Colors.white,
                    ),
                  ),
                ),
               ElevatedButton(
                  onPressed: () {
                    // Close the screen and return "Nope." as the result.
                    Navigator.pop(context, _selectedDate);
                  },
                  child: const Text('Select date'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}