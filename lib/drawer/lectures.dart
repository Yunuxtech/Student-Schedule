import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../alarmFunctions/scheduleRepeatingAlarm.dart';
import '../services/database.dart';

class LecturesPage extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  LecturesPage(this.auth, this.firestore);

  // get auth => null;

  @override
  _LecturesPageState createState() => _LecturesPageState();
}

class _LecturesPageState extends State<LecturesPage> {
  final _titleController = TextEditingController();
  final _venueController = TextEditingController();
  final _timeController = TextEditingController();
  String? _selectedDay;
  List<Card> _lecturecard = [];

  final NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    // Get the user ID and save it to a variable
    final String userId = widget.auth.currentUser!.uid;
    print('User ID: $userId');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _venueController.dispose();
    _timeController.dispose();
    super.dispose();
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
          title: Text('Add Lectures'),
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
                  controller: _venueController,
                  decoration: InputDecoration(
                    hintText: 'Venue',
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
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedDay,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedDay = newValue;
                    });
                  },
                  items: [
                    DropdownMenuItem<String>(
                      value: 'Monday',
                      child: Text('Monday'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Tuesday',
                      child: Text('Tuesday'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Wednesday',
                      child: Text('Wednesday'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Thursday',
                      child: Text('Thursday'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Friday',
                      child: Text('Friday'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Saturday',
                      child: Text('Saturday'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Sunday',
                      child: Text('Sunday'),
                    ),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Select a day',
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
                  String title = _titleController.text;
                  String _venue = _venueController.text;
                  String _time = _timeController.text;
                  final String userId = widget.auth.currentUser!.uid;

                  int alarmId = 1;
                  String alarmTitle = 'Morning Alarm';
                  TimeOfDay alarmTime = TimeOfDay(hour: 12, minute: 35);
                  int repeatDayOfWeek = DateTime.monday; // Example: Monday

                  notificationService.scheduleRepeatingAlarm(
                      alarmId, alarmTitle, alarmTime, repeatDayOfWeek,);

                  final data = <String, dynamic>{
                    "courseCode": title,
                    "venue": _venue,
                    "time": _time,
                    "day": _selectedDay,
                    "userId": userId,
                  };
                  print(alarmTime);
                  print(repeatDayOfWeek);

                  DocumentReference value = await Database(widget.firestore)
                      .addData(data, "lectures");
                  if (value.id != null) {
                    print("Success");
                    AnimatedSnackBar.rectangle(
                      'Success',
                      'Lecture Added',
                      type: AnimatedSnackBarType.success,
                      brightness: Brightness.light,
                      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                    ).show(
                      context,
                    );
                  }
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
                }
                String title = _titleController.text;
                String _venue = _venueController.text;
                String _time = _timeController.text;
                final String userId = widget.auth.currentUser!.uid;

                final data = <String, dynamic>{
                  "courseCode": title,
                  "venue": _venue,
                  "time": _time,
                  "day": _selectedDay,
                  "userId": userId,
                };
                _titleController.clear();
                _venueController.clear();
                _timeController.clear();
                setState(() {
                  _selectedDay = null;
                });
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
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                          Text(
                            _time,
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
                              }
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            _venue,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                        ],
                      )
                    ],
                  ),
                ));

                setState(() {
                  _lecturecard.add(newCard);
                });
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
          children: _lecturecard,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: _showDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
