part of 'news_home_bloc.dart';

class NewsHomeState extends Equatable {
  const NewsHomeState({
    required this.headLinesList,
    required this.categNewsList,
    required this.selectedCategory,
    required this.selectedMenu,
  });

  final ApiResponse<NewsChannelHeadlineModel> headLinesList;

  final ApiResponse<CategoriesNewsModel> categNewsList;
  final String selectedCategory;
  final String selectedMenu;

  NewsHomeState copyWith({
    ApiResponse<NewsChannelHeadlineModel>? headLinesList,
    ApiResponse<CategoriesNewsModel>? categNewsList,
    String? selectedCategory,
    String? selectedMenu,
  }) {
    return NewsHomeState(
      headLinesList: headLinesList ?? this.headLinesList,
      categNewsList: categNewsList ?? this.categNewsList,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedMenu: selectedMenu ?? this.selectedMenu,
    );
  }

  @override
  List<Object?> get props =>
      [headLinesList, categNewsList, selectedCategory, selectedMenu];
}
