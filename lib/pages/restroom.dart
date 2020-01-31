import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

import 'package:swdc_in/models/room.dart';

class RestRoomRoute extends StatefulWidget {

  RestRoomRoute({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}


class _HomePageState extends State<RestRoomRoute> {

  List<Room> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  StreamSubscription<Event> _onTodoAddedSubscription;

  StreamSubscription<Event> _onTodoChangedSubscription;

  Query _todoQuery;

  @override
  void initState() {
    super.initState();

    //_checkEmailVerification();

    _todoList = new List();
    _todoQuery = _database
        .reference()
        .child("room");
    _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(onEntryAdded);
    _onTodoChangedSubscription =
        _todoQuery.onChildChanged.listen(onEntryChanged);
  }


  @override
  void dispose() {
    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event) {
    var oldEntry = _todoList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _todoList[_todoList.indexOf(oldEntry)] =
          Room.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _todoList.add(Room.fromSnapshot(event.snapshot));
    });
  }


  Widget showTodoList() {
    if (_todoList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _todoList.length,
          itemBuilder: (BuildContext context, int index) {
            String todoId = _todoList[index].key;
            String room = _todoList[index].room;
            bool status = _todoList[index].status;

            return Dismissible(
              key: Key(todoId),
              background: Container(color: Colors.red),

              child: ListTile(
                title: Text(
                  room,
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: Switch(
                    value: status,
                    onChanged: null,
                    activeColor: Colors.blue,
                    activeTrackColor: Colors.green,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                    )
                        ,
              ),
            );
          });
    } else {
      return Center(
          child: Text(
            "Welcome. Your list is empty",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Rest Room'),
        ),
        body: showTodoList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }
}