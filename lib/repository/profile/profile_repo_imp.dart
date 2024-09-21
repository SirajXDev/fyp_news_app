import 'dart:io';

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
    required String email,
    required String phone,
    File? imageFile,
    String? bio,
    String? username,
  }) async {
    try {
      if (imageFile == null) return;
      final imgUrl = await _storageHelper.uploadFile(imageFile, id);
      final profile = Profile(
        id: id,
        email: email,
        phone: phone,
        bio: bio,
        image: imgUrl,
        name: username,
      );
      debugPrint('phoneNumberFromRepo: $phone');
      debugPrint('usernameFromRepo: $username');

      await _firestoreHelper.setDocument(_collectionName, id, profile.toJson());
    } catch (e) {
      throw Exception('Failed to set profile');
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
    } catch (e) {
      debugPrint('Error getting profile: $e');
      throw Exception('Failed to retrieve profile');
    }
  }
}//class end.
