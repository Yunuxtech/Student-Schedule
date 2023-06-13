import 'package:Student_schedule/model/AssignmentModel.dart';
import 'package:Student_schedule/model/LectureModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/ExamModel.dart';
import '../model/NoteModel.dart';
import '../model/TestModel.dart';

class Database {
  final FirebaseFirestore firestore;

  Database(this.firestore);

  Stream<List<LectureModel>> streamDataLecture(String uid) {
    try {
      return firestore
          .collection("lectures").where("userId", isEqualTo: uid)
          .snapshots()
          .map((query) {
        final List<LectureModel> retVal = <LectureModel>[];
        for (final DocumentSnapshot doc in query.docs) {
          retVal.add(LectureModel.fromDocumentSnapshot(documentSnapshot: doc));
          // retVal                                                                                                                                                                       .add(doc);
        }
        print("DOCS $retVal");
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<AssignmentModel>> streamDataAssignment(String uid) {
    try {
      return firestore
          .collection("assignments").where("userId", isEqualTo: uid)
          .snapshots()
          .map((query) {
        final List<AssignmentModel> retVal = <AssignmentModel>[];
        for (final DocumentSnapshot doc in query.docs) {
          retVal.add(AssignmentModel.fromDocumentSnapshot(documentSnapshot: doc));
          // retVal                                                                                                                                                                       .add(doc);
        }
        print("DOCS $retVal");
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<NoteModel>> streamDataNote(String uid) {
    try {
      return firestore
          .collection("notes").where("userId", isEqualTo: uid)
          .snapshots()
          .map((query) {
        final List<NoteModel> retVal = <NoteModel>[];
        for (final DocumentSnapshot doc in query.docs) {
          retVal.add(NoteModel.fromDocumentSnapshot(documentSnapshot: doc));
          // retVal                                                                                                                                                                       .add(doc);
        }
        print("DOCS $retVal");
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }
  Stream<List<TestModel>> streamDataTest(String uid) {
    try {
      return firestore
          .collection("tests").where("userId", isEqualTo: uid)
          .snapshots()
          .map((query) {
        final List<TestModel> retVal = <TestModel>[];
        for (final DocumentSnapshot doc in query.docs) {
          retVal.add(TestModel.fromDocumentSnapshot(documentSnapshot: doc));
          // retVal                                                                                                                                                                       .add(doc);
        }
        print("DOCS $retVal");
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ExamModel>> streamDataExam(String uid) {
    try {
      return firestore
          .collection("exams").where("userId", isEqualTo: uid)
          .snapshots()
          .map((query) {
        final List<ExamModel> retVal = <ExamModel>[];
        for (final DocumentSnapshot doc in query.docs) {
          retVal.add(ExamModel.fromDocumentSnapshot(documentSnapshot: doc));
          // retVal                                                                                                                                                                       .add(doc);
        }
        print("DOCS $retVal");
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentReference> addData(
       Map<String, dynamic> content, String collection) async {
    try {
      DocumentReference doc =
          await firestore.collection(collection).add(content);
      print("Data collection added");
      //  DocumentReference doc = await firestore.collection(collection).doc(uid).collection(collection).add(content);
      return doc;
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentReference> addStudent(
      Map<String, dynamic> content, String collection) async {
    try {
      DocumentReference doc =
          await firestore.collection(collection).add(content);
      print("Students collection created successfully");
      //  DocumentReference doc = await firestore.collection(collection).doc(uid).collection(collection).add(content);
      return doc;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateData(String uid, String dataId,
      Map<String, dynamic> content, String collection) async {
    try {
      firestore
          .collection(collection)
          .doc(uid)
          .collection(collection)
          .doc(dataId)
          .update(content);
    } catch (e) {
      rethrow;
    }
  }



  Future<void> deleteDocument(String documentId, String collectionName) async {
  try {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionName);

    await collection.doc(documentId).delete();
    print('Document with ID $documentId deleted successfully.');
  } catch (e) {
    print('Error deleting document: $e');
  }
}
}
