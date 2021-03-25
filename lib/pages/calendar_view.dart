import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:vaccinator_two/data/child.dart' ;

class CalendarPage extends StatefulWidget {

  final Child child;
  const CalendarPage(
      {Key key, this.child})
      : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
 // SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = widget.child==null?{}:widget.child.events;
    _selectedEvents = [];
  }

  @override
  Widget build(BuildContext context) {
    _showAddDialog() async {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: TextField(
              controller: _eventController,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Save"),
                onPressed: () {
                  if (_eventController.text.isEmpty) return;
                  if (_events[_controller.selectedDay] != null) {
                    _events[_controller.selectedDay]
                        .add(_eventController.text);
                  } else {
                    _events[_controller.selectedDay] = [
                      _eventController.text
                    ];
                  }
                 //prefs.setString("events", json.encode(encodeMap(_events)));
                  _eventController.clear();
                  Navigator.pop(context);
                },
              )
            ],
          ));
      setState(() {
        _selectedEvents = _events[_controller.selectedDay];

      });
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddDialog,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding:EdgeInsets.all(10),
              margin: EdgeInsets.all(50),
              child:Text('Calendar',
                  style: // GoogleFonts.lato(
                   // textStyle:
                TextStyle(
                      color: Colors.cyan[900],
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                //    ),
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
              trailing: Text('For '+ widget.child.name),
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