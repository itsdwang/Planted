import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:planted/plantsInfo/plantsPage.dart';

//only login page for now

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = new TextEditingController();
  final passwordController = new TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signUpAndRegister() async {
    if (_formKey.currentState.validate()) {
      AuthResult user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PlantsPage()));

      // TO DO: Add unable to register path
    } else {
      // credentials not good add error route;
    }
  }

  void loginToAccount() async {
    if (_formKey.currentState.validate()) {
      AuthResult user = await _firebaseAuth.signInWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PlantsPage()));

      // TO DO: Add unable to login path
    } else {
      // credentials not good add error route;
    }
  }

  // Widgets

  Widget title = new Container(
    child: Text("Welcome to Planted!",
        style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Wrap(runSpacing: 20, spacing: 20, children: <Widget>[
              title,
              Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                  child: TextFormField(
                      decoration: new InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.green, width: 5.0),
                          ),
                          hintText: "Username"),
                      validator: (value) {
                        if (EmailValidator.validate(value)) {
                          return null;
                        } else {
                          return "please enter a valid email";
                        }
                      },
                      controller: usernameController)),
              Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                  child: TextFormField(
                      obscureText: true,
                      decoration: new InputDecoration(
                          labelText: 'Password',
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.green, width: 5.0),
                          ),
                          hintText: "password"),
                      controller: passwordController)),
              new Container(
                child: new Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(70.0, 0, 30.0, 0),
                      child: new RaisedButton(
                        child: new Text("Login"),
                        color: Colors.red[600],
                        onPressed: loginToAccount,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50.0, 0, 30.0, 0),
                      child: new RaisedButton(
                        child: new Text("Sign Up"),
                        color: Colors.blueAccent[600],
                        onPressed: signUpAndRegister,
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
