import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_application_2/models/news_create_admin.dart';
import 'package:news_application_2/repository/admin/base_admin_crud_repo.dart';
import 'package:news_application_2/services/remote/firebase/firebase_services/cloud_firestore_helper.dart';
import 'package:news_application_2/services/remote/firebase/firebase_storage_helper.dart';

class AdminCrudRepoImp extends BaseAdminCRUdRepo {
  static const _collectionName = 'NewsArticlesAdmin';
  // static const _subCollectionName = 'news-articles';

  final CloudFirestoreHelper _firestoreHelper;
  final FirebaseStorageHelper _storageHelper;

  AdminCrudRepoImp({
    CloudFirestoreHelper? firestoreHelper,
    FirebaseStorageHelper? storageHelper,
  })  : _firestoreHelper = firestoreHelper ?? CloudFirestoreHelper(),
        _storageHelper = storageHelper ?? FirebaseStorageHelper();

  /// Creates a news article in the database
  @override
  Future<void> createNewsAdminToDB(
    CreateNewsAdminModel createNewsAdminModel,
  ) async {
    try {
      // Validate image file
      final imageFile = _validateImageFile(createNewsAdminModel.image);

      // Upload image to storage

      if (imageFile != null) {
        await _storageHelper.uploadFile(
          _collectionName,
          imageFile,
          createNewsAdminModel.id,
        );
        Logger.logImageUploaded(imageFile);
      }

      // Save news article to Firestore
      await _firestoreHelper.setDocument(
        _collectionName,
        createNewsAdminModel.id,
        createNewsAdminModel.toJson(),
      );

      // Log created news article details
      Logger.logNewsArticleCreated(createNewsAdminModel);
    } catch (e) {
      // Log creation error
      Logger.logError('Error creating news article: $e');
    }
  }

  /// Validates and returns the image file
  File? _validateImageFile(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      Logger.logError('No image provided');
      return null;
    }
    return File(imagePath);
  }

  /// Retrieves a news article from the database
  @override
  Future<CreateNewsAdminModel> readNewsAdminToDB(String id) async {
    try {
      // Retrieve news article document from Firestore
      final documentSnapshot =
          await _firestoreHelper.getDocument(_collectionName, id);

      // Check if document exists
      if (documentSnapshot.exists) {
        // Return news article model
        return CreateNewsAdminModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
      } else {
        // Log and return empty model if document not found
        Logger.logError('News Article Not Found: ID=$id');
        return CreateNewsAdminModel.empty(); // Return empty model
      }
    } catch (e) {
      // Log and rethrow error
      Logger.logError('Error Reading News Article: $e');
      rethrow;
    }
  }

  /// Updates a news article in the database
  @override
  Future<void> updateNewsAdminToDB(
    CreateNewsAdminModel createNewsAdminModel,
  ) async {
    try {
      // Validate image file
      final imageFile = _validateImageFile(createNewsAdminModel.image);

      // Upload image to storage
      if (imageFile != null) {
        await _storageHelper.uploadFile(
          _collectionName,
          imageFile,
          createNewsAdminModel.id,
        );
        Logger.logImageUploaded(imageFile);
      }
      // Update news article document in Firestore
      await _firestoreHelper.updateDocument(
        _collectionName,
        createNewsAdminModel.id,
        createNewsAdminModel.toJson(),
      );

      // Log updated news article details
      Logger.logNewsArticleUpdated(createNewsAdminModel);
    } catch (e) {
      // Log update error
      Logger.logError('Error updating news article: $e');
    }
  }

  /// Deletes a news article from the database
  @override
  Future<void> deleteNewsAdminToDB(String docId) async {
    try {
      // Delete news article document from Firestore
      await _storageHelper.deleteFile(docId);

      await _firestoreHelper.deleteDocument(_collectionName, docId);

      // Log deleted news article ID
      Logger.logNewsArticleDeleted(docId);
    } catch (e) {
      // Log delete error
      Logger.logError('Error deleting news article: $e');
    }
  }
}

// Logging utility class
class Logger {
  /// Logs news article creation
  static void logNewsArticleCreated(CreateNewsAdminModel model) {
    debugPrint('News Article Created: ID=${model.id}');
  }

  /// Logs news article update
  static void logNewsArticleUpdated(CreateNewsAdminModel model) {
    debugPrint('Updated News Article: ID=${model.id}');
  }

  /// Logs news article deletion
  static void logNewsArticleDeleted(String docId) {
    debugPrint('Deleted News Article: ID=$docId');
  }

  /// Logs errors
  static void logError(String message) {
    debugPrint('ERROR: $message');
  }

  /// Logs errors
  static void logSuccess(String message) {
    debugPrint('SUCCESS: $message');
  }

  /// Logs image upload
  static void logImageUploaded(File imageFile) {
    debugPrint('Image uploaded: $imageFile');
  }
}
