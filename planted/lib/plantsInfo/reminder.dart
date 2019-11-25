class Reminder {
  String key;
  String plantKey;
  String uid;
  String reminderName;
  String reminderDate;
  String reminderTime;
  bool isTurnedOn;

  Reminder(
      key, uid, plantKey, reminderName, reminderDate, reminderTime, value) {
    this.key = key;
    this.uid = uid;
    this.plantKey = plantKey;
    this.reminderName = reminderName;
    this.reminderDate = reminderDate;
    this.reminderTime = reminderTime;
    this.isTurnedOn = value;
  }

  setTurnedOnValue(value) {
    this.isTurnedOn = value;
  }
}
