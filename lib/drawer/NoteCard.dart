import 'package:Student_schedule/model/LectureModel.dart';
import 'package:Student_schedule/model/NoteModel.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';

class NoteCard extends StatefulWidget {
  final NoteModel note;
  final FirebaseFirestore firestore;
  final String uid;

  const NoteCard(
      {super.key,
      required this.note,
      required this.firestore,
      required this.uid});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
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
                widget.note.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  // color: Color.fromARGB(31, 9, 9, 9),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print(widget.note.noteId);
                  Database(widget.firestore)
                      .deleteDocument(widget.note.noteId, "notes");
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
                    widget.note.content,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
