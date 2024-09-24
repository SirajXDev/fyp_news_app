import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudFirestoreHelper {
  final FirebaseFirestore _firestore;
  // final FirebaseStorage _storage;

  CloudFirestoreHelper({FirebaseFirestore? firestore, FirebaseStorage? storage})
      : _firestore = firestore ?? FirebaseFirestore.instance
  // _storage = storage ?? FirebaseStorage.instance
  ;

  // Custom set method
  Future<void> setDocument(
      String collection, String docId, Map<String, dynamic> data,
      [SetOptions? setOptions]) async {
    await _firestore.collection(collection).doc(docId).set(
          data,
          setOptions ?? SetOptions(merge: true),
        );
  }

  /// one time get/fetch data
  Future<DocumentSnapshot> getDocument(String collection, String docId) async {
    return await _firestore.collection(collection).doc(docId).get();
  }

  /// Updates an existing document in the specified collection.
  Future<void> updateDocument(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collection).doc(docId).update(data);
  }

  /// Deletes a document from the specified collection.
  Future<void> deleteDocument(String collection, String docId) async {
    await _firestore.collection(collection).doc(docId).delete();
  }

  /// Listens for real-time updates to a document in the specified collection.
  Stream<DocumentSnapshot> listenDocument(String collection, String docId) {
    return _firestore.collection(collection).doc(docId).snapshots();
  }
}// end class


