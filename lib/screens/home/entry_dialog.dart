import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:keep_reminder/models/note_entry.dart';

class KeepEntryDialog extends StatefulWidget {
  final String initialKeep;
  final KeepRemainder keepEntryToEdit;

  KeepEntryDialog.add(this.initialKeep) : keepEntryToEdit = null;

  KeepEntryDialog.edit(this.keepEntryToEdit)
      : initialKeep = keepEntryToEdit.location;

  @override
  KeepEntryDialogState createState() {
    if (keepEntryToEdit != null) {
      return new KeepEntryDialogState(
          keepEntryToEdit.title,
          keepEntryToEdit.location,
          keepEntryToEdit.dateTime,
          keepEntryToEdit.note
      );
    } else {
      return new KeepEntryDialogState(
          null,
          initialKeep,
          new DateTime.now(),
          null
      );
    }
  }
}

class KeepEntryDialogState extends State<KeepEntryDialog> {
  String _title;
  String _location;
  DateTime _dateTime = new DateTime.now().toLocal();
  String _note;

  TextEditingController _noteTextController;
  TextEditingController _titleTextController;

  KeepEntryDialogState(this._title, this._location, this._dateTime, this._note);

  Widget _createAppBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.redAccent,
      title: widget.keepEntryToEdit == null
          ? const Text("New entry")
          : const Text("Edit entry"),
      actions: [
        new FlatButton(
          onPressed: () {
            Navigator
                .of(context)
                .pop(new KeepRemainder(_title, _location, _dateTime, _note));
          },
          child: new Text('SAVE',
              style: Theme
                  .of(context)
                  .textTheme
                  .subhead
                  .copyWith(color: Colors.white)),
        ),
      ],
    );
  }


  @override
  void initState() {
    super.initState();
    _noteTextController = new TextEditingController(text: _note);
    _titleTextController = new TextEditingController(text: _note);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _createAppBar(context),
      body: new Column(
        children: [
          new ListTile(
            leading: new Icon(Icons.title, color: Colors.grey[500]),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: 'Title',
              ),
              controller: _titleTextController,
              onChanged: (value) => _title = value,
            ),
          ),

          new ListTile(
            leading: new Image.asset(
              "assets/images/map.png",
              color: Colors.grey[500],
              height: 24.0,
              width: 24.0,
            ),
            title: new Text(
              "$_location",
            ),
            onTap: () => _showWeightPicker(context),
          ),

          new ListTile(
            leading: new Icon(Icons.today, color: Colors.grey[500]),
            title: new DateTimeItem(
              dateTime: _dateTime,
              onChanged: (dateTime) => setState(() => _dateTime = dateTime),
            ),
          ),

          new ListTile(
            leading: new Icon(Icons.speaker_notes, color: Colors.grey[500]),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: 'Optional note',
              ),
              controller: _noteTextController,
              autofocus: true,
              maxLines: null,
              onChanged: (value) => _note = value,
            ),
          ),
        ],
      ),
    );
  }

  _showWeightPicker(BuildContext context) {
    showDialog(
      context: context,
//      child: new NumberPickerDialog.decimal(
//        minValue: 1,
//        maxValue: 150,
//        initialDoubleValue: _weight,
//        title: new Text("Enter your weight"),
//      ),
    ).then((value) {
      if (value != null) {
        setState(() => _location = value);
      }
    });
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
              child: new Text('$time'),
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