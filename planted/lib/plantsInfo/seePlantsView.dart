import 'package:flutter/material.dart';
import './seePlantsService.dart';
import './plants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SeePlants extends StatefulWidget {
  SeePlantsState createState() => new SeePlantsState();
}

class SeePlantsState extends State<SeePlants> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser();
  List<Plant> _plants = [];

  @override
  void initState() {
    super.initState();
    _getDataforView();
  }

  Future _getDataforView() async {
    List<Plant> plantslist = await SeePlantsService.getPlantsById();
    setState(() {
      _plants = plantslist;
    });
    print(_plants[0]);
  }

  getCurrentUser() async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final uid = currentUser.uid;
    return uid;
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Track a plant to your Planted Profile!"),
          backgroundColor: Colors.lightGreen,
        ),
        backgroundColor: Colors.green,
        body: new ListView.builder(
            itemCount: _plants.length,
            itemBuilder: (context, index) {
              return new ListTile(
                title: new Text('Plant Name:   ' + _plants[index].plantName),
                subtitle:
                    new Text('species Name:   ' + _plants[index].speciesName),
              );
            }));
  }
}
