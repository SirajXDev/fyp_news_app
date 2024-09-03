// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categ_news.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CategoriesNewsModel _$CategoriesNewsModelFromJson(Map<String, dynamic> json) {
  return _CategoriesNewsModel.fromJson(json);
}

/// @nodoc
mixin _$CategoriesNewsModel {
  String? get status => throw _privateConstructorUsedError;
  int? get totalResults => throw _privateConstructorUsedError;
  List<Articles>? get articles => throw _privateConstructorUsedError;

  /// Serializes this CategoriesNewsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategoriesNewsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoriesNewsModelCopyWith<CategoriesNewsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoriesNewsModelCopyWith<$Res> {
  factory $CategoriesNewsModelCopyWith(
          CategoriesNewsModel value, $Res Function(CategoriesNewsModel) then) =
      _$CategoriesNewsModelCopyWithImpl<$Res, CategoriesNewsModel>;
  @useResult
  $Res call({String? status, int? totalResults, List<Articles>? articles});
}

/// @nodoc
class _$CategoriesNewsModelCopyWithImpl<$Res, $Val extends CategoriesNewsModel>
    implements $CategoriesNewsModelCopyWith<$Res> {
  _$CategoriesNewsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoriesNewsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? totalResults = freezed,
    Object? articles = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      totalResults: freezed == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int?,
      articles: freezed == articles
          ? _value.articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<Articles>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoriesNewsModelImplCopyWith<$Res>
    implements $CategoriesNewsModelCopyWith<$Res> {
  factory _$$CategoriesNewsModelImplCopyWith(_$CategoriesNewsModelImpl value,
          $Res Function(_$CategoriesNewsModelImpl) then) =
      __$$CategoriesNewsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? status, int? totalResults, List<Articles>? articles});
}

