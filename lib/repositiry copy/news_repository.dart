// import 'dart:convert';
// import 'package:flutter/foundation.dart';

// import 'package:http/http.dart' as http;
// import 'package:news_application_2/models/news_channel_headline.dart';

// class NewsRepository {
//   Future<NewsChannelHeadlineMdl> fetchNewsChannelHeadlineApi(
//       String channelName) async {
//     String url =
        // 'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=4f377273fdd74ca7bfbd7ebcaffdc618';

//     final response = await http.get(Uri.parse(url));
//     if (kDebugMode) {
//       print(response.body);
//     }
//     if (response.statusCode == 200) {
//       final body = jsonDecode(response.body);
//       return NewsChannelHeadlineMdl.fromJson(body);
//     }
//     throw Exception('Error fetching news');
//   }
// }
