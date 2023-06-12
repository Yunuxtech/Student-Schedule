import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/database.dart';

class ExamsPage extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ExamsPage(this.auth, this.firestore);
  @override
  _ExamsPageState createState() => _ExamsPageState();
}

class _ExamsPageState extends State<ExamsPage> {
  final _courseCodeController = TextEditingController();
  final _venueController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _messageController = TextEditingController();
  List<Card> _examcard = [];

  @override
  void dispose() {
    _courseCodeController.dispose();
    _venueController.dispose();
    _dateController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
      setState(() {
        final time = DateTime(2000, 1, 1, picked.hour, picked.minute);
        final timeString =
            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
        _timeController.text = timeString;
      });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Exam'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _courseCodeController,
                  decoration: InputDecoration(
                    hintText: 'Course Code',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _venueController,
                  decoration: InputDecoration(
                    hintText: 'Venue',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _dateController,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    await _selectDate(context);
                  },
                  decoration: InputDecoration(
                    hintText: 'Date',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _timeController,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    await _selectTime(context);
                  },
                  decoration: InputDecoration(
                    hintText: 'Time',
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
                  String course = _courseCodeController.text;
                  String venue = _venueController.text;
                  String date = _dateController.text;
                  String time = _timeController.text;

                  final String userId = widget.auth.currentUser!.uid;

                  final data = <String, dynamic>{
                    "courseCode": course,
                    "venue": venue,
                    "date": date,
                    "time": time,
                    "userId": userId,
                  };
                  DocumentReference value =
                      await Database(widget.firestore).addData(data, "exams");

                  if (value.id != null) {
                    print("Success");
                    AnimatedSnackBar.rectangle(
                      'Success',
                      'Exam Added',
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
                // Perform the desired action here
                String title = _courseCodeController.text;
                String description = _venueController.text;
                String date = _dateController.text;
                String time = _timeController.text;

                _courseCodeController.clear();
                _venueController.clear();
                _dateController.clear();
                _timeController.clear();

                Card newCard = Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.brown),
                          ),
                          Text(
                            date,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.redAccent),
                          ),
                          Text(
                            time,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                          PopupMenuButton(
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem(
                                  child: Text('Edit'),
                                  value: "Edit",
                                ),
                                PopupMenuItem(
                                  child: Text('Delete'),
                                  value: "Delete",
                                ),
                              ];
                            },
                            onSelected: (value) {
                              // Do something when an option is selected
                              if (value == 'Edit') {
                                _showDialog();
                                // navigateToEditPage(item);
                              } else if (value == 'delete') {
                                // deleteById(id);
                                dispose();
                              }
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            description,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.green),
                          ),
                        ],
                      )
                    ],
                  ),
                ));
                setState(() {
                  _examcard.add(newCard);
                });
                // You can now use the values of the text fields as needed
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: _examcard,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
