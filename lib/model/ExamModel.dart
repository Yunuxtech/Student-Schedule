import 'package:cloud_firestore/cloud_firestore.dart';

class ExamModel {

  late String examId;
  late String courseCode;
  late String venue;
  late String date;
  late String time;


  ExamModel(
    this.examId,
    this.courseCode,
    this.venue,
    this.date,
    this.time,
  );

  ExamModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}){
    examId = documentSnapshot.id;
    courseCode = documentSnapshot.get('courseCode') as String;
    venue = documentSnapshot.get('venue') as String;
    date = documentSnapshot.get('date') as String;
    time = documentSnapshot.get('time') as String;
  }


}