part of 'categ_news_bloc.dart';

abstract class CategNewsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CategArticleNewsEvent extends CategNewsEvent {
  CategArticleNewsEvent({required this.categ}) : super();
  final String categ;

  @override
  List<Object> get props => [categ];
}
