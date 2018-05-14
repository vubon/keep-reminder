import 'package:keep_reminder/routes.dart';

//import 'dart:async';
//import 'dart:io' show Platform;
//
//import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
//
//import 'package:keep_reminder/screens/home/index.dart';

//Future<void> main() async {
//  final FirebaseApp app = await FirebaseApp.configure(
//    name: 'vubon-1e8fe',
//    options: Platform.isIOS
//        ? const FirebaseOptions(
//      googleAppID: '1:297855924061:ios:c6de2b69b03a5be8',
//      gcmSenderID: '297855924061',
//      databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
//    )
//        : const FirebaseOptions(
//      googleAppID: '1:977145270517:android:627364a7ac072030',
//      apiKey: 'AIzaSyAq2grcD0xmkzpyJx4f2EfTx_4qS0LyVdw',
//      databaseURL: 'https://vubon-1e8fe.firebaseio.com',
//    ),
//  );
//  runApp(new MaterialApp(
//    title: 'Flutter Database Example',
//    home: new HomeScreen(app: app),
//    theme: new ThemeData(
//      accentColor: Colors.redAccent,
//      primarySwatch: Colors.red,
//    ),
//    debugShowCheckedModeBanner: false,
//  ));
//}


void main() {
  new Routes();
}