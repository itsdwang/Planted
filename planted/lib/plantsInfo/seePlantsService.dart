import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './plants.dart';

class SeePlantsService {
  static Future<List<Plant>> getPlantsById() async {
    final _firebaseAuth = FirebaseAuth.instance;
    final FirebaseUser user = await _firebaseAuth.currentUser();
    var plantslist = [];

    final db = FirebaseDatabase.instance.reference().child("plants");
    List<Plant> plants = new List<Plant>();
    return FirebaseDatabase.instance
        .reference()
        .child("plants")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        print(key);
        if (user.uid == value["uid"]) {
          Plant plant = new Plant(key, value['plantName'], value['speciesName'],
              value['lightRequirement'], value['imageUrl']);
          print(plant.plantName);
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
    print('after remove of delete Plant');

    FirebaseDatabase.instance
        .reference()
        .child("reminders")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        print('about to delete reminder');
        print('reminder key ' + key.toString());
        print('remind value ' + value.toString());
      });
    });
  }
}




















