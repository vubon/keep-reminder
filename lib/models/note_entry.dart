import 'package:firebase_database/firebase_database.dart';

class KeepReminder {
  String key;
  String title;
  String location;
  String lat;
  String lng;
  DateTime dateTime;
  String note;

  KeepReminder(
      this.title,
      this.location,
      this.lat,
      this.lng,
      this.dateTime,
      this.note);

  KeepReminder.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value["title"],
        location = snapshot.value["location"],
        lat = snapshot.value["lat"],
        lng = snapshot.value["lng"],
        dateTime = snapshot.value["dateTime"],
        note = snapshot.value["note"];

  toJson() {
    return {
      "title": title,
      "location": location,
      "lat": lat,
      "lng": lng,
      "dateTime": dateTime,
      "note": note,
    };
  }
}
