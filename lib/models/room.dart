import 'package:firebase_database/firebase_database.dart';

class Room {
  String key;
  String name;
  String status;

  Room(this.name, this.status);

  Room.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        name = snapshot.value["name"],
        status = snapshot.value["status"];

  toJson() {
    return {
      "name": name,
      "status": status,
    };
  }
}