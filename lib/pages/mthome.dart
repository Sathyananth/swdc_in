import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {

  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title ?? 'SWDC-IN')),
      body: Center(child: Text('Welcome!')),
      drawer: Drawer(

        child: ListView(

          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text('Admin'),
              onTap: () {
                Navigator.pushNamed(context, '/admin');
              },
            ),
            ListTile(
              title: Text('Rest Room'),
              onTap: () {
                Navigator.pushNamed(context, '/restroom');
              },
            ),
            ListTile(
              title: Text('Car Parking'),
              onTap: () {
                Navigator.pushNamed(context, '/carparking');
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
    );
  }
}