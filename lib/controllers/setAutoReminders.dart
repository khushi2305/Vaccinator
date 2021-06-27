import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vaccinator_two/data/child.dart' ;
import 'package:flutter/material.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

class Reminders {
  FlutterLocalNotificationsPlugin fltrNotification;
  Child child ;
  String _selectedParam;
  String task;
  int val;


  Reminders(Child bachha ) {
    child = new Child(bachha.name , bachha.dob , bachha.gender , bachha.photo ) ;
    child.events = bachha.events ;
    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =
    new InitializationSettings( androidInitilize, iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future showNotification() async {
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
    new NotificationDetails(androidDetails,
         iOSDetails);

    int ind = 0 ;
    // tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation('Europe/Warsaw'));
    // var currentDateTime = tz.TZDateTime.now().add(const Duration(hours: 10));
    child.events.forEach((k, v) {
      ind++;
      var scheduledTime = child.dob ;
      //fltrNotification.zonedSchedule(ind, "Vaccine Reminder for "+ child.name ,"Its time to vaccinate your child", scheduledTime, generalNotificationDetails);
      fltrNotification.schedule(ind, "Vaccine Reminder for "+ child.name ,"Its time to vaccinate your child", scheduledTime, generalNotificationDetails);

    });
    }

  Future notificationSelected(String payload) async {
    // Do something
  }
}