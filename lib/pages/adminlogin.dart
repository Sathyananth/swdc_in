import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

import 'package:swdc_in/models/room.dart';

class AdminLoginRoute extends StatefulWidget {

  AdminLoginRoute({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}


class _HomePageState extends State<AdminLoginRoute> {

  List<Room> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  StreamSubscription<Event> _onTodoAddedSubscription;

  StreamSubscription<Event> _onTodoChangedSubscription;

  Query _todoQuery;

  @override
  void initState() {
    super.initState();

    //_checkEmailVerification();


    _database.reference().child("rr").once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });

    _todoList = new List();
    _todoQuery = _database
        .reference().child("rr");
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

  _updateTodo(Room room) {
    //Toggle completed

    if("open" == room.status)
      {
        room.status="closed";
      }
    else
      {
        room.status="open";
      }

    if (room != null) {
      _database.reference().child("todo").child(room.key).set(room.toJson());
    }
  }

  Widget showTodoList() {
    if (_todoList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _todoList.length,
          itemBuilder: (BuildContext context, int index) {
            String todoId = _todoList[index].key;
            String room = _todoList[index].name;
            String statusString = _todoList[index].status;

            bool status = false;

            if ("open" == statusString) {
              status = true;
            }
            else
              {
                status = false;
              }

            return Card(
                key: Key(todoId),
//              background: Container(color: Colors.red),

                child: ListTile(
                    title: Text(
                      room,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    trailing: Switch(
                        value: status,
                        onChanged: (value) {
                          setState(() {
//                            status = value;
                            if(value)
                              {
                                statusString = "open";
                              }
                            else
                              {
                                statusString = "closed";
                              }
                            print(value);
                            print(statusString);


                          });
                        },
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.green
                    )
                )
            );
          }
            );
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
          title: new Text('Admin'),
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