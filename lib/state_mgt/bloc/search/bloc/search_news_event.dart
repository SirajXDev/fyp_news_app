part of 'search_news_bloc.dart';

abstract class SearchNewsEvent extends Equatable {
  const SearchNewsEvent();

  @override
  List<Object> get props => [];
}

class SearchArticlesEvent extends SearchNewsEvent {
  const SearchArticlesEvent({required this.keyword}) : super();
  final String keyword;
}

class SearchedSortedByArticleEvent extends SearchNewsEvent {
  final SearchFilter searchFilter;
  const SearchedSortedByArticleEvent({required this.searchFilter}) : super();
}
