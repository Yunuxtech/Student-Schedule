import 'package:Student_schedule/drawer/ExamCard.dart';
import 'package:Student_schedule/model/ExamModel.dart';
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

               
                // setState(() {
                //   _examcard.add(newCard);
                // });
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
      body: StreamBuilder(
        stream: Database(widget.firestore)
            .streamDataExam(widget.auth.currentUser!.uid),
        builder: (BuildContext context,
            AsyncSnapshot<List<ExamModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("You don't have any Test"),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                return ExamCard(
                  firestore: widget.firestore,
                  uid: widget.auth.currentUser!.uid,
                  exam: snapshot.data![index],
                );
              },
            );
          } else {
            return const Center(
              child: Text("loading..."),
            );
          } 
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
