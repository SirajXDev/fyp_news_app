import 'dart:io';

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
      String collection, String docId, Map<String, dynamic> data) async {
    await _firestore
        .collection(collection)
        .doc(docId)
        .set(data, SetOptions(merge: true));
  }

  // Custom get method
  Future<DocumentSnapshot> getDocument(String collection, String docId) async {
    return await _firestore.collection(collection).doc(docId).get();
  }

  // // Upload profile image
  // Future<String> uploadImage(File imagePath, String imageId) async {
  //   final ref = _storage.ref('profileImages/$imageId.jpg');
  //   await ref.putFile(imagePath);
  //   return await ref.getDownloadURL();
  // }

  // // Delete profile image
  // Future<void> deleteImage(String imageId) async {
  //   final ref = _storage.ref('profileImages/$imageId.jpg');
  //   await ref.delete();
  // }
}// end class


