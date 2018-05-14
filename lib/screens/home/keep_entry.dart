import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:flutter_google_places_autocomplete/flutter_google_places_autocomplete.dart';

import 'package:keep_reminder/key/keys.dart';

// google map API key called
final homeScaffoldKey = new GlobalKey<ScaffoldState>();
GoogleMapsPlaces _places = new GoogleMapsPlaces(kGoogleApiKey);

class KeepEntry extends StatefulWidget{
  KeepEntry({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _KeepEntryState createState() => new _KeepEntryState();
}

class _KeepEntryState extends State<KeepEntry>{

  String _title;
  String _note;
  String _location = 'Enter your location';
  DateTime _dateTime = DateTime.now();
  String _lat;
  String _lng;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController _noteTextController;
  TextEditingController _titleTextController;

  @override
  void initState() {
    _noteTextController = new TextEditingController(text: _note);
    _titleTextController = new TextEditingController(text: _title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        //key: homeScaffoldKey,
        title: new Text('New Keep'),
        actions: <Widget>[
          new FlatButton(
              onPressed: _saveData(),
              child: new Text(
                'Save',
                style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white),
              )
          )
        ],

      ),
      body: Column(
        children: <Widget>[
          new ListTile(
            leading: new Icon(Icons.title, color: Colors.redAccent,),
            title: new TextField(
              decoration: new InputDecoration(
                  hintText: 'Enter your title'
              ),
              controller: _titleTextController,
              onChanged: (value) => _title = value,
              autofocus: true,
            ),
          ),
          new ListTile(
            leading: new Icon(Icons.location_on, color: Colors.redAccent,),
            title: new Text("$_location"),
            onTap: () async {
              // show input autocomplete with selected mode
              // then get the Prediction selected
              Prediction p = await showGooglePlacesAutocomplete(
                context: context,
                apiKey: kGoogleApiKey,
                onError: (res) {
                  homeScaffoldKey.currentState.showSnackBar(
                      new SnackBar(content: new Text(res.errorMessage)));
                },
                mode: Mode.overlay,
                language: "en",
                //components: [new Component(Component.country, "bd")]
              );
              if (p != null){
                PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
                final lat = detail.result.geometry.location.lat;
                final lng = detail.result.geometry.location.lng;
                setState(() => _location = p.description);
                setState(() => _lat = lat.toString());
                setState(() => _lng = lng.toString());
              }
            },
          ),

          new ListTile(
            leading: new Icon(Icons.today, color: Colors.redAccent),
            title: new DateTimeItem(
              dateTime: _dateTime,
              onChanged: (dateTime) => setState(() => _dateTime = dateTime),
            ),
          ),

          new ListTile(
            leading: new Icon(Icons.speaker_notes, color: Colors.redAccent),
            title: new Text("Write your notes"),
          ),
          new Expanded(
              child: new Card(
                margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                child: new Padding(
                  padding: new EdgeInsets.all(8.0),
                  child: new TextField(
                    decoration: null,
                    controller: _noteTextController,
                    autofocus: true,
                    maxLines: null,
                    onChanged: (value) => _note = value,
                  ),
                ),
              )
          )

        ],
      ),
    );
  }

  // Save the Data
  _saveData() {
    print('$_title');
    print('$_location');
    print('$_lat');
    print('$_lng');
    print('$_note');
  }

}


class DateTimeItem extends StatelessWidget {
  DateTimeItem({Key key, DateTime dateTime, @required this.onChanged})
      : assert(onChanged != null),
        date = dateTime == null
            ? new DateTime.now()
            : new DateTime(dateTime.year, dateTime.month, dateTime.day),
        time = dateTime == null
            ? new DateTime.now()
            : new TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
        super(key: key);

  final DateTime date;
  final TimeOfDay time;
  final ValueChanged<DateTime> onChanged;


  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new InkWell(
            onTap: (() => _showDatePicker(context)),
            child: new Padding(
                padding: new EdgeInsets.symmetric(vertical: 8.0),
                child: new Text(new DateFormat('EEEE, MMMM d').format(date))),
          ),
        ),
        new InkWell(
          onTap: (() => _showTimePicker(context)),
          child: new Padding(
            padding: new EdgeInsets.symmetric(vertical: 8.0),
            child: new Text(time.format(context)),
          ),
        ),
      ],
    );
  }

  Future _showDatePicker(BuildContext context) async {
    DateTime dateTimePicked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date.subtract(const Duration(hours: 1)),
        lastDate: new DateTime.now().add(const Duration(days: 200000))
    );


    if (dateTimePicked != null) {
      onChanged(new DateTime(
          dateTimePicked.year,
          dateTimePicked.month,
          dateTimePicked.day,
          time.hour,
          time.minute)
      );
    }
  }

  Future _showTimePicker(BuildContext context) async {
    TimeOfDay timeOfDay = await showTimePicker(context: context, initialTime: time);
    print(new DateTime.now().toLocal());

    if (timeOfDay != null) {
      onChanged(new DateTime(
          date.year, date.month, date.day, timeOfDay.hour, timeOfDay.minute));
    }
  }
}