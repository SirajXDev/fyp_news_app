import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_application_2/data/network/network_api_services.dart';
import 'package:news_application_2/models/categ_news/categ_news.dart';
import 'package:news_application_2/repository/categ/categ_news_repo.dart';

class CategNewsRepoImp implements CategNewsRepo {
  final _apiServices = NetworkApiService();

  @override
  Future<CategoriesNewsModel> fetchNewsCategoires(String categ) async {
    String newsUrl =
        'https://newsapi.org/v2/everything?q=$categ&apiKey=${dotenv.env['NEWS_API_KEY']}';
    final response = await _apiServices.getApi(newsUrl);
    return CategoriesNewsModel.fromJson(response);
  }

  // Future<CategoriesNewsMdl> fetchNewsCategoires(String category) async {
  // String newsUrl =
  //     'https://newsapi.org/v2/everything?q=$category&apiKey=4f377273fdd74ca7bfbd7ebcaffdc618';
  //   final response = await http.get(Uri.parse(newsUrl));
  //   if (response.statusCode == 200) {
  //     final body = jsonDecode(response.body);

  //     return CategoriesNewsMdl.fromJson(body);
  //   } else {
  //     throw Exception('Error');
  //   }
  // }
}
