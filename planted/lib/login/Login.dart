import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planted/ui/PlantsPage.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = new TextEditingController();
  final passwordController = new TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// signUpAndRegister() registers the new user and stores credientials to firebase database.
  void signUpAndRegister() async {
    if (_formKey.currentState.validate()) {
      AuthResult user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PlantsPage()));
    }
  }

  /// loginToAccount() logs the user into their profile with the valid credentials.
  void loginToAccount() async {
    if (_formKey.currentState.validate()) {
      AuthResult user = await _firebaseAuth.signInWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PlantsPage()));
    }
  }

  /// Displays the header of the login page.
  Widget title = new Container(
    child: Text("Welcome to Planted!",
        style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
  );

  /// Displays the login form for the user to input credentials.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Wrap(runSpacing: 30, spacing: 30, children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 100.0, 15.0, 2.0),
                child: title,
              ),
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
                          return "Please enter a valid email";
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
                          hintText: "Password"),
                      controller: passwordController)),
              new Container(
                child: new Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(60.0, 0, 30.0, 0),
                      child: new RaisedButton(
                        child: new Text("Login"),
                        color: Colors.greenAccent[100],
                        onPressed: loginToAccount,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0, 30.0, 0),
                      child: new RaisedButton(
                        child: new Text("Sign Up"),
                        color: Colors.blueAccent[000],
                        onPressed: signUpAndRegister,
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
