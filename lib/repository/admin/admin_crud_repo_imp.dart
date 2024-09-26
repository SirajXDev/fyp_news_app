import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:news_application_2/models/news_create_admin.dart';
import 'package:news_application_2/repository/admin/base_admin_crud_repo.dart';
import 'package:news_application_2/services/remote/firebase/firebase_services/firebase_storage_admin_helper.dart';
import 'package:news_application_2/services/remote/firebase/firebase_services/firestore_admin_helper.dart';

class AdminCrudRepoImp extends BaseAdminCRUdRepo {
  static const _collectionName = 'NewsArticlesAdmin';
  static const _subStorageName = 'newsImg';

  final FirestoreAdminHelper _firestoreAdminHelper;
  final FirebaseStorageAdminHelper _storageAdminHelper;

  AdminCrudRepoImp({
    FirestoreAdminHelper? firestoreAdminHelper,
    FirebaseStorageAdminHelper? storageAdminHelper,
  })  : _firestoreAdminHelper = firestoreAdminHelper ?? FirestoreAdminHelper(),
        _storageAdminHelper =
            storageAdminHelper ?? FirebaseStorageAdminHelper();

  /// Creates a news article in the database
  @override
  Future<void> createNewsAdminToDB(
    final String id,
    final String? image,
    final String? title,
    final String? desc,
    final String? author,
    final String? source,
    final Timestamp? publishedAt,
  ) async {
    try {
      // Validate image file
      final imageFile = _validateImageFile(image);
      String imageId = DateTime.now().millisecondsSinceEpoch.toString();

      // Upload image to storage

      if (imageFile == null) return;

      String downloadedImg = await _storageAdminHelper.uploadFile(
        _collectionName,
        id,
        _subStorageName,
        imageId,
        imageFile,
      );
      Logger.logImageUploaded(imageFile);

      // Save news article to Firestore jsdjshdjhdj
      var createNewsAdminModel = CreateNewsAdminModel(
          id: id,
          image: downloadedImg,
          title: title,
          desc: desc,
          author: author,
          source: source,
          publishedAt: publishedAt,
          imageId: imageId);

      await _firestoreAdminHelper.addDocumentAdmin(
          _collectionName, createNewsAdminModel.toJson());

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
  Future<List<CreateNewsAdminModel>> readNewsAdminToDB() async {
    try {
      // Retrieve news article document from Firestore
      final documentSnapshot =
          await _firestoreAdminHelper.getDocumentSnaphotAdmin(
        _collectionName,
      );

      // Check if document exists
      if (documentSnapshot.docs.isNotEmpty) {
        // Return news article model

        // Return list of news article models
        return documentSnapshot.docs
            .map((document) => CreateNewsAdminModel.fromJson(document.data()))
            .toList();
      } else {
        // Log and return empty model if document not found
        Logger.logError('News Article Not Found: ');
        return []; // Return empty model
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
    CreateNewsAdminModel updateNewsAdminModel,
  ) async {
    try {
      // Validate image file
      final imageFile = _validateImageFile(updateNewsAdminModel.image);

      // Upload image to storage

      if (imageFile == null)return;
        String downloadedImg =  await _storageAdminHelper.uploadFile(
          _collectionName,
          updateNewsAdminModel.id,
          _subStorageName,
          updateNewsAdminModel.imageId ?? 'empty',
          imageFile ,
        );
        Logger.logImageUploaded(imageFile);


      // Update news article document in Firestore
      await _firestoreAdminHelper.updateDocumentSnapshotAdmin(
        _collectionName,
        updateNewsAdminModel.id,
        downloadedImg,
        updateNewsAdminModel.toJson(),

      );

      // Log updated news article details
      Logger.logNewsArticleUpdated(updateNewsAdminModel);
    } catch (e) {
      // Log update error
      Logger.logError('Error updating news article: $e');
    }
  }

  /// Deletes a news article from the database
  @override
  Future<void> deleteNewsAdminToDB(
      CreateNewsAdminModel createNewsAdminModel) async {
    try {
      // Delete news article document from Firestore
      await _storageAdminHelper.deleteFile(
        _collectionName,
        createNewsAdminModel.id,
        _subStorageName,
        createNewsAdminModel.imageId ?? 'empty',
      );

      await _firestoreAdminHelper.deleteSubDocumentSnapshotAdmin(
          _collectionName, createNewsAdminModel.id);

      // Log deleted news article ID
      Logger.logNewsArticleDeleted(createNewsAdminModel.id);
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
