import 'package:news_application_2/models/news_create_admin.dart';

abstract class BaseAdminCRUdRepo {
  Future<void> createNewsAdminToDB(CreateNewsAdminModel createNewsAdminModel);
  Future<CreateNewsAdminModel> readNewsAdminToDB(String id);
  Future<void> updateNewsAdminToDB(CreateNewsAdminModel createNewsAdminModel);
  Future<void> deleteNewsAdminToDB(String docId);
}
