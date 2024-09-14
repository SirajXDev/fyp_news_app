part of 'news_home_bloc.dart';

abstract class NewsHomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchNewsByCategoryEvent extends NewsHomeEvent {
  FetchNewsByCategoryEvent({required this.categ}) : super();
  final String categ;

  @override
  List<Object> get props => [categ];
}

class HeadLinesArticleNewsEvent extends NewsHomeEvent {
  HeadLinesArticleNewsEvent({required this.categ}) : super();
  final String categ;

  @override
  List<Object> get props => [categ];
}

// class UpdateSelectedCategoryEvent extends NewsHomeEvent {
//   final String category;

//   UpdateSelectedCategoryEvent({required this.category}) : super();
// }

class SelectMenuEvent extends NewsHomeEvent {
  final FilterList item;

  SelectMenuEvent({required this.item}) : super();
}
