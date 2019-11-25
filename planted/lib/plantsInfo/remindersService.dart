import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import './reminder.dart';

class RemindersService {
  static Future<List<Reminder>> getReminders() async {
    // final _firebaseAuth = FirebaseAuth.instance;

    List<Reminder> reminderList = new List<Reminder>();

    return FirebaseDatabase.instance
        .reference()
        .child("reminders")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        print(key);
        Reminder reminder = new Reminder(
            key,
            value['uid'],
            value['plantKey'],
            value['reminderName'],
            value['reminderDate'],
            value['reminderTime'],
            value['isTurnedOn']);
        // print(reminderList.plantName);
        reminderList.add(reminder);
      });
      // print(plants[0].plantName);
      return reminderList;
    });
  }
}
