class Reminder {
  String key;
  String plantKey;
  String plantName;
  String uid;
  String reminderName;
  String reminderDate;
  String reminderTime;
  bool isTurnedOn;

  Reminder(key, uid, plantKey, plantName, reminderName, reminderDate,
      reminderTime, value) {
    this.key = key;
    this.uid = uid;
    this.plantKey = plantKey;
    this.plantName = plantName;
    this.reminderName = reminderName;
    this.reminderDate = reminderDate;
    this.reminderTime = reminderTime;
    this.isTurnedOn = value;
  }

  setTurnedOnValue(value) {
    this.isTurnedOn = value;
  }

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
