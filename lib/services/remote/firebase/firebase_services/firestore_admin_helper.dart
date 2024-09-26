import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreAdminHelper {
  final FirebaseFirestore _firestore;

  FirestoreAdminHelper({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Custom set method for subcollection
  Future<void> addDocumentAdmin(
    String collectionName,
    Map<String, dynamic> data,
  ) async {
    final docRef = _firestore.collection(collectionName).doc();
    final docId = docRef.id;
    data['id'] = docId;
    await docRef.set(data);
  }

  // Get subdocument
  Future<QuerySnapshot<Map<String, dynamic>>> getDocumentSnaphotAdmin(
    String collectionName,
  ) async {
    return await _firestore.collection(collectionName).get();
  }

  // Update subdocument
  Future<void> updateDocumentSnapshotAdmin(
    String collectionName,
    String collectionId,
    String image,
    Map<String, dynamic> data,
  ) async {
    data['image'] = image;
    await _firestore.collection(collectionName).doc(collectionId).update(data);
  }

  // Delete subdocument
  Future<void> deleteSubDocumentSnapshotAdmin(
    String collectionName,
    String collectionId,
  ) async {
    await _firestore.collection(collectionName).doc(collectionId).delete();
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
