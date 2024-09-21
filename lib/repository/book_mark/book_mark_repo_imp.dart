import 'package:flutter/material.dart';
import 'package:news_application_2/repository/book_mark/book_mark_repo.dart';
import 'package:news_application_2/services/local/hive/adaptor/book_mark_adaptor.dart';
import 'package:news_application_2/services/local/hive/book_mark_hive/hive_helper.dart';

class BookMarkRepoImp extends BaseBookMarkRepo {
  final HiveHelper _hiveHelper = HiveHelper();

  @override
  Future<List<BookMarkHive>> loadFavorites() async {
    try {
      return await _hiveHelper.loadFavorites();
    } catch (e) {
      debugPrint('Error loading favorites: $e');
      return [];
    }
  }

  @override
  Future<void> addFavorite(
    BookMarkHive item,
  ) async {
    try {
      await _hiveHelper.addFavourite(
        item,
      );
      debugPrint('addFav: $item');
    } catch (e) {
      debugPrint('Error adding favorite: $e');
    }
  }

  @override
  Future<void> removeFavorite(String id) async {
    try {
      await _hiveHelper.removeFavorite(id);
      debugPrint('removeFav: $id');
    } catch (e) {
      debugPrint('Error removing favorite: $e');
    }
  }

  @override
  bool isFavorite(String articleId) {
    bool isFav = _hiveHelper.isFavorite(articleId);
    return isFav;
  }
}
