import 'package:flutter/material.dart';
import 'package:vaccinator_two/pages/home.dart';
import 'package:vaccinator_two/pages/addChild.dart';
import 'package:vaccinator_two/pages/select_initial_reminders.dart';
import 'package:vaccinator_two/pages/calendar_view.dart';
import 'package:vaccinator_two/pages/login_screen.dart';
import 'package:vaccinator_two/pages/signUp_screen.dart';
import 'package:vaccinator_two/pages/localNotif.dart';
import 'package:vaccinator_two/pages/signUp_screen.dart' ;
import 'package:vaccinator_two/data/allChildren.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'VACCINATOR',
        initialRoute: '/signUp_screen',
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => MyHomePage(),
          '/addChild': (context) => AddChild(),
          '/allChildren': (context) => AllChildren(),
          '/select_initial_reminders' : (context) =>Select_Initial_Reminders(),
          '/calendar_view' : (context) => CalendarPage(),
          '/login_screen': (context) => LoginScreen(),
          '/signUp_screen': (context) => SignUpScreen(),
          '/localNotif':(context) =>NotifPage(),
        });
  }
}


