import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

//only login page for now

class AddRemindersPage extends StatefulWidget {
  _AddRemindersPageState createState() => _AddRemindersPageState();
}

class _AddRemindersPageState extends State<AddRemindersPage> {
  // need to show reminders for current plant and then add
  // add form button to add a reminder for plant
  final _addReminderKey = GlobalKey<FormState>();
  final reminderNameController = new TextEditingController();
  var reminderDate;
  var reminderTime;

  submitReminderForm() {
    if (_addReminderKey.currentState.validate()) {
      _addReminderKey.currentState.save();
    }
  }

  showReminderForm() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Set new Reminder to water Plant!'),
            content: Form(
              key: _addReminderKey,
              child: Container(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        decoration:
                            InputDecoration(labelText: "Input Reminder Name"),
                        controller: reminderNameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            print("empty");
                            return "Please enter a Date";
                          }
                          return null;
                        }),
                    DateTimePickerFormField(
                        inputType: InputType.date,
                        format: DateFormat("yyyy-MM-dd"),
                        decoration:
                            InputDecoration(labelText: 'Select Reminder Date'),
                        onChanged: (pickedDate) {
                          setState(() => reminderDate = pickedDate);
                        },
                        validator: (value) {
                          if (value == null) {
                            print(value.toString().length);
                            return "Please enter a Date";
                          }
                          print(value.toString());

                          return null;
                        }),
                    DateTimePickerFormField(
                        inputType: InputType.time,
                        format: DateFormat("HH:mm"),
                        initialTime: TimeOfDay(hour: 5, minute: 5),
                        editable: false,
                        decoration: InputDecoration(
                            labelText: 'Select Reminder Time',
                            hasFloatingPlaceholder: false),
                        onChanged: (pickedTime) {
                          setState(() => reminderTime = pickedTime);
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Please enter a Time";
                          }
                          return null;
                        }),
                    RaisedButton(
                      onPressed: submitReminderForm,
                      child: Text("Submit"),
                    )
                    // onChanged: (dt) {
                    //   setState(() => date3 = dt);
                    //   print('Selected date: $date3');
                    //   print('Hour: $date3.hour');
                    //   print('Minute: $date3.minute');
                    // },
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Reminders to Your Plant!"),
        ),
        body: new RaisedButton(
          onPressed: showReminderForm,
          color: Colors.green,
          child: Text("Add Reminder for Plant!"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 38, 196, 133),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box,
                    color: Color.fromARGB(255, 0, 0, 0)),
                title: new Text('Account')),
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Color.fromARGB(255, 0, 0, 0)),
                title: new Text('Plants')),
            BottomNavigationBarItem(
                icon: Icon(Icons.access_alarm,
                    color: Color.fromARGB(255, 0, 0, 0)),
                title: new Text('Reminders')),
            BottomNavigationBarItem(
                icon: Icon(Icons.folder, color: Color.fromARGB(255, 0, 0, 0)),
                title: new Text('My Plants'))
          ],
        ));
  }
}
