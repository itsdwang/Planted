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
      appBar: AppBar(
        title: Text("View All active reminders"),
      ),
      body: new ListView.builder(
        itemCount: _reminders.length,
        itemBuilder: (context, index) {
          return new Card(
              elevation: 5,
              child: Container(
                height: 110.0,
                child: Row(children: <Widget>[
                  Container(
                      height: 100,
                      child:
                      // Text('Plant Name:    ' + _plants[index].plantName))
                      Center(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(0),
                                child: Text('Name: ' +
                                    _reminders[index].reminderName),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('Date: ' +
                                    getHumanReadableDate(_reminders[index].reminderDate)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(9),
                                child: Text('Time: ' +
                                   getHumanReadableTime(_reminders[index].reminderTime)),
                              )
                            ],
                          ),
                        ),
                      )),
                ]),
              ));

        },
      ),
    );
  }
}
