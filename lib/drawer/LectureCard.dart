import 'package:Student_schedule/model/LectureModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LectureCard extends StatefulWidget {

  final LectureModel lecture;
  final FirebaseFirestore firestore;
  final String uid;

  const LectureCard({super.key, required this.lecture, required this.firestore, required this.uid});

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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.redAccent),
              ),
              Text(
                widget.lecture.time,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                // },
                // onSelected: (value) {
                //   // Do something when an option is selected
                //   if (value == 'Edit') {
                //     _showDialog();
                //     // navigateToEditPage(item);
                //   } else if (value == 'delete') {
                //     // deleteById(id);
                //   }
                },
              ),
            ],
          ),
          Row(
            children: [
              Text(
                widget.lecture.venue,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
