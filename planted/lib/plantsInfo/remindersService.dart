import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import './reminder.dart';

class RemindersService {
  static Future<List<Reminder>> getReminders() async {
    List<Reminder> reminderList = new List<Reminder>();
    final _firebaseAuth = FirebaseAuth.instance;
    final FirebaseUser user = await _firebaseAuth.currentUser();

    return FirebaseDatabase.instance
        .reference()
        .child("reminders")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        DateTime reminder = DateTime.parse(
            value['reminderDate'].toString().substring(0, 10) +
                " " +
                value['reminderTime'].toString().substring(11, 19));
        if (value['uid'] == user.uid && reminder.isAfter(DateTime.now())) {
          Reminder reminder = new Reminder(
              key,
              value['uid'],
              value['plantKey'],
              value['plantName'],
              value['reminderName'],
              value['reminderDate'],
              value['reminderTime'],
              value['isTurnedOn']);
          reminderList.add(reminder);
        }
      });

      return reminderList;
    });
  }

  static Future<void> deleteReminder(String reminderKey) async {
    FirebaseDatabase.instance
        .reference()
        .child("reminders")
        .child(reminderKey)
        .remove();
  }
}
