import 'package:Student_schedule/model/AssignmentModel.dart';
import 'package:Student_schedule/model/ExamModel.dart';
import 'package:Student_schedule/model/LectureModel.dart';
import 'package:Student_schedule/model/TestModel.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';

class ExamCard extends StatefulWidget {
  final ExamModel exam;
  final FirebaseFirestore firestore;
  final String uid;

  const ExamCard(
      {super.key,
      required this.exam,
      required this.firestore,
      required this.uid});

  @override
  State<ExamCard> createState() => _ExamCardState();
}

class _ExamCardState extends State<ExamCard> {
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
                widget.exam.courseCode,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.brown),
              ),
              Text(
                widget.exam.date,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.redAccent),
              ),
              Text(
                widget.exam.time,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              GestureDetector(
                onTap: () {
                  print(widget.exam.examId);
                  Database(widget.firestore)
                      .deleteDocument(widget.exam.examId, "exams");
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
                widget.exam.venue,
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
