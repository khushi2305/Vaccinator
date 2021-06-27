import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotifPage extends StatefulWidget {
  @override
  _NotifPageState createState() => _NotifPageState();
}

class _NotifPageState extends State {
  FlutterLocalNotificationsPlugin fltrNotification;
  String _selectedParam;
  String task;
  int val;

  @override
  void initState() {
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =
    new InitializationSettings( androidInitilize,  iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Desi programmer", "This is my channel",
        importance: Importance.Max ,
        color: Colors.lightBlueAccent[50],
        enableLights: true,
        enableVibration: true,
        playSound: true,
        timeoutAfter: 5000,
        styleInformation: MediaStyleInformation(
            htmlFormatContent: true, htmlFormatTitle: true)
    );
    var iOSDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
    new NotificationDetails(androidDetails,iOSDetails); // android: iOS:

    // await fltrNotification.show(
    //     0, "Task", "You created a Task", generalNotificationDetails, payload: "Task");
    var scheduledTime;
    if (_selectedParam == "Hour") {
      scheduledTime = DateTime.now().add(Duration(hours: val));
    } else if (_selectedParam == "Minute") {
      scheduledTime = DateTime.now().add(Duration(minutes: val));
    } else {
      scheduledTime = DateTime.now().add(Duration(seconds: val));
    }

    //fltrNotification.zonedSchedule(1, "Vaccine Reminder", "Its time to vaccinate your child ", scheduledTime, generalNotificationDetails);
    fltrNotification.schedule
      (
        1, "Vaccine Reminder", task, scheduledTime, generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                onChanged: (_val) {
                  task = _val;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton(
                  value: _selectedParam,
                  items: [
                    DropdownMenuItem(
                      child: Text("Seconds"),
                      value: "Seconds",
                    ),
                    DropdownMenuItem(
                      child: Text("Minutes"),
                      value: "Minutes",
                    ),
                    DropdownMenuItem(
                      child: Text("Hour"),
                      value: "Hour",
                    ),
                  ],
                  hint: Text(
                    "Select Time.",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onChanged: (_val) {
                    setState(() {
                      _selectedParam = _val;
                    });
                  },
                ),
                DropdownButton(
                  value: val,
                  items: [
                    DropdownMenuItem(
                      child: Text("1"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("2"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text("3"),
                      value: 3,
                    ),
                    DropdownMenuItem(
                      child: Text("4"),
                      value: 4,
                    ),
                  ],
                  hint: Text(
                    "Select Value",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onChanged: (_val) {
                    setState(() {
                      val = _val;
                    });
                  },
                ),
              ],
            ),
            RaisedButton(
              onPressed: _showNotification,
              child: new Text('Set Reminder'),
            )
          ],
        ),
      ),
    );
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification Clicked $payload"),
      ),
    );
  }
}