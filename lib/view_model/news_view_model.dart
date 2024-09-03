import 'package:news_application_2/models/news_channel_headline.dart';

import '../repositiry copy/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelHeadlineMdl> fetchNewsChannelHeadlineApi(
      String channelName) async {
    final response = await _rep.fetchNewsChannelHeadlineApi(channelName);
    return response;
  }
}
