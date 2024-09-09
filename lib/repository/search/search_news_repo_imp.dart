import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_application_2/data/network/network_api_services.dart';
import 'package:news_application_2/models/categ_news/categ_news.dart';
import 'package:news_application_2/repository/search/search_news_repo.dart';

class CategNewsRepoImp implements SearchNewsRepo {
  final _apiServices = NetworkApiService();

  @override
  Future<CategoriesNewsModel> fetchNewsSearches(
      {required String search, String? sortBy}) async {
    String newsUrl =
        'https://newsapi.org/v2/everything?q=$search&apiKey=${dotenv.env['NEWS_API_KEY']}&sortBy=${sortBy ?? 'publishedAt'}';
    final response = await _apiServices.getApi(newsUrl);
    return CategoriesNewsModel.fromJson(response);
  }
}
