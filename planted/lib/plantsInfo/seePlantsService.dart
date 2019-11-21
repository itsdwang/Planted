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
        Plant plant = new Plant(value['plantName'], value['speciesName'],
            value['lightRequirement'], value['image']);
        print(plant.plantName);
        plants.add(plant);
      });
      print(plants[0].plantName);
      return plants;
    });
  }
}
