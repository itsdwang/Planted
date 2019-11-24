class Reminder {
  String key;
  String plantKey;
  String uid;
  String reminderName;
  String reminderDate;
  String reminderTime;

  Reminder(key, uid, plantKey, reminderName, reminderDate, reminderTime) {
    this.key = key;
    this.uid = uid;
    this.plantKey = plantKey;
    this.reminderName = reminderName;
    this.reminderDate = reminderDate;
    this.reminderTime = reminderTime;
  }
}
