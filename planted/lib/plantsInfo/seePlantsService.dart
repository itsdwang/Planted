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

    // TO DO: FILTER OUT PLANTS THAT DONT BELONG TO USER....add check for uid in loop = currentuser.uid
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
        Plant plant = new Plant(key, value['plantName'], value['speciesName'],
            value['lightRequirement'], value['imageUrl']);
        print(plant.plantName);
        plants.add(plant);
      });

      return plants;
    });
  }
}
