part of 'search_news_bloc.dart';

abstract class SearchNewsEvent extends Equatable {
  const SearchNewsEvent();

  @override
  List<Object> get props => [];
}

class SearchArticlesEvent extends SearchNewsEvent {
  const SearchArticlesEvent({required this.keyword, this.sortBy}) : super();
  final String keyword;
  final String? sortBy;
  @override
  List<Object> get props => [keyword, sortBy!];
}

class SearchedSortedByArticleEvent extends SearchNewsEvent {
  final SearchFilter searchFilter;
  const SearchedSortedByArticleEvent({required this.searchFilter}) : super();
  @override
  List<Object> get props => [searchFilter];
}
