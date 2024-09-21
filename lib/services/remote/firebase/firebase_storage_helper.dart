import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageHelper {
  final FirebaseStorage _storage;

  FirebaseStorageHelper({FirebaseStorage? storage})
      : _storage = storage ?? FirebaseStorage.instance;

// Upload file
  Future<String> uploadFile(File filePath, String fileName) async {
    try {
      if (!await filePath.exists()) {
        throw Exception('File not found');
      }
      final ref = _storage.ref('files/$fileName');
      final task = await ref.putFile(filePath);
      return await task.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors
      if (kDebugMode) {
        print('Firebase Error: $e');
      }
      throw Exception('Failed to upload file: $e');
    } catch (e) {
      // Handle general errors
      if (kDebugMode) {
        print('Error: $e');
      }
      throw Exception('Failed to upload file: $e');
    }
  }

  // // Download file
  // Future<Uint8List?> downloadFile(String fileName) async {
  //   final ref = _storage.ref('files/$fileName');
  //   return await ref.getData();
  // }

  // // Delete file
  // Future<void> deleteFile(String fileName) async {
  //   final ref = _storage.ref('files/$fileName');
  //   await ref.delete();
  // }

  // Get file URL
  Future<String> getFileUrl(String fileName) async {
    final ref = _storage.ref('files/$fileName');
    return await ref.getDownloadURL();
  }
}// class end
