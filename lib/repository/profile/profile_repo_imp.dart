import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/models/profile.dart';
import 'package:news_application_2/repository/profile/base_profile_repo.dart';
import 'package:news_application_2/services/remote/firebase/firebase_services/profile_helper.dart';
import 'package:news_application_2/services/remote/firebase/firebase_storage_helper.dart';

class ProfileRepositoryImpl extends BaseProfileRepository {
  static const _collectionName = 'profile';

  final CloudFirestoreHelper _firestoreHelper;
  final FirebaseStorageHelper _storageHelper;

  ProfileRepositoryImpl({
    CloudFirestoreHelper? firestoreHelper,
    FirebaseStorageHelper? storageHelper,
  })  : _firestoreHelper = firestoreHelper ?? CloudFirestoreHelper(),
        _storageHelper = storageHelper ?? FirebaseStorageHelper();

  /// Sets user profile information
  @override
  Future<void> setProfile({
    required String id,
    String? email,
    String? phone,
    File? imageFile,
    String? bio,
    String? username,
    String? imageURL,
  }) async {
    try {
      String imgUrl = '';
      if (imageFile != null) {
        imgUrl = await _storageHelper.uploadFile(imageFile, id);
      }
      // else {
      //   // Retrieve existing image URL from Firestore or Firebase Storage
      //   final storageRef = FirebaseStorage.instance.ref('files/$id');
      //   imgUrl = await storageRef.getDownloadURL();
      // }

      final profile = Profile(
        id: id,
        email: email,
        phone: phone,
        bio: bio,
        image: imgUrl.isEmpty ? imageURL : imgUrl,
        name: username,
      );
      debugPrint('phoneNumberFromRepo: $phone');
      debugPrint('usernameFromRepo: $username');
      debugPrint('phoneNumberFromRepo: $email');
      debugPrint('usernameFromRepo: $imgUrl + $imageURL');
      debugPrint('usernameFromRepo: $bio');
      debugPrint('usernameFromRepo: $id');

      await _firestoreHelper.setDocument(_collectionName, id, profile.toJson());
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors
      if (kDebugMode) {
        print('Firebase Error: $e');
      }
      throw Exception('Failed to upload setProfile(): $e');
    } catch (e) {
      // Handle general errors
      if (kDebugMode) {
        print('Error: $e');
      }
      throw Exception('Failed to upload profile: $e');
    }
  }

  /// Retrieves user profile information
  @override
  Future<Profile> getProfile(String userId) async {
    try {
      debugPrint('Getting profile for user ID: $userId');
      final document =
          await _firestoreHelper.getDocument(_collectionName, userId);
      debugPrint('Retrieved document: ${document.data()}');
      return Profile.fromJson(document.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors
      if (kDebugMode) {
        print('Firebase Error: $e');
      }
      throw Exception('Failed to load profile model: $e');
    } catch (e) {
      // Handle general errors
      if (kDebugMode) {
        print('Error: $e');
      }
      throw Exception('Failed to load profile data: $e');
    }
  }
}//class end.
