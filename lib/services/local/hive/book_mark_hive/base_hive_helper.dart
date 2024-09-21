import 'package:news_application_2/services/local/hive/adaptor/book_mark_adaptor.dart';

abstract class BaseHiveHelper {
  // Future<void>  initHiveDB();
  Future<List<BookMarkHive>> loadFavorites();
  Future<void> removeFavorite(String id);
  Future<void> addFavourite(
    BookMarkHive bookMark,
  );
  bool isFavorite(String articleId);
}
