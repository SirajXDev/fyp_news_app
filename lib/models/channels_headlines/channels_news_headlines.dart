import 'package:freezed_annotation/freezed_annotation.dart';

part 'channels_news_headlines.freezed.dart';
part 'channels_news_headlines.g.dart';

@freezed
class NewsChannelHeadlineModel with _$NewsChannelHeadlineModel {
  const factory NewsChannelHeadlineModel({
    String? status,
    int? totalResults,
    List<Articles>? articles,
  }) = _NewsChannelHeadlineModel;

  factory NewsChannelHeadlineModel.fromJson(Map<String, dynamic> json) =>
      _$NewsChannelHeadlineModelFromJson(json);
}

@freezed
class Articles with _$Articles {
  const factory Articles({
    Source? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) = _Articles;

  factory Articles.fromJson(Map<String, dynamic> json) =>
      _$ArticlesFromJson(json);
}

@freezed
class Source with _$Source {
  const factory Source({
    String? id,
    String? name,
  }) = _Source;

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
}
