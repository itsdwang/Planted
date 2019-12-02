import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:planted/models/Plant.dart';

class SeePlantsService {
  static Future<List<Plant>> getPlantsById() async {
    final _firebaseAuth = FirebaseAuth.instance;
    final FirebaseUser user = await _firebaseAuth.currentUser();
    List<Plant> plants = new List<Plant>();

    return FirebaseDatabase.instance
        .reference()
        .child("plants")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        if (user.uid == value["uid"]) {
          Plant plant = new Plant(key, value['plantName'], value['genusName'],
              value['lightRequirement'], value['imageUrl']);
          plants.add(plant);
        }
      });

      return plants;
    });
  }

  static Future<void> deletePlant(String plantKey) async {
    FirebaseDatabase.instance
        .reference()
        .child("plants")
        .child(plantKey)
        .remove();

    FirebaseDatabase.instance
        .reference()
        .child("reminders")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        if (value['plantKey'] == plantKey) {
          FirebaseDatabase.instance
              .reference()
              .child("reminders")
              .child(key)
              .remove();
        }
      });
    });
  }
}
