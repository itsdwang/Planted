import 'package:flutter/material.dart';

import 'login/Login.dart';
import 'login/SplashPage.dart';

void main() => runApp(PlantedApp());

class PlantedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Planted',
      home: new SplashPage(),
      routes: <String, WidgetBuilder>{
        '/LoginPage': (BuildContext context) => new LoginPage()
      },
    );
  }
}
