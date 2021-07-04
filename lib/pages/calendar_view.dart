// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// //import 'package:shared_preferences/shared_preferences.dart';
// //import 'package:google_fonts/google_fonts.dart';
// import 'package:vaccinator_two/data/child.dart' ;
//
// class CalendarPage extends StatefulWidget {
//
//   final Child child;
//   const CalendarPage(
//       {Key key, this.child})
//       : super(key: key);
//
//   @override
//   _CalendarPageState createState() => _CalendarPageState();
// }
//
// class _CalendarPageState extends State<CalendarPage> {
//   CalendarController _controller;
//   Map<DateTime, List<dynamic>> _events;
//   List<dynamic> _selectedEvents;
//   TextEditingController _eventController;
//  // SharedPreferences prefs;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = CalendarController();
//     _eventController = TextEditingController();
//     _events = widget.child==null?{}:widget.child.events;
//     _selectedEvents = [];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _showAddDialog() async {
//       await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             content: TextField(
//               controller: _eventController,
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text("Save"),
//                 onPressed: () {
//                   if (_eventController.text.isEmpty) return;
//                   if (_events[_controller.selectedDay] != null) {
//                     _events[_controller.selectedDay]
//                         .add(_eventController.text);
//                   } else {
//                     _events[_controller.selectedDay] = [
//                       _eventController.text
//                     ];
//                   }
//                  //prefs.setString("events", json.encode(encodeMap(_events)));
//                   _eventController.clear();
//                   Navigator.pop(context);
//                 },
//               )
//             ],
//           ));
//       setState(() {
//         _selectedEvents = _events[_controller.selectedDay];
//
//       });
//     }
//
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: _showAddDialog,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               padding:EdgeInsets.all(10),
//               margin: EdgeInsets.all(50),
//               child:Text('Calendar',
//                   style: // GoogleFonts.lato(
//                    // textStyle:
//                 TextStyle(
//                       color: Colors.cyan[900],
//                       fontSize: 30.0,
//                       fontWeight: FontWeight.bold,
//                 //    ),
//                   )),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       stops: [
//                         0.1,
//                         0.4,
//                         0.8,
//                         0.9
//                       ],
//                       //colors: [Colors.lightGreen[100], Colors.lightGreen[200],Colors.green[300],Colors.teal[300]]),
//                       colors: [
//                         Colors.green[50],
//                         Colors.green[100],
//                         Colors.green[100],
//                         Colors.green[50]
//                       ]),
//                   borderRadius: BorderRadius.all(Radius.circular(20))),
//               child: Column(
//                 children: [
//                   TableCalendar(
//                     events: _events,
//                     initialCalendarFormat: CalendarFormat.month,
//                     calendarStyle: CalendarStyle(
//                         todayColor: Colors.teal,
//                         selectedColor: Colors.greenAccent,
//                         todayStyle: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 22.0,
//                             color: Colors.white)
//                     ),
//                     headerStyle: HeaderStyle(
//                       centerHeaderTitle: true,
//                       formatButtonDecoration: BoxDecoration(
//                         color: Colors.teal,
//                         borderRadius: BorderRadius.circular(22.0),
//                       ),
//                       formatButtonTextStyle: TextStyle(color: Colors.white),
//                       formatButtonShowsNext: false,
//                     ),
//                     startingDayOfWeek: StartingDayOfWeek.monday,
//                     onDaySelected: (date, events,_) {
//                        setState(() {
//                          _selectedEvents = events;
//                          });},
//
//                     builders: CalendarBuilders(
//                       // Selected Date
//                       selectedDayBuilder: (context, date, events) => Container(
//                           margin: const EdgeInsets.all(5.0),
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               color: Colors.blue ,
//                               borderRadius: BorderRadius.circular(8.0)),
//                           child: Text(
//                             date.day.toString(),
//                             style: TextStyle(color: Colors.white),
//                           )),
//                       // Today date
//                       todayDayBuilder: (context, date, events) => Container(
//                           margin: const EdgeInsets.all(5.0),
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               color: Colors.teal,
//                               borderRadius: BorderRadius.circular(8.0)),
//                           child: Text(
//                             date.day.toString(),
//                             style: TextStyle(color: Colors.white),
//                           )),
//                     ),
//                     calendarController: _controller,
//                   ),
//                 ],
//               ),
//
//             ),
//             ..._selectedEvents.map((event) => ListTile(
//               leading: Icon(Icons.add_alarm),
//               trailing: Text('For '+ widget.child.name),
//               title: Text(event,
//               style:TextStyle(
//                 color: Colors.teal,
//                 fontWeight: FontWeight.bold,
//               )),
//             ))
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vaccinator_two/data/child.dart' ;
import 'package:cloud_firestore/cloud_firestore.dart';

