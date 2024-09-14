import 'package:news_application_2/services/hive/adaptor/book_mark_adaptor.dart';

abstract class BaseBookMarkRepo {
  // Load all favorite items
  Future<List<BookMarkHive>> loadFavorites();

  // Add a favorite item
  Future<void> addFavorite(
    BookMarkHive item,
  );

  // Remove a favorite item
  Future<void> removeFavorite(String id);
  // Check if an article is already marked as favorite
  bool isFavorite(String articleId);
}
