import 'package:flutter/material.dart';
import './child.dart';
import '../pages/home.dart';

class AllChildren extends StatefulWidget {
  final List<Child> children;

  // In the constructor, require a Todo.
  AllChildren({Key key, @required this.children}) : super(key: key);

  @override
  _AllChildrenState createState() => _AllChildrenState();
}

class _AllChildrenState extends State<AllChildren> {

  Widget childTemplate(ch) {
    return Card(
        child: ListTile(
          leading: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.black,
              child: ch.photo != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.file(
                  ch.photo,
                  width: 60,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              )
                  : Container(
                decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(100)),
                width: 60,
                height: 200,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
              ),
            ),
          title: Text(
           ch.name,
           style: TextStyle(
             fontSize: 18.0,
             color: Colors.grey[850],
             fontWeight: FontWeight.bold,
             ),
          ),
          subtitle: Text(
            "DOB: ${(ch.dob.toString()).substring(0, 10)}",
             style: TextStyle(
              fontSize: 15.0,
              color: Colors.grey[850],
             ),
          ),
       ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('All Children'),
          centerTitle: true,
          backgroundColor: Colors.cyan[400],
        ),
        body: Column (
          children: children.map((ch) => childTemplate(ch)).toList(),
        )
      )
    );
  }
}
