import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {

  late String noteId;
  late String title;
  late String content;


  NoteModel(
    this.noteId,
    this.title,
    this.content,
  );

  NoteModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}){
    noteId = documentSnapshot.id;
    title = documentSnapshot.get('title') as String;
    content = documentSnapshot.get('content') as String;
  }


}