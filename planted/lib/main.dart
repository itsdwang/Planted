import 'package:flutter/material.dart';
import './login/login.dart';

void main() {
  runApp(new PlantedApp());
}

class PlantedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // // TODO: implement build
    // return null;
    return new MaterialApp(title: 'Planted', home: new LoginPage());
  }
}
