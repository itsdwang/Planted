import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:planted/login/login.dart';
import 'package:planted/plantsInfo/plants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:math';
import './reminder.dart';
import './remindersService.dart';

class AddRemindersPage extends StatefulWidget {
  final Plant plant;

  const AddRemindersPage({Key key, this.plant}) : super(key: key);

  _AddRemindersPageState createState() => _AddRemindersPageState();
}

class _AddRemindersPageState extends State<AddRemindersPage> {
<<<<<<< HEAD
  // need to show reminders for current plant and then add
  // add form button to add a reminder for plant
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

=======
>>>>>>> 3f3db5c583d62d3126af69a1a0080de6068f884d
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
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Future<void> scheduleNotification(scheduledReminder) async {
    // print(reminderDate.substring(0, 9) + " " + reminderTime.substring(11, 19));
    print(scheduledReminder);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        scheduledReminder.microsecond,
        'Its time to Water ' + widget.plant.plantName + "!",
        'Click to Water!',
        scheduledReminder,
        platformChannelSpecifics);
  }

  _getRemindersForPlant(plantKey) async {
    List<Reminder> allReminders = await RemindersService.getReminders();
    List<Reminder> filterReminders = [];

    for (int i = 0; i < allReminders.length; i++) {
      if (allReminders[i].plantKey == widget.plant.key) {
        filterReminders.add(allReminders[i]);
      }
    }

    setState(() {
      currentReminders = filterReminders;
    });
  }

  submitReminderForm() async {
    if (_addReminderKey.currentState.validate()) {
      print(reminderDate);
      print(reminderTime);
      _addReminderKey.currentState.save();
      final currentUser = await _firebaseAuth.currentUser();
      DateTime scheduledReminder = DateTime.parse(
          reminderDate.toString().substring(0, 10) +
              " " +
              reminderTime.toString().substring(11, 19));

      await databaseReference.child("reminders").push().set({
        'uid': currentUser.uid,
        'plantKey': widget.plant.key,
        'plantName': widget.plant.plantName,
        'reminderName': reminderNameController.text,
        'reminderID': Random.secure().nextInt(10000),
        'reminderDate': reminderDate.toString(),
        'reminderTime': reminderTime.toString(),
        'isTurnedOn': true
      });
      scheduleNotification(scheduledReminder);
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
                        format: DateFormat("EEEE, MM/dd/yyyy"),
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
