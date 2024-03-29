import 'package:Student_schedule/model/LectureModel.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';

class LectureCard extends StatefulWidget {
  final LectureModel lecture;
  final FirebaseFirestore firestore;
  final String uid;

  const LectureCard(
      {super.key,
      required this.lecture,
      required this.firestore,
      required this.uid});

  @override
  State<LectureCard> createState() => _LectureCardState();
}

class _LectureCardState extends State<LectureCard> {
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
                widget.lecture.courseCode,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.redAccent),
              ),
              Text(
                widget.lecture.time,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              GestureDetector(
                onTap: () {
                  print(widget.lecture.lectureId);
                  Database(widget.firestore)
                      .deleteDocument(widget.lecture.lectureId, "lectures");
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
                widget.lecture.venue,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                width: 100,
              ),
              Text(
                widget.lecture.day,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
