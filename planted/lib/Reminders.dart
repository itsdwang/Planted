import 'package:flutter/material.dart';
import './plantsInfo/reminder.dart';
import './plantsInfo/remindersService.dart';

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

  _getRemindersForPlant() async {
    List<Reminder> allReminders = await RemindersService.getReminders();
    List<Reminder> filterReminders = [];
    for (int i = 0; i < allReminders.length; i++) {
      if (allReminders[i].isTurnedOn) {
        filterReminders.add(allReminders[i]);
        print(allReminders[i].isTurnedOn);
        // print(allReminders.length);
      }
    }
    setState(() {
      _reminders = filterReminders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View All active reminders"),
      ),
      body: new ListView.builder(
        itemCount: _reminders.length,
        itemBuilder: (context, index) {
          return new Card(
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      new Text(_reminders[index].reminderName),
                      new Text(_reminders[index].reminderDate),
                      new Text(_reminders[index].reminderTime)
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
