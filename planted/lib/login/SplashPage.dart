import 'dart:async';

import 'package:flutter/material.dart';

/// Reference to creating splash screen: https://medium.com/@vignesh_prakash/flutter-splash-screen-84fb0307ac55
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  /// navigationPage() redirects the user to the login page after 3 seconds.
  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/LoginPage');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/green-pattern.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: new Text(
          'Planted!',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50.0,
              color: Colors.grey[800]),
        ),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}
