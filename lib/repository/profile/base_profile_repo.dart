import 'dart:io';
import 'package:news_application_2/models/profile.dart';

/// Abstract interface for profile repository
abstract class BaseProfileRepository {
  /// Sets user profile information
  Future<void> setProfile({
    required String id,
    String? email,
    String? phone,
    File? imageFile,
    String? bio,
    String? username,
    String? imageURL,
  });

  /// Retrieves user profile information
  Future<Profile> getProfile(String userId);
}
