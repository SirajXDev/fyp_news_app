import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_application_2/services/hive/adaptor/book_mark_adaptor.dart';
import 'package:news_application_2/services/hive/book_mark_hive/base_hive_helper.dart';

class HiveHelper extends BaseHiveHelper {
  static const String favoritesBoxName = 'favoritesBox';
  static late Box<BookMarkHive> box;

  static final HiveHelper _instance = HiveHelper._internal();

  factory HiveHelper() => _instance;

  HiveHelper._internal() {
    initHiveDB();
  }

  static Future<void> initHiveDB() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(BookMarkHiveAdapter());
      box = await Hive.openBox<BookMarkHive>(favoritesBoxName);
      // box.clear();
    } catch (e) {
      debugPrint('$e');
    }
  }

  @override
  Future<void> addFavourite(BookMarkHive bookMark) async {
    debugPrint('bookMArkAddFavMethod: ${bookMark.title}');
    await box.put(bookMark.publishedAt, bookMark);
  }

  @override
  Future<List<BookMarkHive>> loadFavorites() async {
    debugPrint('Loading favourites...');
    var bookMarkList = box.values.toList();
    debugPrint('loadFavoritesMethod: $bookMarkList');
    return bookMarkList;
  }

  @override
  Future<void> removeFavorite(String id) async {
    debugPrint('removeFavoriteMethod: $id');
    final index = box.keys.toList().indexOf(id);
    if (index != -1) {
      await box.deleteAt(index);
    }
  }

  @override
  bool isFavorite(String articleId) {
    return box.containsKey(articleId);
  }
}
