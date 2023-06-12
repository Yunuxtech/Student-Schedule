import 'package:Student_schedule/Toast.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';

class NotesPage extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  NotesPage(this.auth, this.firestore);
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();

  List<Card> _notesContainer = [];

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          child: AlertDialog(
            title: Text('Add a Note'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Course Code',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _messageController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Note',
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Save'),
                onPressed: () async {
                  try {
                    // Perform the desired action here
                    String title = _titleController.text;
                    String message = _messageController.text;

                    final String userId = widget.auth.currentUser!.uid;

                    final data = <String, dynamic>{
                      "courseCode": title,
                      "message": message,
                      "userId": userId,
                    };
                    DocumentReference value =
                        await Database(widget.firestore).addData(data, "notes");
                    if (value.id != null) {
                      print("Success");
                      AnimatedSnackBar.rectangle(
                        'Success',
                        'Note Added',
                        type: AnimatedSnackBarType.success,
                        brightness: Brightness.light,
                        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                      ).show(
                        context,
                      );
                    } else {
                      print("Error");
                      AnimatedSnackBar.rectangle(
                        'Error',
                        'Ooops, something went wrong',
                        type: AnimatedSnackBarType.error,
                        brightness: Brightness.light,
                        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                      ).show(
                        context,
                      );
                    }
                    // Navigator.of(context).pop();
                  } catch (e) {
                    print("Encountered an error: $e");
                    AnimatedSnackBar.rectangle(
                      'Error',
                      '$e',
                      type: AnimatedSnackBarType.info,
                      brightness: Brightness.light,
                      mobileSnackBarPosition: MobileSnackBarPosition
                          .bottom, // Position of snackbar on mobile devices
                      // desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
                    ).show(
                      context,
                    );
                    // Navigator.of(context).pop();
                  }

                  _titleController.clear();
                  _messageController.clear();

                  Card newCard = Card(
                      // child: ListTile(
                      //   title: Text(title),
                      //   subtitle: Text(message),
                      // ),
                      );
                  setState(() {
                    // Add the new card to the container
                    _notesContainer.add(newCard);
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: _notesContainer
                  .map((notesContainer) => new Card(
                        child: ListTile(
                          title: Text(_titleController.text),
                          subtitle: Text(_messageController.text),
                        ),
                      ))
                  .toList(),
            ),
            // Other widgets can be added here as well
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
