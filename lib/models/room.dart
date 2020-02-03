import 'package:firebase_database/firebase_database.dart';

class Room {
  String key;
  String room;
  String status;

  Room(this.room, this.status);

  Room.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
//        room = snapshot.value["roomname"],
        status = snapshot.value["status"];

  toJson() {
    return {
      "status": status,
    };
  }
}