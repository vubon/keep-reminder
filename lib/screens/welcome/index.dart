import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'welcomeAnmation.dart';

class WelcomeScreen extends StatefulWidget{
	const WelcomeScreen({Key key}) : super(key: key);
	@override
	_WelcomeScreenState createState() => new _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

	@override
	initState() {
		super.initState();
	}

	void _button(){

	}

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
			backgroundColor: Colors.blueGrey,
			body: new Center(
				child: new Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						new Text('Welcome to Keep Remainder'),
						new Container(
							child: new RaisedButton(
									onPressed: (){
										Navigator.of(context).pushNamed("/home");
									},
									color: Colors.deepPurpleAccent,
									textColor: Colors.white,
									child: new Text('Open GPS'),
							),
							padding: const EdgeInsets.all(10.0),
						)
					],
				),
			),
		);
	}
}