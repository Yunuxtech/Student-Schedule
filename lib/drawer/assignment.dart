import 'package:Student_schedule/drawer/AssignmentCard.dart';
import 'package:Student_schedule/model/AssignmentModel.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/database.dart';

class AssignmentsPage extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AssignmentsPage(this.auth, this.firestore);

  @override
  _AssignmentPageState createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentsPage> {
  final _courseCose = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _givenAssignmentController = TextEditingController();
  List<Card> _assignmentcard = [];

  @override
  void dispose() {
    _courseCose.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _givenAssignmentController.dispose();
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

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Assignment'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _courseCose,
                  decoration: InputDecoration(
                    hintText: 'Course Code',
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
                TextField(
                  controller: _givenAssignmentController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Given Assignment',
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
                  String title = _courseCose.text;
                  String date = _dateController.text;
                  String assignment = _givenAssignmentController.text;

                  final String userId = widget.auth.currentUser!.uid;

                  final data = <String, dynamic>{
                    "courseCode": title,
                    "date": date,
                    "assignment": assignment,
                    "userId": userId,
                  };

                  DocumentReference value = await Database(widget.firestore)
                      .addData(data, "assignments");

                  if (value.id != null) {
                    print("Success");
                    AnimatedSnackBar.rectangle(
                      'Success',
                      'Assignment Added',
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
                }
                _givenAssignmentController.clear();
                _dateController.clear();
                _courseCose.clear();

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
            .streamDataAssignment(widget.auth.currentUser!.uid),
        builder: (BuildContext context,
            AsyncSnapshot<List<AssignmentModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("You don't have any assignments"),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                return AssignmentCard(
                  firestore: widget.firestore,
                  uid: widget.auth.currentUser!.uid,
                  assignment: snapshot.data![index],
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
