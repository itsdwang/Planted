class Reminder {
  String key;
  String plantKey;
  String plantName;
  String uid;
  String reminderName;
  String reminderDate;
  String reminderTime;
  int reminderID;
  bool isTurnedOn;

  /// Constructor to store the reminder's data.
  Reminder(key, uid, plantKey, plantName, reminderName, reminderDate,
      reminderTime, reminderID, value) {
    this.key = key;
    this.uid = uid;
    this.plantKey = plantKey;
    this.plantName = plantName;
    this.reminderName = reminderName;
    this.reminderDate = reminderDate;
    this.reminderTime = reminderTime;
    this.reminderID = reminderID;
    this.isTurnedOn = value;
  }

  /// setTurnedOnValue(value) changes the value of a reminder (on/off).
  setTurnedOnValue(value) {
    this.isTurnedOn = value;
  }

  /// Compares date & time for two reminders for organizing reminders on Reminders.dart.
  compareTo(Reminder b) {
    if (this.reminderDate.compareTo(b.reminderDate) > 0) {
      return 1;
    } else if (this.reminderDate.compareTo(b.reminderDate) < 0) {
      return -1;
    } else {
      return this.reminderTime.compareTo(b.reminderTime);
    }
  }
}
