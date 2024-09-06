import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_application_2/data/network/network_api_services.dart';
import 'package:news_application_2/models/categ_news/categ_news.dart';
import 'package:news_application_2/repository/categ/categ_news_repo.dart';

class CategNewsRepoImp implements CategNewsRepo {
  final _apiServices = NetworkApiService();

  @override
  Future<CategoriesNewsModel> fetchNewsCategoires(String categ) async {
    String newsUrl =
        'https://newsapi.org/v2/everything?q=$categ&apiKey=4f377273fdd74ca7bfbd7ebcaffdc618';
    final response = await _apiServices.getApi(newsUrl);
    return CategoriesNewsModel.fromJson(response);
  }
}
