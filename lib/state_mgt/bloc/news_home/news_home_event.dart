part of 'news_home_bloc.dart';

abstract class NewsHomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CategArticleNewsEvent extends NewsHomeEvent {
  CategArticleNewsEvent({required this.categ}) : super();
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
