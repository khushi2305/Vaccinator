// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:vaccinator_two/controllers/authentication.dart';
// //import 'package:google_fonts/google_fonts.dart';
// import 'package:vaccinator_two/pages/calendar_view.dart';
// import 'package:vaccinator_two/data/child.dart' ;
// import 'package:vaccinator_two/pages/login_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// List<Child> children ;
//
// class MyHomePage extends StatefulWidget {
//   final String uid;
//    MyHomePage(
//       {Key key , @required this.uid})
//       : super(key: key);
//   @override
//   _MyHomePageState createState() => _MyHomePageState(uid);
// }
//
// class _MyHomePageState extends State<MyHomePage>  {
//   final String uid;
//   _MyHomePageState(this.uid);
//   var userChildren = Firestore.instance.collection('children');
//   int _index = 0;
//   int numCards = 1;
//   Map data = {};
//   Map arg = {} ;
//
//   _addChild(Child newChild) async {
//     children.add(newChild);
//     userChildren.document(uid).collection('children').add({
//       'child': newChild,
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     print(children==null);
//     if(children == null ) {
//       children = [];
//     }
//     Future.delayed(Duration.zero, () {
//       setState(() {
//         arg = ModalRoute.of(context).settings.arguments;
//       });
//       if(arg!=null)
//       _addChild(arg['addedChild']);
//       numCards = children.length==0?1:children.length;
//       if(children != null) {
//         for (Child child in children)
//           child.getNextDueVaccines();
//       }
//     });
//   }
//
//   Widget build(BuildContext context) {
//
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
//               Widget>[
//             // 6 : 4 : 4 : 1
//             Expanded(
//                 flex: 6,
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: <Widget>[
//                     Container(
//                       margin: EdgeInsets.only(bottom: 80.0),
//                       padding: EdgeInsets.all(0),
//                       decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                               stops: [
//                                 0.1,
//                                 0.4,
//                                 0.8,
//                                 0.9
//                               ],
//                               //colors: [Colors.lightGreen[100], Colors.lightGreen[200],Colors.green[300],Colors.teal[300]]),
//                               colors: [
//                                 Colors.teal[50],
//                                 Colors.teal[100],
//                                 Colors.teal[300],
//                                 Colors.teal[400]
//                               ]),
//                           borderRadius: BorderRadius.all(Radius.circular(20))),
//                     ),
//                     Stack(
//                       children: <Widget>[
//                         Positioned(
//                           top: 100,
//                           left: 25,
//                           child: Text('Vaccine Reminder',
//                               style: //GoogleFonts.lato(textStyle:
//                                 TextStyle(
//                                   color: Colors.cyan[900],
//                                   fontSize: 30.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               )),
//                       //  ),
//                         Container(
//                           margin: EdgeInsets.only(top: 200.0),
//                           child: SizedBox(
//                             height: 150, // card height
//                             child: PageView.builder(
//                               itemCount: numCards ,
//                               controller: PageController(viewportFraction: 0.7),
//                               onPageChanged: (int index) =>
//                                   setState(() => _index = index),
//                               itemBuilder: (_, i) {
//                                 return Transform.scale(
//                                   scale: i == _index ? 1 : 0.9,
//                                   child: Card(
//                                       elevation: 6,
//                                       color:Colors.teal[600],
//                                       // color: Color.fromRGBO(
//                                       //     226,90,21,.5),
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(
//                                               20)),
//                                       child: (children!=null && children.length !=0 && i == _index ) ? Column(
//                                           children: <Widget>[
//                                             Row(
//                                               mainAxisSize:MainAxisSize.min,
//                                               children: [
//                                                 Center(
//                                                   child: Text(
//                                                     children[_index].name,
//                                                      style:// GoogleFonts.lato(textStyle:
//                                                     TextStyle(
//                                                       color: Colors.white,
//                                                       fontSize: 20.0,
//                                                       fontWeight: FontWeight.w900,
//                                                //     ),
//                                         )),
//                                                 ),
//                                               ],
//                                             ),
//                                             Text(
//                                                 "To be Taken on - ${children[_index].nextDue.keys.first
//                                                     .day} - ${children[_index].nextDue
//                                                     .keys.first.month} - ${children[_index].nextDue.keys.first
//                                                     .year}",
//                                                 style: //GoogleFonts.lato(textStyle:
//                                                   TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 15.0,
//                                                     fontWeight: FontWeight.w700,
//                                                 //  ),
//                                                 )),
//                                               Row(
//
//                                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                 children: [
//                                                   CircleAvatar(
//                                                     radius: 35,
//                                                     backgroundColor: Color.fromRGBO(
//                                                         226,114,91,0.5),
//                                                     child: ClipRRect(
//                                                       borderRadius: BorderRadius.circular(30),
//                                                       child: Image.file(
//                                                         children[_index].photo,
//                                                         width: 65,
//                                                         height: 65,
//                                                         fit: BoxFit.fill,
//                                                       ),
//                                                     )),
//                                                   Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       for(var next in children[_index].nextDue.values.first)
//                                                       Text(
//                                                         next,
//                                                         style: TextStyle(
//                                                           fontSize: 15,
//                                                           color: Colors.teal[50],
//                                                           fontWeight: FontWeight.w700,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               )
//                                           ]
//                                       ) :
//                                       Center(
//                                         child: Text("No child Added"),
//                                       )
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                   overflow: Overflow.clip,
//                 )),
//             Expanded(
//               flex: 4,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Ink(
//                               decoration: BoxDecoration(
//                                 border:
//                                 Border.all(color: Colors.cyan, width: 3.0),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: IconButton(
//                                 icon: Icon(Icons.add),
//                                 onPressed: () {
//                                   setState(() {
//                                     Navigator.pushNamed(context, '/addChild');
//                                   });
//                                 },
//                               )),
//                           Text('Add Child')
//                         ],
//                       ),
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Ink(
//                               decoration: BoxDecoration(
//                                 border:
//                                 Border.all(color: Colors.cyan, width: 3.0),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: IconButton(
//                                 icon: Icon(Icons.list_alt),
//                                 onPressed: () {
//                                   setState(() {});
//                                 },
//                               )),
//                           Text('View All'//, style: GoogleFonts.lato()
//                           )
//                         ],
//                       ),
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Ink(
//                               decoration: BoxDecoration(
//                                 border:
//                                 Border.all(color: Colors.cyan, width: 3.0),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: IconButton(
//                                 icon: Icon(Icons.calendar_today_rounded),
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (_) =>
//                                           CalendarPage(
//                                             //child: arg['addedChild'],
//                                             uid:uid,
//                                           ),),);
//                                 },
//                               )),
//                           Text('Calender View')
//                         ],
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Ink(
//                               decoration: BoxDecoration(
//                                 border:
//                                 Border.all(color: Colors.cyan, width: 3.0),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: IconButton(
//                                 icon: Icon(Icons.collections),
//                                 tooltip: "Add Child",
//                                 onPressed: () {
//                                   setState(() {});
//                                 },
//                               )),
//                           Text('Immunization'),
//                           Text('Articles')
//                         ],
//                       ),
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Ink(
//                               decoration: BoxDecoration(
//                                 border:
//                                 Border.all(color: Colors.cyan, width: 3.0),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: IconButton(
//                                 icon: Icon(Icons.medical_services_outlined),
//                                 tooltip: ' ',
//                                 onPressed: () {
//                                   setState(() {});
//                                 },
//                               )),
//                           Text('Ask a Doctor'//, style: GoogleFonts.lato()
//                              )
//                         ],
//                       ),
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Ink(
//                               decoration: BoxDecoration(
//                                 border:
//                                 Border.all(color: Colors.cyan, width: 3.0),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: IconButton(
//                                 icon: Icon(Icons.local_hospital),
//                                 tooltip: '',
//                                 onPressed: () {
//                                   setState(() {});
//                                 },
//                               )),
//                           Text('Nearby Clinics')
//                         ],
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Expanded(
//               flex: 4,
//               child: Column(children: <Widget>[
//                 SizedBox(
//                   height: 150, // card height
//                   child: PageView.builder(
//                     itemCount: 10,
//                     controller: PageController(viewportFraction: 0.7),
//                     onPageChanged: (int index) =>
//                         setState(() => _index = index),
//                     itemBuilder: (_, i) {
//                       return Transform.scale(
//                         scale: i == _index ? 1 : 0.9,
//                         child: Card(
//                           elevation: 6,
//                           color:Colors.teal[700],
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20)),
//                           child: Center(
//                             child: Text(
//                               "Article ${i + 1}",
//                               style: TextStyle(fontSize: 32),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ]),
//             ),
//             Expanded(
//                 flex: 1,
//                 child: Container(
//                     color: Colors.grey[300],
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: <Widget>[
//                           IconButton(
//                             icon: Icon(Icons.contact_page),
//                             tooltip: 'Contact Us',
//                             onPressed: () {
//                               setState(() {});
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.person),
//                             tooltip: 'Profile Page',
//                             onPressed: () {
//                               setState(() {});
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.exit_to_app),
//                             tooltip: 'Log Out',
//                             onPressed: () => signOutUser().then((value) {
//                               Navigator.of(context).pushAndRemoveUntil(
//                                   MaterialPageRoute(builder: (context) => LoginScreen()),
//                                       (Route<dynamic> route) => false);
//                             }),),
//                         ])))
//           ]),
//         ),
//       ),
//     );
//   // This trailing comma makes auto-formatting nicer for build methods.
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaccinator_two/controllers/authentication.dart';
import 'package:vaccinator_two/pages/calendar_view.dart';
import 'package:vaccinator_two/data/child.dart';
import 'package:vaccinator_two/pages/addChild.dart';
import 'package:vaccinator_two/pages/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

List<Child> children;

class MyHomePage extends StatefulWidget {
  final String uid;
  MyHomePage({Key key, @required this.uid}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState(uid);
}

class _MyHomePageState extends State<MyHomePage> {
  final String uid;
  _MyHomePageState(this.uid);
  var user = Firestore.instance.collection('users');
  int _index = 0;
  int numCards = 1;

  _addChild(Child newChild) async {
    setState(() {
      children.add(newChild);
    });
    user
        .document(uid)
        .collection('children')
        .add(newChild.toJson())
        .then((docRef) =>
    {print("Document written with ID: " + docRef.documentID)})
        .catchError((error) => {print("Error adding document: ")});
    ;
  }

  Future<void> getChildrenFromDatabase() async {
    QuerySnapshot querySnapshot =
    await user.document(uid).collection('children').getDocuments();
    for (int i = 0; i < querySnapshot.documents.length; i++) {
      // print("Database");
      var time = querySnapshot.documents[i].data['dob'];
      var dob = DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
      Child cutie = new Child(querySnapshot.documents[i].data['name'], dob,
          querySnapshot.documents[i].data['gender'],null);
      cutie.events = cutie.getEventsfromdatabase(querySnapshot.documents[i].data['events']);
      setState(() {
        children.add(cutie);
      });
    }

    numCards = children.length == 0 ? 1 : children.length;
    // print(children.length);
    if (children != null) {
      // print('HEYYY');
      for (Child child in children) child.getNextDueVaccines();
    }

  }

  @override
  void initState() {
    super.initState();
    // print(children == null);
    if (children == null) {
      children = [];
      getChildrenFromDatabase();
    }
  }

  void _goToAddChildPage(BuildContext context) async {
    Child result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddChild(),
        ));
    if (result != null) {
      _addChild(result);
    }
    numCards = children.length == 0 ? 1 : children.length;
    if (children != null) {
      for (Child child in children) child.getNextDueVaccines();
    }

  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            // 6 : 4 : 4 : 1
            Expanded(
                flex: 6,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 80.0),
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [
                                0.1,
                                0.4,
                                0.8,
                                0.9
                              ],
                              //colors: [Colors.lightGreen[100], Colors.lightGreen[200],Colors.green[300],Colors.teal[300]]),
                              colors: [
                                Colors.teal[50],
                                Colors.teal[100],
                                Colors.teal[300],
                                Colors.teal[400]
                              ]),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    Stack(
                      children: <Widget>[
                        Positioned(
                            top: 100,
                            left: 25,
                            child: Text(
                              'Vaccine Reminder',
                              style: //GoogleFonts.lato(textStyle:
                              TextStyle(
                                color: Colors.cyan[900],
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        //  ),
                        Container(
                          margin: EdgeInsets.only(top: 170.0),
                          child: SizedBox(
                            height: 150, // card height
                            child: PageView.builder(
                              itemCount: numCards,
                              controller: PageController(viewportFraction: 0.7),
                              onPageChanged: (int index) =>
                                  setState(() => _index = index),
                              itemBuilder: (_, i) {
                                return Transform.scale(
                                  scale: i == _index ? 1 : 0.9,
                                  child: Card(
                                      elevation: 6,
                                      color: Colors.teal[600],
                                      // color: Color.fromRGBO(
                                      //     226,90,21,.5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      child: (children != null &&
                                          children.length != 0 &&
                                          i == _index)
                                          ? Column(children: <Widget>[
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Center(
                                              child: Text(
                                                  children[_index].name,
                                                  style: // GoogleFonts.lato(textStyle:
                                                  TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                    FontWeight.w900,
                                                    //     ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Text(
                                            "To be Taken on - ${children[_index].nextDue.keys.first.day} - ${children[_index].nextDue.keys.first.month} - ${children[_index].nextDue.keys.first.year}",
                                            style: //GoogleFonts.lato(textStyle:
                                            TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w700,
                                              //  ),
                                            )),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceEvenly,
                                          children: [
                                            CircleAvatar(
                                                radius: 35,
                                                backgroundColor:
                                                Color.fromRGBO(255,
                                                    255, 255, 1),
                                                child:ClipRRect(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(30),
                                                  child: Image.file(
                                                    children[_index]
                                                        .photo,
                                                    width: 65,
                                                    height: 65,
                                                    fit: BoxFit.fill,
                                                  ),
                                                )),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                for (var next
                                                in children[_index]
                                                    .nextDue
                                                    .values
                                                    .first)
                                                  Text(
                                                    next,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                      Colors.teal[50],
                                                      fontWeight:
                                                      FontWeight.w700,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ])
                                          : Center(
                                        child: Text("No child Added"),
                                      )),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                  overflow: Overflow.clip,
                )),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Ink(
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.cyan, width: 3.0),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  _goToAddChildPage(context);
                                  //Navigator.pushNamed(context, '/addChild');
                                  setState(() {});
                                },
                              )),
                          Text('Add Child')
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Ink(
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.cyan, width: 3.0),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.list_alt),
                                onPressed: () {
                                  setState(() {});
                                },
                              )),
                          Text('View All' //, style: GoogleFonts.lato()
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Ink(
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.cyan, width: 3.0),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.calendar_today_rounded),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          CalendarPage(
                                            children:children,
                                          ),),);
                                },
                              )),
                          Text('Calender View')
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Ink(
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.cyan, width: 3.0),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.collections),
                                tooltip: "Add Child",
                                onPressed: () {
                                  setState(() {});
                                },
                              )),
                          Text('Immunization'),
                          Text('Articles')
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Ink(
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.cyan, width: 3.0),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.medical_services_outlined),
                                tooltip: ' ',
                                onPressed: () {
                                  setState(() {});
                                },
                              )),
                          Text('Ask a Doctor' //, style: GoogleFonts.lato()
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Ink(
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.cyan, width: 3.0),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.local_hospital),
                                tooltip: '',
                                onPressed: () {
                                  setState(() {});
                                },
                              )),
                          Text('Nearby Clinics')
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(children: <Widget>[
                SizedBox(
                  height: 150, // card height
                  child: PageView.builder(
                    itemCount: 10,
                    controller: PageController(viewportFraction: 0.7),
                    onPageChanged: (int index) =>
                        setState(() => _index = index),
                    itemBuilder: (_, i) {
                      return Transform.scale(
                        scale: i == _index ? 1 : 0.9,
                        child: Card(
                          elevation: 6,
                          color: Colors.teal[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              "Article ${i + 1}",
                              style: TextStyle(fontSize: 32),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ]),
            ),
            Expanded(
                flex: 1,
                child: Container(
                    color: Colors.grey[300],
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.contact_page),
                            tooltip: 'Contact Us',
                            onPressed: () {
                              setState(() {});
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.person),
                            tooltip: 'Profile Page',
                            onPressed: () {
                              setState(() {});
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.exit_to_app),
                            tooltip: 'Log Out',
                            onPressed: () => signOutUser().then((value) {
                              children = null;
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                      (Route<dynamic> route) => false);
                            }),
                          ),
                        ])))
          ]),
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