int userChoice =  0;
class Mapping {
  Child child;
  int index;
  Mapping(int index, Child child) {
    this.index = index;
    this.child = child;
  }
}
class CalendarPage extends StatefulWidget {

  final List<Child> children;
  const CalendarPage(
      {Key key, @required this.children})
      : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState(children);
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  final List<Child> children;
  _CalendarPageState(this.children);



  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = widget.children==null?{}:widget.children[0].events;
    _selectedEvents = [];
  }

  @override
  Widget build(BuildContext context) {
    _showAddDialog() async {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Select Child',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      ShowChildren(children),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton.extended(
                            key: Key('Submit'),
                            label: Text('Go'),
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                _events = widget.children==null?{}:widget.children[userChoice].events;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
    }
    return Scaffold(
      floatingActionButton: Container(
          height: 50.0,
          width: 200.0,
        child: FloatingActionButton.extended(
          icon: Icon(Icons.child_care),
          label: Text("Select Child"),
          onPressed: _showAddDialog,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding:EdgeInsets.all(10),
              margin: EdgeInsets.all(50),
              child:Text('Calendar',
                  style:
                TextStyle(
                      color: Colors.cyan[900],
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                  )),
            ),
            Container(
              margin: EdgeInsets.all(10),
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
                        Colors.green[50],
                        Colors.green[100],
                        Colors.green[100],
                        Colors.green[50]
                      ]),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  TableCalendar(
                    events: _events,
                    initialCalendarFormat: CalendarFormat.month,
                    calendarStyle: CalendarStyle(
                        todayColor: Colors.teal,
                        selectedColor: Colors.greenAccent,
                        todayStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                            color: Colors.white)
                    ),
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      formatButtonTextStyle: TextStyle(color: Colors.white),
                      formatButtonShowsNext: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (date, events,_) {
                       setState(() {
                         _selectedEvents = events;
                         });},

                    builders: CalendarBuilders(
                      // Selected Date
                      selectedDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.blue ,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                      // Today date
                      todayDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    calendarController: _controller,
                  ),
                ],
              ),

            ),
            ..._selectedEvents.map((event) => ListTile(
              leading: Icon(Icons.add_alarm),
              trailing: Text('For '+ widget.children[userChoice].name),
              title: Text(event,
              style:TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              )),
            ))
          ],
        ),
      ),
    );
  }
}


// This class is used to display a list of structures in dialogue box  preceded by the radio buttons
class ShowChildren extends StatefulWidget {
  final List<Child> children;
  const ShowChildren(this.children);

  @override
  _ShowChildrenState createState() => _ShowChildrenState();
}

class _ShowChildrenState extends State<ShowChildren> {
  int choosenIndex = 0;
  List<Mapping> choices = new List<Mapping>();

  @override
  void initState() {
    super.initState();
    userChoice = 0; // By default the first structure will be displayed as selected  .
    for (int i = 0; i < widget.children.length; i++) {
      choices.add(new Mapping(i, widget.children[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      // Wraping ListView inside Container to assign scrollable screen a height and width
      width: screenWidth / 2,
      height: screenHeight / 3,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: choices
            .map((entry) => RadioListTile(
          key: Key('Child ${entry.index}'),
          title: Text('${entry.child.name}'),
          groupValue: choosenIndex,
          activeColor: Colors.blue[500],
          value: entry.index,
          onChanged: (value) {
            // A radio button gets selected only when groupValue is equal to value of the respective radio button
            setState(() {
              userChoice = value;
              choosenIndex = value;
            });
          },
        ))
            .toList(),
      ),
    );
  }
}