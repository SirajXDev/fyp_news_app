part of 'news_home_bloc.dart';

class NewsHomeState extends Equatable {
  const NewsHomeState({
    required this.headLinesList,
    required this.categNewsList,
  });

  final ApiResponse<NewsChannelHeadlineModel> headLinesList;

  final ApiResponse<CategoriesNewsModel> categNewsList;

  NewsHomeState copyWith({
    ApiResponse<NewsChannelHeadlineModel>? headLinesList,
    ApiResponse<CategoriesNewsModel>? categNewsList,
  }) {
    return NewsHomeState(
      headLinesList: headLinesList ?? this.headLinesList,
      categNewsList: categNewsList ?? this.categNewsList,
    );
  }

  @override
  List<Object?> get props => [categNewsList];
}
