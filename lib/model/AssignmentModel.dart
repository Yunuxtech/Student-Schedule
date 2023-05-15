import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentModel {

  late String assignmentId;
  late String courseCode;
  late String date;
  late String topic;


  AssignmentModel(
    this.assignmentId,
    this.courseCode,
    this.date,
    this.topic,
  );

  AssignmentModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}){
    assignmentId = documentSnapshot.id;
    courseCode = documentSnapshot.get('courseCode') as String;
    date = documentSnapshot.get('date') as String;
    topic = documentSnapshot.get('topic') as String;
  }


}