import 'package:flutter/material.dart';

import 'package:swdc_in/pages/mthome.dart';
import 'package:swdc_in/pages/adminlogin.dart';
import 'package:swdc_in/pages/restroom.dart';
import 'package:swdc_in/pages/carparking.dart';
import 'package:swdc_in/pages/appabout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final appTitle = 'SWDC-IN';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SWDC-IN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'SWDC-IN'),
        '/admin': (context) => AdminLoginRoute(),
        '/restroom': (context) => RestRoomRoute(),
        '/carparking': (context) => CarParkingRoute(),
        '/about': (context) => AppAboutRoute(),
      },
//      home: MyHomePage(title: appTitle),
    );
  }
}
