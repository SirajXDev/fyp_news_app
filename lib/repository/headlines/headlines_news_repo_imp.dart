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
    return NewsChannelHeadlineModel.fromJson(response);
  }
  // Future<NewsChannelHeadlineMdl> fetchNewsChannelHeadlineApi(
  //     String channelName) async {
  // String url =
  //     'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=4f377273fdd74ca7bfbd7ebcaffdc618';

  //   final response = await http.get(Uri.parse(url));
  //   if (kDebugMode) {
  //     print(response.body);
  //   }
  //   if (response.statusCode == 200) {
  //     final body = jsonDecode(response.body);
  //     return NewsChannelHeadlineMdl.fromJson(body);
  //   }
  //   throw Exception('Error fetching news');
  // }
}
