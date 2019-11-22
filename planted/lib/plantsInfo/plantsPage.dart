import 'package:flutter/material.dart';

import 'AddPlant.dart';
import '../Reminders.dart';
import '../login/Account.dart';
import './seePlantsView.dart';
import './addReminders.dart';

class PlantsPage extends StatefulWidget {
  _PlantsPageState createState() => _PlantsPageState();
}

class _PlantsPageState extends State<PlantsPage> {
  int _selectedPage = 1;
  final _pageOptions = [
    AccountPage(),
    AddPlantPage(),
    RemindersPage(),
    SeePlants(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Planted!"),
        ),
        resizeToAvoidBottomPadding: false,
        body: _pageOptions[_selectedPage],

        // This is code that would build a bottom nav-bar. I copied and pasted
        // from this link:
        // https://medium.com/flutterpub/flutter-6-bottom-navigation-38b202d9ca23
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Color.fromARGB(255, 38, 196, 133),
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box,
                    color: Color.fromARGB(255, 0, 0, 0)),
                title: new Text('Account')),
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Color.fromARGB(255, 0, 0, 0)),
                title: new Text('Plants')),
            BottomNavigationBarItem(
                icon: Icon(Icons.access_alarm,
                    color: Color.fromARGB(255, 0, 0, 0)),
                title: new Text('Reminders')),
            BottomNavigationBarItem(
                icon: Icon(Icons.folder, color: Color.fromARGB(255, 0, 0, 0)),
                title: new Text('My Plants'))
          ],
        ));
  }
}
