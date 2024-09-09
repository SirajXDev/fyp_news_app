import 'package:news_application_2/models/categ_news/categ_news.dart';

/// Abstract class defining methods for movies API repositories.
abstract class SearchNewsRepo {
  Future<CategoriesNewsModel> fetchNewsSearches(
      {required String search, String? sortBy});
}
