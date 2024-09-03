import 'package:freezed_annotation/freezed_annotation.dart';

part 'categ_news.freezed.dart';
part 'categ_news.g.dart';

@freezed
class CategoriesNewsModel with _$CategoriesNewsModel {
  const factory CategoriesNewsModel({
    String? status,
    int? totalResults,
    List<Articles>? articles,
  }) = _CategoriesNewsModel;

  factory CategoriesNewsModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesNewsModelFromJson(json);
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
