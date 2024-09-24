import 'package:news_application_2/models/news_create_admin.dart';
import 'package:news_application_2/repository/admin/base_admin_crud_repo.dart';

class AdminCrudRepoImp extends BaseAdminCRUdRepo {
  @override
  Future<void> createNewsAdminToDB() {
    // TODO: implement createNewsAdminToDB
    throw UnimplementedError();
  }

  @override
  Future<void> deleteNewsAdminToDB(String collection, String docId) {
    // TODO: implement deleteNewsAdminToDB
    throw UnimplementedError();
  }

  @override
  Future<CreateNewsAdminModel> readNewsAdminToDB() {
    // TODO: implement readNewsAdminToDB
    throw UnimplementedError();
  }

  @override
  Future<void> updateNewsAdminToDB(String collection, String docId,
      CreateNewsAdminModel createNewsAdminModel) {
    // TODO: implement updateNewsAdminToDB
    throw UnimplementedError();
  }
}
