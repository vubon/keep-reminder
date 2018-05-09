import 'package:flutter/material.dart';
import 'package:keep_reminder/screens/welcome/index.dart';
import 'package:keep_reminder/screens/home/index.dart';

class Routes {
	Routes() {
		runApp(new MaterialApp(
			title: "Keep Remainder",
			debugShowCheckedModeBanner: false,
			home: new WelcomeScreen(),
			theme: new ThemeData(
				primarySwatch: Colors.red,
			),
			onGenerateRoute: (RouteSettings settings) {
				switch (settings.name) {
					case '/welcome':
						return new MyCustomRoute(
							builder: (_) => new WelcomeScreen(),
							settings: settings,
						);

					case '/home':
						return new MyCustomRoute(
							builder: (_) => new HomeScreen(),
							settings: settings,
						);
				}
			},
		));
	}
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
	MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
			: super(builder: builder, settings: settings);

	@override
	Widget buildTransitions(BuildContext context, Animation<double> animation,
			Animation<double> secondaryAnimation, Widget child) {
		if (settings.isInitialRoute) return child;
		return new FadeTransition(opacity: animation, child: child);
	}
}
