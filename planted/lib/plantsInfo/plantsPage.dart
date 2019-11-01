import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';  //Image plugin
import 'dart:async';
import 'dart:io';


class PlantsPage extends StatefulWidget {
  _PlantsPageState createState() => _PlantsPageState();
}


class _PlantsPageState extends State<PlantsPage> {
  final _formKey = GlobalKey<FormState>();
  File plantImage;

  Widget displaySelectedFile(File file) {
    return new SizedBox(
      height: 200.0,
      width: 300.0,
      child: file == null
          ? new Text('No image selected!!', textAlign:TextAlign.center)
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

    Future enableUpload(BuildContext context) async {
      String filename = basename(plantImage.path);
      StorageReference firebaseStorageRef =
      FirebaseStorage.instance.ref().child(filename);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(plantImage);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      setState(() {
        print("plant img uploaded");
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: new ListView(
        //Center(
        padding: const EdgeInsets.all(8),
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
                        child: ListView(
                          padding: const EdgeInsets.all(8),
                          //mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Name:'
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Species'
                                  )
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Light Requirement'
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                  }
                                  if (plantImage == null) {
                                    print('Select an Image');
                                  } else {
                                    enableUpload(context);
                                  }
                                },
                              ),
                            )
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

