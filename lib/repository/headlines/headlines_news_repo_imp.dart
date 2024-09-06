import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_application_2/data/network/network_api_services.dart';
import 'package:news_application_2/models/channels_headlines/channels_news_headlines.dart';
import 'package:news_application_2/repository/headlines/headlines_news_repo.dart';

class HeadlinesNewsRepoImp implements HeadlinesNewsRepo {
  final _apiServices = NetworkApiService();

  @override
  Future<NewsChannelHeadlineModel> fetchNewsChannelHeadline(
      String channel) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$channel&apiKey=${dotenv.env['NEWS_API_KEY']}';
    final response = await _apiServices.getApi(url);
    debugPrint('apikey: ${dotenv.env['NEWS_API_KEY']}');
    return NewsChannelHeadlineModel.fromJson(response);
  }
}
