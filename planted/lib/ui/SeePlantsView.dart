import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:planted/models/Plant.dart';
import 'package:planted/services/SeePlantsService.dart';

import './AddReminders.dart';

class SeePlants extends StatefulWidget {
  SeePlantsState createState() => new SeePlantsState();
}

class SeePlantsState extends State<SeePlants> {
  final currentUser = FirebaseAuth.instance.currentUser();
  List<Plant> _plants = [];

  @override
  void initState() {
    super.initState();
    _getDataForView();
  }

  /// Sets plants variable to list of all the user's plants.
  Future _getDataForView() async {
    List<Plant> plantsList = await SeePlantsService.getPlantsById();

    setState(() {
      _plants = plantsList;
    });
  }

  /// Returns the uid of the currently logged-in user.
  getCurrentUser() async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final uid = currentUser.uid;

    return uid;
  }

  /// Deletes a plant from the Firebase database and the plants list.
  deletePlant(String plantKey, int index) async {
    await SeePlantsService.deletePlant(plantKey);

    setState(() {
      _plants.removeAt(index);
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.green,
        body: new ListView.builder(
            itemCount: _plants.length,
            itemBuilder: (context, index) {
              return new GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddRemindersPage(plant: _plants[index])));
                  },
                  child: Card(
                      elevation: 5,
                      child: Container(
                        height: 80.0,
                        child: Row(children: <Widget>[
                          Container(
                            height: 80.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    topLeft: Radius.circular(5)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://www.burpee.com/dw/image/v2/ABAQ_PRD/on/demandware.static/-/Sites-masterCatalog_Burpee/default/dw07e89459/Images/Product%20Images/prod500323/prod500323.jpg?sw=265&sh=312&sm=fit"))),
                          ),
                          Container(
                              height: 110,
                              child: Center(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                            'Name: ' + _plants[index].plantName,
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                            'Genus: ' +
                                                _plants[index].genusName,
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                            'Light Requirement: ' +
                                                _plants[index].lightRequirement,
                                            style: TextStyle(fontSize: 15)),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                          new Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: new IconButton(
                                    icon: Icon(Icons.remove_circle),
                                    onPressed: () => deletePlant(
                                        _plants[index].key, index))),
                          )
                        ]),
                      )));
            }));
  }
}
