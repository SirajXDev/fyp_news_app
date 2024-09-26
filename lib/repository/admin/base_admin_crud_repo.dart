import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_application_2/models/news_create_admin.dart';

abstract class BaseAdminCRUdRepo {
  Future<void> createNewsAdminToDB(
      final String id,
      final String? image,
      final String? title,
      final String? desc,
      final String? author,
      final String? source,
      final Timestamp?
          publishedAt); // Future<void> addNewsAdminToDB(CreateNewsAdminModel createNewsAdminModel);
  Future<List<CreateNewsAdminModel>> readNewsAdminToDB();
  Future<void> updateNewsAdminToDB(CreateNewsAdminModel updateNewsAdminModel);
  Future<void> deleteNewsAdminToDB(CreateNewsAdminModel deletNewsAdminModel);
}
