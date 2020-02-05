import 'package:firebase_database/firebase_database.dart';

class CarParking {
  String key;
  String name;
  String status;

  CarParking(this.name, this.status);

  CarParking.fromSnapshot(DataSnapshot snapshot) :
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