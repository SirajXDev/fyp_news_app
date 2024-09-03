part of 'headlines_news_bloc.dart';

abstract class HeadLinesNewsEvent extends Equatable {
  const HeadLinesNewsEvent();

  @override
  List<Object> get props => [];
}

class HeadLinesEvent extends HeadLinesNewsEvent {
  const HeadLinesEvent({required this.channel}) : super();
  final String channel;

  @override
  List<Object> get props => [channel];
}

// class ArticleNewsEvent extends NewsEvent {}
