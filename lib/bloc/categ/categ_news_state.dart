part of 'categ_news_bloc.dart';

class CategNewsState extends Equatable {
  const CategNewsState({
    required this.categNewsList,
  });

  final ApiResponse<CategoriesNewsModel> categNewsList;

  CategNewsState copyWith({
    ApiResponse<CategoriesNewsModel>? categNewsList,
  }) {
    return CategNewsState(
      categNewsList: categNewsList ?? this.categNewsList,
    );
  }

  @override
  List<Object?> get props => [categNewsList];
}
