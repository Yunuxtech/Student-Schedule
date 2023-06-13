import 'package:Student_schedule/model/AssignmentModel.dart';
import 'package:Student_schedule/model/LectureModel.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';

class AssignmentCard extends StatefulWidget {
  final AssignmentModel assignment;
  final FirebaseFirestore firestore;
  final String uid;

  const AssignmentCard(
      {super.key,
      required this.assignment,
      required this.firestore,
      required this.uid});

  @override
  State<AssignmentCard> createState() => _AssignmentCardState();
}

class _AssignmentCardState extends State<AssignmentCard> {
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
                widget.assignment.courseCode,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  // color: Color.fromARGB(31, 9, 9, 9),
                ),
              ),
              Text(
                widget.assignment.date,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
                  GestureDetector(
                onTap: () {
                  print(widget.assignment.assignmentId);
                  Database(widget.firestore)
                      .deleteDocument(widget.assignment.assignmentId, "assignments");
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
              Expanded(
                child: Container(
                  child: Text(
                    widget.assignment.assignment,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              // Text(
              //   widget.assignment.assignment,
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              // ),
            ],
          )
        ],
      ),
    ));
  }
}
