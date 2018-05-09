import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';

class HomeScreen extends StatefulWidget{
	HomeScreen({Key key, this.title}) : super(key: key);
	final String title;

	@override
	_HomeScreenState createState() => new _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
	Animation<double> containerGrowAnimation;
	AnimationController _screenController;
	AnimationController _buttonController;
	Animation<double> buttonGrowAnimation;
	Animation<double> listTileWidth;
	Animation<Alignment> listSlideAnimation;
	Animation<Alignment> buttonSwingAnimation;
	Animation<EdgeInsets> listSlidePosition;
	Animation<Color> fadeScreenAnimation;

	int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
	    appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        title: new Text('Welcome to Keep Remainder'),
      ),

	    // create sidebar menu
	    drawer: new Drawer(
			    child: new ListView(
				    children: <Widget>[
					    new UserAccountsDrawerHeader(
						    accountName: new Text("Vubon Roy"),
						    accountEmail: new Text("vubon.roy@gmail.com"),
						    currentAccountPicture: new CircleAvatar(
							    backgroundColor: Colors.redAccent,
							    backgroundImage: new AssetImage('assets/images/vubon.jpg'),
						    ),
						    decoration: new BoxDecoration(color: Colors.redAccent),
					    ),
					    new ListTile(
						    title: new Text('Bill Pay', style: new TextStyle(color: Colors.black)),
						    trailing: new Icon(Icons.payment, color: Colors.black,),
						    onTap: () {
							    Navigator.of(context).pop();
							    Navigator.of(context).pushNamed("/BillPay");
						    },
					    ),
					    new ListTile(
						    title: new Text('Send Money', style: new TextStyle(color: Colors.black)),
						    trailing: new Icon(Icons.send, color: Colors.black,),
						    onTap: () {
							    Navigator.of(context).pop();
							    Navigator.of(context).pushNamed("/SendMoney");
						    },
					    ),
					    new ListTile(
						    title: new Text('Balance', style: new TextStyle(color: Colors.black)),
						    trailing: new Icon(Icons.attach_money, color: Colors.black),
						    onTap: () {
							    Navigator.of(context).pop();
							    Navigator.of(context).pushNamed("/Balance");
						    },
					    ),
					    new Divider(color: Colors.black,),
					    new ListTile(
						    title: new Text('Close', style: new TextStyle(color: Colors.black)),
						    trailing: new Icon(Icons.close, color: Colors.black,),
						    onTap: ()=> Navigator.of(context).pop(),
					    ),

				    ],
			    )
	    ),

	    body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
				backgroundColor: Colors.redAccent,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
