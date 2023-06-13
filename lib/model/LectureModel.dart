import 'package:cloud_firestore/cloud_firestore.dart';

class LectureModel {

  late String lectureId;
  late String courseCode;
  late String venue;
  late String time;
  late String day;
  // late List<String> days;

  LectureModel(
    this.lectureId,
    this.courseCode,
    this.venue,
    this.time,
    this.day,
    // this.days
  );

  LectureModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}){
    lectureId = documentSnapshot.id;
    courseCode = documentSnapshot.get('courseCode') as String;
    venue = documentSnapshot.get('venue') as String;
    time = documentSnapshot.get('time') as String;
    day = documentSnapshot.get('day') as String;
    // days = documentSnapshot.get('days') as List<String>;
  }


}