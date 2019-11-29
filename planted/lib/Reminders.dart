import 'package:flutter/material.dart';
import './plantsInfo/reminder.dart';
import './plantsInfo/remindersService.dart';
import 'package:intl/intl.dart';

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

  deleteReminder(String reminderKey, int index) async {
    await RemindersService.deleteReminder(reminderKey);

    setState(() {
      _reminders.removeAt(index);
    });
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
