part of 'headlines_news_bloc.dart';

class HeadlinesNewsState extends Equatable {
  const HeadlinesNewsState({required this.newsChannelHeadlineList});

  // final ApiResponse<CategoriesNewsModel> categNewsList;
  final ApiResponse<NewsChannelHeadlineModel> newsChannelHeadlineList;

  HeadlinesNewsState copyWith({
    ApiResponse<CategoriesNewsModel>? categNewsList,
    ApiResponse<NewsChannelHeadlineModel>? newsChannelHeadlineList,
  }) {
    return HeadlinesNewsState(
      // categNewsList: categNewsList ?? this.categNewsList,
      newsChannelHeadlineList:
          newsChannelHeadlineList ?? this.newsChannelHeadlineList,
    );
  }

  @override
  List<Object> get props => [
        // categNewsList,
        newsChannelHeadlineList,
      ];
}
