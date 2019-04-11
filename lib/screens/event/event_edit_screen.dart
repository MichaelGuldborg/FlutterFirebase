import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:flutter_firebase_app/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventEditScreen extends StatefulWidget {
  final FirebaseUser currentUser;

  EventEditScreen({this.currentUser});

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
      ),
      body: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration.collapsed(hintText: 'Title'),
              onSubmitted: (t) => _handleSubmit(),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration.collapsed(hintText: 'Description'),
              onSubmitted: (t) => _handleSubmit(),
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration.collapsed(hintText: 'Date'),
              onSubmitted: (t) => _handleSubmit(),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration.collapsed(hintText: 'Time'),
              onSubmitted: (t) => _handleSubmit(),
            ),
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        Text('Welcome ${widget.currentUser?.displayName}!')
      ],
    );
  }
}