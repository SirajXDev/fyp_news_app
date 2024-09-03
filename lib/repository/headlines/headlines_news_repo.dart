import 'package:news_application_2/models/channels_headlines/channels_news_headlines.dart';

/// Abstract class defining methods for movies API repositories.
abstract class HeadlinesNewsRepo {
  Future<NewsChannelHeadlineModel> fetchNewsChannelHeadline(String channel);
}
