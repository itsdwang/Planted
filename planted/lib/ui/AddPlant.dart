import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:io';

class AddPlantPage extends StatefulWidget {
  _AddPlantPageState createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  final _formKey = GlobalKey<FormState>();
  File plantImage;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();

  final nameController = new TextEditingController();
  final lightRequirementController = new TextEditingController();
  final genusController = new TextEditingController();

  Widget displaySelectedFile(File file) {
    return new SizedBox(
      height: 200.0,
      width: 300.0,
      child: file == null
          ? new Text('No image selected!', textAlign: TextAlign.center)
          : new Image.file(file),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var temp = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        plantImage = temp;
      });
    }

    Future saveToDatabase(BuildContext context) async {
      final currentUser = await _firebaseAuth.currentUser();

      if (_formKey.currentState.validate()) {
        String filename = basename(plantImage.path);
        StorageReference firebaseStorageRef =
            FirebaseStorage.instance.ref().child(filename);
        StorageUploadTask uploadTask = firebaseStorageRef.putFile(plantImage);
        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

        setState(() {
          print("Plant image uploaded");
        });

        await databaseReference.child("plants").push().set({
          'uid': currentUser.uid,
          'plantName': nameController.text,
          'genusName': genusController.text,
          'lightRequirement': lightRequirementController.text,
          'imageUrl': filename
        });

        // Clear all field values after form was submitted
        nameController.clear();
        genusController.clear();
        lightRequirementController.clear();
      }
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: displaySelectedFile(plantImage)),
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 80.0, right: 80.0),
            child: ButtonTheme(
              height: 130,
              child: RaisedButton(
                child: (Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.add_a_photo,
                      size: 45,
                    ),
                    Text(
                      "Add Plant Image",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                )),
                color: Colors.lightGreen,
                onPressed: getImage,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 15.0, left: 80.0, right: 80.0),
              child: ButtonTheme(
                  height: 130.0,
                  child: RaisedButton(
                      color: Colors.lightGreen,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextFormField(
                                        controller: nameController,
                                        decoration:
                                            InputDecoration(labelText: 'Name:'),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter a name';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: genusController,
                                        decoration: InputDecoration(
                                            labelText: 'Genus'),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter a genus';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                          controller:
                                              lightRequirementController,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter a light requirement';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              labelText: 'Light Requirement')),
                                      RaisedButton(
                                        child: Text("Submit"),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                          }

                                          if (plantImage == null) {
                                            Toast.show(
                                                "Select an image", context,
                                                duration: Toast.LENGTH_LONG,
                                                gravity: Toast.BOTTOM);
                                          } else {
                                            saveToDatabase(context);

                                            // Close dialog box
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop('dialog');
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.info,
                              size: 45,
                            ),
                            Text("Add Plant Info",
                                style: TextStyle(fontSize: 25)),
                          ])),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0))))
        ],
      ),
    );
  }
}
