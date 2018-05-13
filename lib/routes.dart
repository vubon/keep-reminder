import 'package:flutter/material.dart';
import 'package:keep_reminder/screens/welcome/index.dart';
import 'package:keep_reminder/screens/home/index.dart';

class Routes {
	var routes = <String, WidgetBuilder>{
		"/home": (BuildContext context) => new HomeScreen()
	};

	Routes() {
		runApp(new MaterialApp(
			title: "Keep Remainder",
			debugShowCheckedModeBanner: false,
			home: new WelcomeScreen(),
			theme: new ThemeData(
				primarySwatch: Colors.red,
				accentColor: Colors.redAccent,
			),
			routes: routes,
		));
	}
}
