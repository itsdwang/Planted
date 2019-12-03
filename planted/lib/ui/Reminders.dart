import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planted/models/Reminder.dart';
import 'package:planted/services/RemindersService.dart';

class RemindersPage extends StatefulWidget {
  RemindersPageState createState() => new RemindersPageState();
}

class RemindersPageState extends State<RemindersPage> {
  List<Reminder> _reminders = new List<Reminder>();

  @override
  void initState() {
    super.initState();
    _getRemindersForPlant();
  }

  /// Returns all reminders enabled reminders for all of the user's plants.
  _getRemindersForPlant() async {
    List<Reminder> allReminders = await RemindersService.getReminders();
    List<Reminder> enabledReminders = [];


    /// Get all enabled reminders.
    for (int i = 0; i < allReminders.length; i++) {
      if (allReminders[i].isTurnedOn) {
        enabledReminders.add(allReminders[i]);
      }
    }

    /// Sort reminders in ascending order by date and time.
    enabledReminders.sort((a, b) {
      return a.compareTo(b);
    });

    setState(() {
      _reminders = enabledReminders;
    });
  }

  /// Deletes a reminder from the Firebase database and the reminders list.
  deleteReminder(String reminderKey, int index) async {
    await RemindersService.deleteReminder(reminderKey);

    setState(() {
      _reminders.removeAt(index);
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView.builder(
        itemCount: _reminders.length,
        itemBuilder: (context, index) {
          return new Card(
              elevation: 5,
              child: Container(
                height: 130.0,
                child: Row(children: <Widget>[
                  Container(
                    height: 120,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              _reminders[index].reminderName,
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                                'Plant Name: ' + _reminders[index].plantName,
                                style: TextStyle(fontSize: 15)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                                'Date: ' +
                                    getHumanReadableDate(
                                        _reminders[index].reminderDate),
                                style: TextStyle(fontSize: 15)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                                'Time: ' +
                                    getHumanReadableTime(
                                        _reminders[index].reminderTime),
                                style: TextStyle(fontSize: 15)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: new IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () =>
                                deleteReminder(_reminders[index].key, index))),
                  )
                ]),
              ));
        },
      ),
    );
  }
}
