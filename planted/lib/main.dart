import 'dart:math';

import 'package:flutter/material.dart';
import 'login/login.dart';

void main() => runApp(PlantedApp());

class PlantedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // // TODO: implement build
    // return null;
    return new MaterialApp(
        title: 'Planted',
        // home: new LoginPage()
        home: new MainPage());
  }
}

// Here, we will create the splash page.

class MainPage extends StatelessWidget {
  @override
  // We're going to store the insides of the page using widgets
  Widget build(BuildContext context) {
    // This widget is in charge of displaying the gif!
    Widget gif = new Container(
        child: new Center(
      child: new Image.asset(
        'assets/images/green-pattern.gif',
      ),
    ));

    // This widget shows the logo
    Widget logo = new Container(
        child: new Center(
      child: new Image.asset(
        'assets/images/planted_light.png',
      ),
    ));

    // This widget gives the leaf background
    Widget backPic = new Container(
      child: new Image.asset(
        'assets/images/green-pattern.png',
        fit: BoxFit.cover,
      ),
    );

    // This widget
    Widget slogan = new Container(
        child: new Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: new Text(
            "let's grow something",
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Lora',
            ),
          ),
        ),
        new Text(
          "Beautiful",
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontFamily: 'Lora',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ));

    Widget version = new Container(
      child: Text(
        "version 1.0.0",
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Lora',
          fontSize: 10,
        ),
      ),
    );

    Widget signIn = new Container(
      decoration: new BoxDecoration(
        color: Color.fromRGBO(89, 87, 88, 1),
        border: new Border.all(width: 9, color: Color.fromRGBO(89, 87, 88, 1)),
        borderRadius: new BorderRadius.all(new Radius.circular(10)),
      ),
      child: IntrinsicWidth(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                'Grow',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      // Here, we set the background color for the whole page
      backgroundColor: Colors.black,

      body: Column(
        children: <Widget>[
          // This stack is showing the logo + flower
          new Stack(
            children: <Widget>[
              gif,
              logo,
            ],
          ),

          // This widget houses the background, slogan, and buttons
          new Stack(
            children: <Widget>[
              backPic,
              Center(
                child: new Column(
                  children: <Widget>[
                    slogan,
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: signIn,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // this has the version and stuff idk
          version,
        ],
      ),
    );
  }
}
