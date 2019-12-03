import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planted/login/Login.dart';

import 'AddPlant.dart';
import './Reminders.dart';
import './SeePlantsView.dart';

class PlantsPage extends StatefulWidget {
  _PlantsPageState createState() => _PlantsPageState();
}

class _PlantsPageState extends State<PlantsPage> {
  int _selectedPage = 0;

  /// List of pages accessible from the bottom navigation bar.
  final _pageOptions = [
    RemindersPage(),
    AddPlantPage(),
    SeePlants(),
  ];

  /// Signs user out of their account.
  _signOutUser() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Planted!"),
            backgroundColor: Colors.green,
            actions: <Widget>[
              new RaisedButton(
                child: Text("Log Out"),
                onPressed: _signOutUser,
                color: Colors.lightGreen,
              )
            ],
            automaticallyImplyLeading: false),
        resizeToAvoidBottomPadding: false,
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 154, 204, 91),
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.access_alarm,
                    color: Color.fromARGB(255, 0, 0, 0)),
                title: new Text('Reminders',
                    style: TextStyle(color: Colors.black))),
            BottomNavigationBarItem(
                icon:
                    Icon(Icons.add_circle, color: Color.fromARGB(255, 0, 0, 0)),
                title: new Text('Add Plant',
                    style: TextStyle(color: Colors.black))),
            BottomNavigationBarItem(
                icon: Icon(Icons.folder, color: Color.fromARGB(255, 0, 0, 0)),
                title: new Text('My Plants',
                    style: TextStyle(color: Colors.black)))
          ],
        ));
  }
}
