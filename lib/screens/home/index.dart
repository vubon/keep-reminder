import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:keep_reminder/models/note_entry.dart';
import 'entry_dialog.dart';
import 'keep_entry.dart';

class HomeScreen extends StatefulWidget{
	HomeScreen({Key key, this.title, this.app}) : super(key: key);
	final String title;
	final FirebaseApp app;

	@override
	_HomeScreenState createState() => new _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {

	List<KeepReminder> keepSaves = new List();
	KeepReminder keep;
	DatabaseReference keepRef;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

	@override
	void initState() {
		super.initState();
		// keep = KeepReminder("", "", "","", DateTime, "");
		final FirebaseDatabase database = FirebaseDatabase(app:widget.app);
		keepRef = database.reference().child('keeps');
		keepRef.onChildAdded.listen(_onEntryAdded);
		keepRef.onChildChanged.listen(_onEntryChanged);
	}

	_onEntryAdded(Event event) {
		setState(() {
			keepSaves.add(KeepReminder.fromSnapshot(event.snapshot));
		});
	}

	_onEntryChanged(Event event) {
		var old = keepSaves.singleWhere((entry) {
			return entry.key == event.snapshot.key;
		});
		setState(() {
			keepSaves[keepSaves.indexOf(old)] = KeepReminder.fromSnapshot(event.snapshot);
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

	    body: Column(
				children: <Widget>[
					Flexible(
						child: FirebaseAnimatedList(
							query: keepRef,
							itemBuilder: (BuildContext context, DataSnapshot snapshot,
									Animation<double> animation, int index) {

								return new ListTile(
									leading: Icon(Icons.message),
									title: Text(keepSaves[index].title, style: new TextStyle(color: Colors.red),),
									subtitle: Text(keepSaves[index].location),
								);
							},
						),
					),
				],
	    ),


      floatingActionButton: new FloatingActionButton(
				backgroundColor: Colors.redAccent,
        onPressed: (){
					Navigator.push(
						context,
						new MaterialPageRoute(builder: (context) => new KeepEntry())
					);
				},
        tooltip: 'Add new keep',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

	void _addKeepSave(keep) {
		setState(() {
			var title = keep.title.toString();
			var location = keep.location.toString();
			var dateTime = keep.dateTime.toString();
			var note = keep.note.toString();
			var lat = keep.lat.toString();
			var lng = keep.lng.toString();
			Map data = {
				"title": title,
				"location": location,
				"dateTime": dateTime,
				"note": note,
				"lat": lat,
				"lng": lng
			};
			keepRef.push().set(keep.toJson());
		});
	}


	Future _openAddEntryDialog() async {
		KeepReminder save =
		await Navigator.of(context).push(new MaterialPageRoute<KeepReminder>(
				builder: (BuildContext context) {
					return new KeepEntryDialog.add(
							keepSaves.isNotEmpty ? keepSaves.last.location: 'Enter your location');
				},
				fullscreenDialog: true));
		if (save != null) {
			_addKeepSave(save);
		}
	}

}
