part of 'search_news_bloc.dart';

class SearchNewsState extends Equatable {
  const SearchNewsState(
      {required this.searchNewsList, required this.searchSelectedMenu});
  final ApiResponse<CategoriesNewsModel> searchNewsList;
  final String searchSelectedMenu;

  SearchNewsState copyWith({
    ApiResponse<CategoriesNewsModel>? searchNewsList,
    String? searchSelectedMenu,
  }) {
    return SearchNewsState(
      searchNewsList: searchNewsList ?? this.searchNewsList,
      searchSelectedMenu: searchSelectedMenu ?? this.searchSelectedMenu,
    );
  }

  @override
  List<Object> get props => [searchNewsList, searchSelectedMenu];
}
