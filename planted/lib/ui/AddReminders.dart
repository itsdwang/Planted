import 'dart:math';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:planted/models/Plant.dart';
import 'package:planted/models/Reminder.dart';
import 'package:planted/services/RemindersService.dart';

import './PlantsPage.dart';

class AddRemindersPage extends StatefulWidget {
  final Plant plant;
  const AddRemindersPage({Key key, this.plant}) : super(key: key);

  _AddRemindersPageState createState() => _AddRemindersPageState();
}

class _AddRemindersPageState extends State<AddRemindersPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
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
    _initReminders();
  }

  _initReminders() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('plant');
    var initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: null);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future<void> onSelectNotification(String payload) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => PlantsPage()));
  }

  /// Schedules a notification based on date and time.
  Future<void> scheduleNotification(scheduledReminder, reminderID) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        reminderID,
        'Its time to water ' + widget.plant.plantName + "!",
        'Click to Water!',
        scheduledReminder,
        platformChannelSpecifics);
  }

  cancelReminder(reminderID) async {
    await flutterLocalNotificationsPlugin.cancel(reminderID);
  }

  /// Returns all reminders corresponding to a particular plant.
  _getRemindersForPlant(plantKey) async {
    List<Reminder> allReminders = await RemindersService.getReminders();
    List<Reminder> filterReminders = [];

    for (int i = 0; i < allReminders.length; i++) {
      if (allReminders[i].plantKey == widget.plant.key) {
        filterReminders.add(allReminders[i]);
      }
    }

    filterReminders.sort((a, b) {
      return a.compareTo(b);
    });

    setState(() {
      currentReminders = filterReminders;
    });
  }

  /// Adds reminder object to the Firebase database.
  submitReminderForm() async {
    if (_addReminderKey.currentState.validate()) {
      _addReminderKey.currentState.save();
      final currentUser = await _firebaseAuth.currentUser();
      DateTime scheduledReminder = DateTime.parse(
          reminderDate.toString().substring(0, 10) +
              " " +
              reminderTime.toString().substring(11, 19));

      int reminderID = Random.secure().nextInt(10000);
      await databaseReference.child("reminders").push().set({
        'uid': currentUser.uid,
        'plantKey': widget.plant.key,
        'plantName': widget.plant.plantName,
        'reminderName': reminderNameController.text,
        'reminderID': reminderID,
        'reminderDate': reminderDate.toString(),
        'reminderTime': reminderTime.toString(),
        'isTurnedOn': true
      });
      scheduleNotification(scheduledReminder, reminderID);
    }

    Navigator.of(context, rootNavigator: true).pop('dialog');

    /// Reset form field values.
    reminderNameController.clear();
    _getRemindersForPlant(widget.plant.key);
  }

  /// Return the reminder date and time in one string.
  getDateTimeReminder(String reminderDate, String reminderTime) {
    return DateTime.parse(reminderDate.toString().substring(0, 10) +
        " " +
        reminderTime.toString().substring(11, 19));
  }

  /// Return the date string in a more human readable format.
  getHumanReadableDate(String date) {
    DateTime reminderDate = DateTime.parse(date);
    String formattedDate = DateFormat('yMMMMd').format(reminderDate);

    return formattedDate;
  }

  /// Return the time string in a more human readable format.
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
                            return "Please enter a Date";
                          }

                          return null;
                        },
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(18),
                        ]),
                    DateTimePickerFormField(
                        inputType: InputType.date,
                        format: DateFormat("EEEE, MM/dd/yyyy"),
                        decoration:
                            InputDecoration(labelText: 'Select Reminder Date'),
                        onChanged: (pickedDate) {
                          setState(() => reminderDate = pickedDate);
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Please enter a Date";
                          }

                          return null;
                        }),
                    DateTimePickerFormField(
                        inputType: InputType.time,
                        format: DateFormat("h:mm a"),
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
        title: Text("Reminders for " + widget.plant.plantName),
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

                      currentReminders[index].setTurnedOnValue(value);

                      if (value) {
                        var scheduledReminder = getDateTimeReminder(
                            currentReminders[index].reminderDate,
                            currentReminders[index].reminderTime);
                        scheduleNotification(scheduledReminder,
                            currentReminders[index].reminderID);
                      } else {
                        /// Turn off reminder.
                        cancelReminder(currentReminders[index].reminderID);
                      }
                    },
                    title: new Text(getHumanReadableDate(
                        currentReminders[index].reminderDate.substring(0, 10))),
                    subtitle: new Text(getHumanReadableTime(
                        currentReminders[index].reminderTime)),
                  ),
                  color: Colors.lightGreen,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
