import 'package:cloud_firestore/cloud_firestore.dart';

class TestModel {

  late String testId;
  late String courseCode;
  late String venue;
  late String date;
  late String time;


  TestModel(
    this.testId,
    this.courseCode,
    this.venue,
    this.date,
    this.time,
  );

  TestModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}){
    testId = documentSnapshot.id;
    courseCode = documentSnapshot.get('courseCode') as String;
    venue = documentSnapshot.get('venue') as String;
    date = documentSnapshot.get('date') as String;
    time = documentSnapshot.get('time') as String;
  }


}