/// @nodoc
class __$$CategoriesNewsModelImplCopyWithImpl<$Res>
    extends _$CategoriesNewsModelCopyWithImpl<$Res, _$CategoriesNewsModelImpl>
    implements _$$CategoriesNewsModelImplCopyWith<$Res> {
  __$$CategoriesNewsModelImplCopyWithImpl(_$CategoriesNewsModelImpl _value,
      $Res Function(_$CategoriesNewsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoriesNewsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? totalResults = freezed,
    Object? articles = freezed,
  }) {
    return _then(_$CategoriesNewsModelImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      totalResults: freezed == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int?,
      articles: freezed == articles
          ? _value._articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<Articles>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoriesNewsModelImpl implements _CategoriesNewsModel {
  const _$CategoriesNewsModelImpl(
      {this.status, this.totalResults, final List<Articles>? articles})
      : _articles = articles;

  factory _$CategoriesNewsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoriesNewsModelImplFromJson(json);

  @override
  final String? status;
  @override
  final int? totalResults;
  final List<Articles>? _articles;
  @override
  List<Articles>? get articles {
    final value = _articles;
    if (value == null) return null;
    if (_articles is EqualUnmodifiableListView) return _articles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CategoriesNewsModel(status: $status, totalResults: $totalResults, articles: $articles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoriesNewsModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
            const DeepCollectionEquality().equals(other._articles, _articles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, totalResults,
      const DeepCollectionEquality().hash(_articles));

  /// Create a copy of CategoriesNewsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoriesNewsModelImplCopyWith<_$CategoriesNewsModelImpl> get copyWith =>
      __$$CategoriesNewsModelImplCopyWithImpl<_$CategoriesNewsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoriesNewsModelImplToJson(
      this,
    );
  }
}

abstract class _CategoriesNewsModel implements CategoriesNewsModel {
  const factory _CategoriesNewsModel(
      {final String? status,
      final int? totalResults,
      final List<Articles>? articles}) = _$CategoriesNewsModelImpl;

  factory _CategoriesNewsModel.fromJson(Map<String, dynamic> json) =
      _$CategoriesNewsModelImpl.fromJson;

  @override
  String? get status;
  @override
  int? get totalResults;
  @override
  List<Articles>? get articles;

  /// Create a copy of CategoriesNewsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoriesNewsModelImplCopyWith<_$CategoriesNewsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Articles _$ArticlesFromJson(Map<String, dynamic> json) {
  return _Articles.fromJson(json);
}

/// @nodoc
mixin _$Articles {
  Source? get source => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get urlToImage => throw _privateConstructorUsedError;
  String? get publishedAt => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;

  /// Serializes this Articles to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Articles
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArticlesCopyWith<Articles> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticlesCopyWith<$Res> {
  factory $ArticlesCopyWith(Articles value, $Res Function(Articles) then) =
      _$ArticlesCopyWithImpl<$Res, Articles>;
  @useResult
  $Res call(
      {Source? source,
      String? author,
      String? title,
      String? description,
      String? url,
      String? urlToImage,
      String? publishedAt,
      String? content});

  $SourceCopyWith<$Res>? get source;
}

/// @nodoc
class _$ArticlesCopyWithImpl<$Res, $Val extends Articles>
    implements $ArticlesCopyWith<$Res> {
  _$ArticlesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Articles
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = freezed,
    Object? author = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? url = freezed,
    Object? urlToImage = freezed,
    Object? publishedAt = freezed,
    Object? content = freezed,
  }) {
    return _then(_value.copyWith(
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as Source?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      urlToImage: freezed == urlToImage
          ? _value.urlToImage
          : urlToImage // ignore: cast_nullable_to_non_nullable
              as String?,
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Articles
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SourceCopyWith<$Res>? get source {
    if (_value.source == null) {
      return null;
    }

    return $SourceCopyWith<$Res>(_value.source!, (value) {
      return _then(_value.copyWith(source: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ArticlesImplCopyWith<$Res>
    implements $ArticlesCopyWith<$Res> {
  factory _$$ArticlesImplCopyWith(
          _$ArticlesImpl value, $Res Function(_$ArticlesImpl) then) =
      __$$ArticlesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Source? source,
      String? author,
      String? title,
      String? description,
      String? url,
      String? urlToImage,
      String? publishedAt,
      String? content});

  @override
  $SourceCopyWith<$Res>? get source;
}

/// @nodoc
class __$$ArticlesImplCopyWithImpl<$Res>
    extends _$ArticlesCopyWithImpl<$Res, _$ArticlesImpl>
    implements _$$ArticlesImplCopyWith<$Res> {
  __$$ArticlesImplCopyWithImpl(
      _$ArticlesImpl _value, $Res Function(_$ArticlesImpl) _then)
      : super(_value, _then);

  /// Create a copy of Articles
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = freezed,
    Object? author = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? url = freezed,
    Object? urlToImage = freezed,
    Object? publishedAt = freezed,
    Object? content = freezed,
  }) {
    return _then(_$ArticlesImpl(
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as Source?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      urlToImage: freezed == urlToImage
          ? _value.urlToImage
          : urlToImage // ignore: cast_nullable_to_non_nullable
              as String?,
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArticlesImpl implements _Articles {
  const _$ArticlesImpl(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory _$ArticlesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArticlesImplFromJson(json);

  @override
  final Source? source;
  @override
  final String? author;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? url;
  @override
  final String? urlToImage;
  @override
  final String? publishedAt;
  @override
  final String? content;

  @override
  String toString() {
    return 'Articles(source: $source, author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticlesImpl &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.urlToImage, urlToImage) ||
                other.urlToImage == urlToImage) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, source, author, title,
      description, url, urlToImage, publishedAt, content);

  /// Create a copy of Articles
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArticlesImplCopyWith<_$ArticlesImpl> get copyWith =>
      __$$ArticlesImplCopyWithImpl<_$ArticlesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArticlesImplToJson(
      this,
    );
  }
}

abstract class _Articles implements Articles {
  const factory _Articles(
      {final Source? source,
      final String? author,
      final String? title,
      final String? description,
      final String? url,
      final String? urlToImage,
      final String? publishedAt,
      final String? content}) = _$ArticlesImpl;

  factory _Articles.fromJson(Map<String, dynamic> json) =
      _$ArticlesImpl.fromJson;

  @override
  Source? get source;
  @override
  String? get author;
  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get url;
  @override
  String? get urlToImage;
  @override
  String? get publishedAt;
  @override
  String? get content;

  /// Create a copy of Articles
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArticlesImplCopyWith<_$ArticlesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Source _$SourceFromJson(Map<String, dynamic> json) {
  return _Source.fromJson(json);
}

/// @nodoc
mixin _$Source {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this Source to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SourceCopyWith<Source> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceCopyWith<$Res> {
  factory $SourceCopyWith(Source value, $Res Function(Source) then) =
      _$SourceCopyWithImpl<$Res, Source>;
  @useResult
  $Res call({String? id, String? name});
}

/// @nodoc
class _$SourceCopyWithImpl<$Res, $Val extends Source>
    implements $SourceCopyWith<$Res> {
  _$SourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SourceImplCopyWith<$Res> implements $SourceCopyWith<$Res> {
  factory _$$SourceImplCopyWith(
          _$SourceImpl value, $Res Function(_$SourceImpl) then) =
      __$$SourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? name});
}

/// @nodoc
class __$$SourceImplCopyWithImpl<$Res>
    extends _$SourceCopyWithImpl<$Res, _$SourceImpl>
    implements _$$SourceImplCopyWith<$Res> {
  __$$SourceImplCopyWithImpl(
      _$SourceImpl _value, $Res Function(_$SourceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$SourceImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SourceImpl implements _Source {
  const _$SourceImpl({this.id, this.name});

  factory _$SourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$SourceImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'Source(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceImplCopyWith<_$SourceImpl> get copyWith =>
      __$$SourceImplCopyWithImpl<_$SourceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SourceImplToJson(
      this,
    );
  }
}

abstract class _Source implements Source {
  const factory _Source({final String? id, final String? name}) = _$SourceImpl;

  factory _Source.fromJson(Map<String, dynamic> json) = _$SourceImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SourceImplCopyWith<_$SourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
