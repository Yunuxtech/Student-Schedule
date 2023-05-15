import 'package:Student_schedule/model/LectureModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore firestore;

  Database(this.firestore);

  Stream<List<dynamic>> streamData(String uid, String collection) {
    try {
      return firestore
          .collection(collection)
          .doc(uid)
          .collection(collection)
          // .where("done", isEqualTo: false)
          .snapshots()
          .map((query) {
        final List<dynamic> retVal = <dynamic>[];
        for (final DocumentSnapshot doc in query.docs) {
          // retVal.add(LectureModel.fromDocumentSnapshot(documentSnapshot: doc));
          retVal.add(doc);
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
}