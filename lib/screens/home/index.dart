import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';

import 'package:keep_reminder/models/note_entry.dart';
import 'entry_dialog.dart';

class HomeScreen extends StatefulWidget{
	HomeScreen({Key key, this.title}) : super(key: key);
	final String title;

	@override
	_HomeScreenState createState() => new _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{

	List<KeepRemainder> keepSaves = new List();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // for animation
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

  void showDemoDialog<T>({ BuildContext context, Widget child }) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    )
        .then<void>((T value) { // The value passed to Navigator.pop() or null.
      if (value != null) {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: new Text('You selected: $value')
        ));
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
	    appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        title: new Text('Welcome to Keep Remainder'),
      ),

	    // create sidebar menu
	    drawer: new Drawer(
			    child: new ListView(
						padding: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
				    children: <Widget>[
//					    new UserAccountsDrawerHeader(
//						    accountName: new Text("Vubon Roy"),
//						    accountEmail: new Text("vubon.roy@gmail.com"),
//						    currentAccountPicture: new CircleAvatar(
//							    backgroundColor: Colors.redAccent,
//							    backgroundImage: new AssetImage('assets/images/vubon.jpg'),
//						    ),
//						    decoration: new BoxDecoration(color: Colors.redAccent),
//					    ),

					    new ListTile(
						    title: new Text("Today's Keeps", style: new TextStyle(color: Colors.black)),
						    // trailing: new Icon(Icons.payment, color: Colors.black,),
						    leading: new Icon(Icons.today),
						    onTap: () {
							    Navigator.of(context).pop();
							    Navigator.of(context).pushNamed("/BillPay");
						    },
					    ),
					    new ListTile(
						    title: new Text("Tomorrow's Keeps", style: new TextStyle(color: Colors.black)),
						    leading: new Icon(Icons.next_week, color: Colors.black,),
						    onTap: () {
							    Navigator.of(context).pop();
							    Navigator.of(context).pushNamed("/SendMoney");
						    },
					    ),
					    new Divider(color: Colors.black,),
					    new ListTile(
								title: new Text('Settings'),
								leading: new Icon(Icons.settings),
							),
					    new ListTile(
						    title: new Text('Close', style: new TextStyle(color: Colors.black)),
						    leading: new Icon(Icons.close, color: Colors.black,),
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
        onPressed:_openAddEntryDialog,
        tooltip: 'Add new keep',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


	Future _openAddEntryDialog() async {
		KeepRemainder save =
		await Navigator.of(context).push(new MaterialPageRoute<KeepRemainder>(
				builder: (BuildContext context) {
					return new KeepEntryDialog.add(
							keepSaves.isNotEmpty ? keepSaves.last.location: 'Enter your location');
				},
				fullscreenDialog: true));
		if (save != null) {
			//_addWeightSave(save);
		}
	}

}
