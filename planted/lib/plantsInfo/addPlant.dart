import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPlant extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Add a plant to your Planted Profile!"),
          backgroundColor: Colors.lightGreen,
        ),
        backgroundColor: Colors.green,
        body: new Text("add a plant!"));
  }
}
