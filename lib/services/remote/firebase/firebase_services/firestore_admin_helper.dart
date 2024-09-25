import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreAdminHelper {
  final FirebaseFirestore _firestore;

  FirestoreAdminHelper({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Custom set method for subcollection
  Future<void> setSubDocument(
    String collectionName,
    String collectionId,
    String subCollectionName,
    String subCollectionId,
    Map<String, dynamic> data,
  ) async {
    await _firestore
        .collection(collectionName)
        .doc(collectionId)
        .collection(subCollectionName)
        .doc(subCollectionId)
        .set(data);
  }

  // Get subdocument
  Future<DocumentSnapshot> getSubDocument(
    String collectionName,
    String collectionId,
    String subCollectionName,
    String subCollectionId,
  ) async {
    return await _firestore
        .collection(collectionName)
        .doc(collectionId)
        .collection(subCollectionName)
        .doc(subCollectionId)
        .get();
  }

  // Update subdocument
  Future<void> updateSubDocument(
    String collectionName,
    String collectionId,
    String subCollectionName,
    String subCollectionId,
    Map<String, dynamic> data,
  ) async {
    await _firestore
        .collection(collectionName)
        .doc(collectionId)
        .collection(subCollectionName)
        .doc(subCollectionId)
        .update(data);
  }

  // Delete subdocument
  Future<void> deleteSubDocument(
    String collectionName,
    String collectionId,
    String subCollectionName,
    String subCollectionId,
  ) async {
    await _firestore
        .collection(collectionName)
        .doc(collectionId)
        .collection(subCollectionName)
        .doc(subCollectionId)
        .delete();
  }

  // Listen for real-time updates to a subdocument
  Stream<DocumentSnapshot> listenSubDocument(
    String collectionName,
    String collectionId,
    String subCollectionName,
    String subCollectionId,
  ) {
    return _firestore
        .collection(collectionName)
        .doc(collectionId)
        .collection(subCollectionName)
        .doc(subCollectionId)
        .snapshots();
  }
}
