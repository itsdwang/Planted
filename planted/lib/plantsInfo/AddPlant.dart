import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart'; //Image plugin
import 'dart:async';
import 'dart:io';
import 'package:toast/toast.dart';

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
  final speciesController = new TextEditingController();

  Widget displaySelectedFile(File file) {
    return new SizedBox(
      height: 200.0,
      width: 300.0,
      child: file == null
          ? new Text('No image selected!!', textAlign: TextAlign.center)
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
        print('Image File Name: ' + filename);
        StorageUploadTask uploadTask = firebaseStorageRef.putFile(plantImage);
        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

        print('Task Snapshot URL: ' +
            taskSnapshot.ref.getDownloadURL().toString());

        setState(() {
          print("Plant image uploaded");
        });
        await databaseReference.child("plants").push().set({
          'uid': currentUser.uid,
          'plantName': nameController.text,
          'speciesName': speciesController.text,
          'lightRequirement': lightRequirementController.text,
          'imageUrl': filename
        });

        // Clear all field values after form was submitted
        nameController.clear();
        speciesController.clear();
        lightRequirementController.clear();
      }
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          displaySelectedFile(plantImage),
          new RaisedButton(
            child: Text("Add Plant Image"),
            color: Colors.lightGreen,
            onPressed: getImage,
          ),
          new RaisedButton(
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
                              decoration: InputDecoration(labelText: 'Name:'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a name';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: speciesController,
                              decoration: InputDecoration(labelText: 'Species'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a species';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                                controller: lightRequirementController,
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
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                }

                                if (plantImage == null) {
                                  Toast.show("Select an image", context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM);
                                } else {
                                  saveToDatabase(context);

                                  // Close dialog box
                                  Navigator.of(context, rootNavigator: true)
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
            child: Text("Add a Plant"),
          ),
        ],
      ),
    );
  }
}
