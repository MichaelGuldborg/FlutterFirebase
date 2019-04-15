import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/services/auth.dart';

class EventEditScreen extends StatefulWidget {
  @override
  _EventEditScreenState createState() => _EventEditScreenState();
}

class _EventEditScreenState extends State<EventEditScreen> {
  final DatabaseReference _eventRef =
      FirebaseDatabase.instance.reference().child('events');

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  void _handleSubmit() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final date = _dateController.text.trim();
    final time = _timeController.text.trim();

    final event = {
      "title": title,
      "description": description,
      "time": "$date $time",
    };

    _eventRef.push().set(event);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseUser currentUser = auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Title'),
              onSubmitted: (t) => _handleSubmit(),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(hintText: 'Description'),
              onSubmitted: (t) => _handleSubmit(),
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(hintText: 'Date'),
              onSubmitted: (t) => _handleSubmit(),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(hintText: 'Time'),
              onSubmitted: (t) => _handleSubmit(),
            ),
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[Text('Welcome ${currentUser?.email}!')],
    );
  }
}
