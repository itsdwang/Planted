import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:planted/plantsInfo/plants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './reminder.dart';
import './remindersService.dart';

//only login page for now

class AddRemindersPage extends StatefulWidget {
  final Plant plant;

  const AddRemindersPage({Key key, this.plant}) : super(key: key);

  _AddRemindersPageState createState() => _AddRemindersPageState();
}

class _AddRemindersPageState extends State<AddRemindersPage> {
  // need to show reminders for current plant and then add
  // add form button to add a reminder for plant
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();

  final _addReminderKey = GlobalKey<FormState>();
  final reminderNameController = new TextEditingController();
  var reminderDate;
  var reminderTime;
  List<Reminder> currentReminders = [];

  @override
  void initState() {
    super.initState();
    _getRemindersForPlant(widget.plant.key);
  }

  _getRemindersForPlant(plantKey) async {
    List<Reminder> allReminders = await RemindersService.getReminders();
    List<Reminder> filterReminders = [];
    for (int i = 0; i < allReminders.length; i++) {
      if (allReminders[i].plantKey == widget.plant.key) {
        filterReminders.add(allReminders[i]);
        print(allReminders[i].isTurnedOn);
        // print(allReminders.length);
      }
    }
    setState(() {
      currentReminders = filterReminders;
    });
  }

  submitReminderForm() async {
    if (_addReminderKey.currentState.validate()) {
      _addReminderKey.currentState.save();
      final currentUser = await _firebaseAuth.currentUser();
      await databaseReference.child("reminders").push().set({
        'uid': currentUser.uid,
        'plantKey': widget.plant.key,
        'plantName': widget.plant.plantName,
        'reminderName': reminderNameController.text,
        'reminderDate': reminderDate.toString(),
        'reminderTime': reminderTime.toString(),
        'isTurnedOn': true
      });
    }
    Navigator.of(context, rootNavigator: true).pop('dialog');
    // Reset form field values

    print('about to clear controller');
    reminderNameController.clear();
    _getRemindersForPlant(widget.plant.key);
  }

  getHumanReadableDate(String date) {
    DateTime reminderDate = DateTime.parse(date);
    String formattedDate = DateFormat('yMMMMd').format(reminderDate);

    return formattedDate;
  }

  getHumanReadableTime(String time) {
    DateTime reminderTime = DateTime.parse(time);
    String formattedTime = DateFormat('jm').format(reminderTime);

    return formattedTime;
  }

  showReminderForm() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add a new watering reminder'),
            content: Form(
              key: _addReminderKey,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
        backgroundColor: Colors.green,
        title: Text("View and add reminders"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: showReminderForm)
        ],
      ),
      body: new ListView.builder(
        itemCount: currentReminders.length,
        itemBuilder: (context, index) {
          return new Card(
            child: Column(
              children: <Widget>[
                Container(
                  child: SwitchListTile(
                    value: currentReminders[index].isTurnedOn ? true : false,
                    onChanged: (value) {
                      FirebaseDatabase.instance
                          .reference()
                          .child("reminders")
                          .child(currentReminders[index].key)
                          .update({'isTurnedOn': value});
                      print(value);
                      currentReminders[index].setTurnedOnValue(value);
                    },
                    title: new Text(getHumanReadableDate(
                        currentReminders[index].reminderDate.substring(0, 10))),
                    subtitle: new Text(getHumanReadableTime(
                        currentReminders[index].reminderTime)),
                  ),
                  color: Colors.lightGreen,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
