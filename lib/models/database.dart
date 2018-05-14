import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class Database {
  static Future<String> createKeep() async {
    String accountKey = await _getAccountKey();

    var keep = <String, dynamic>{
      'title': '',
      'location': '',
      'note': '',
      'date_time': '',
      'lat': '',
      'lng': ''
    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child('account')
        .child(accountKey)
        .child('keeps')
        .push();

    reference.set(keep);
    return reference.key;
  }
}

Future<String> _getAccountKey() async{
  return '123456789';
}

