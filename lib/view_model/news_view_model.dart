import 'package:mews_application_2/models/news_channel_headline.dart';
import 'package:mews_application_2/repositiry%20copy/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelHeadlineModel> fetchNewsChannelHeadlineApi(
      String channelName) async {
    final response = await _rep.fetchNewsChannelHeadlineApi(channelName);
    return response;
  }
}
