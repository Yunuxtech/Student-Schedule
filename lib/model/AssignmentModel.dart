import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentModel {

  late String assignmentId;
  late String courseCode;
  late String date;
  late String assignment;


  AssignmentModel(
    this.assignmentId,
    this.courseCode,
    this.date,
    this.assignment,
  );

  AssignmentModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}){
    assignmentId = documentSnapshot.id;
    courseCode = documentSnapshot.get('courseCode') as String;
    date = documentSnapshot.get('date') as String;
    assignment = documentSnapshot.get('assignment') as String;
  }


}