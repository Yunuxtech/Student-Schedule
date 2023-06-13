import 'package:Student_schedule/model/AssignmentModel.dart';
import 'package:Student_schedule/model/LectureModel.dart';
import 'package:Student_schedule/model/TestModel.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';

class TestCard extends StatefulWidget {
  final TestModel test;
  final FirebaseFirestore firestore;
  final String uid;

  const TestCard(
      {super.key,
      required this.test,
      required this.firestore,
      required this.uid});

  @override
  State<TestCard> createState() => _TestCardState();
}

class _TestCardState extends State<TestCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.test.courseCode,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.brown),
              ),
              Text(
                widget.test.date,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.redAccent),
              ),
              Text(
                widget.test.time,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              GestureDetector(
                onTap: () {
                  print(widget.test.testId);
                  Database(widget.firestore)
                      .deleteDocument(widget.test.testId, "tests");
                  AnimatedSnackBar.rectangle(
                    'Delete',
                    'Record Deleted',
                    type: AnimatedSnackBarType.info,
                    brightness: Brightness.light,
                    mobileSnackBarPosition: MobileSnackBarPosition
                        .bottom, // Position of snackbar on mobile devices
                    // desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
                  ).show(
                    context,
                  );
                  // Add your delete logic here
                  // For example, you can call a function to delete the note
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                widget.test.venue,
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
  }
}
