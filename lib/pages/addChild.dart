import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
//import 'package:google_fonts/google_fonts.dart';
import '../data/child.dart';
import '../pages/select_initial_reminders.dart' ;

String name = "";
File photo; // Image of the baby
DateTime dob;
String formattedDate;
int gender = -1;

class AddChild extends StatefulWidget {
  @override
  _AddChildState createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showError = false;
  // Take Image from camera
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      photo = image;
    });
  }

// Take Image from gallery
  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      photo = image;
    });
  }

  // Show Picker
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  // Widget for Child Name
  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
          key: Key("ChildName"),
          cursorColor: Colors.black,
          decoration: InputDecoration(labelText: "Child Name"),
          onSaved: (String value) {
            name = value;
          }),
    );
  }

  @override
  void initState(){
    super.initState();
     name = "";
     photo = null; // Image of the baby
     dob = null;
     formattedDate = "";
     gender = -1;
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 50),
          child: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Child Details',
                    style:  TextStyle(
                        color: Colors.cyan[900],
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                    )),
              ),
              // Add an option to add Image
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.black,
                    child: photo != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              photo,
                              width: 200,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.green[200],
                                borderRadius: BorderRadius.circular(100)),
                            width: 200,
                            height: 200,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
                          ),
                  ),
                ),
              ),
              // Add Name
              Container(
                  width: 370,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green[500], width: 2),
                    color: Colors.lightGreen[50],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(children: <Widget>[
                    _buildName(),
                    // Add date of birth through scrollable sat picker
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Date Of Birth'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(dob == null ? "" : formattedDate),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green, // background
                            ),
                            child: Text('Pick a date'),
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate:
                                          dob == null ? DateTime.now() : dob,
                                      firstDate: DateTime(1990),
                                      lastDate: DateTime(2022))
                                  .then((date) {
                                setState(() {
                                  dob = date;
                                  formattedDate =
                                      "${date.day} - ${date.month} - ${date.year}";
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    // Add the gender of child
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Gender'),
                          new Radio(
                            value: 0,
                            groupValue: gender,
                            onChanged: (int value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),
                          new Text(
                            'Male',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                            value: 1,
                            groupValue: gender,
                            onChanged: (int value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),
                          new Text(
                            'Female',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])),

              // Next button - transfer the information
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // background
                    //onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    _formKey.currentState.save();
                    if (dob == null || gender == -1 || name == ""|| photo == null ) {
                      setState(() {
                        showError = true;
                      });
                      return;
                    }
                    showError = false;
                    Child newChild = Child(photo, name, dob, gender);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Select_Initial_Reminders(
                            child: newChild,
                          ),),);

                    // Navigator.pushNamed(context, '/select_initial_reminders',
                    //     arguments: {'child': newChild});
                  },
                  icon: Icon(Icons.arrow_forward_sharp),
                  label: Text(""),
                ),
              ),
              showError == true
                  ? Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                          " Fill in all the details before moving forward "))
                  : Container(),
            ]),
          ),
        ),
      )),
    );
  }
}
