import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_application_2/data/response/api_response.dart';
import 'package:news_application_2/models/categ_news/categ_news.dart';
import 'package:news_application_2/repository/search/search_news_repo.dart';
import 'package:news_application_2/utils/enums.dart';

part 'search_news_event.dart';
part 'search_news_state.dart';

class SearchNewsBloc extends Bloc<SearchNewsEvent, SearchNewsState> {
  SearchNewsRepo searchNewsRepo;
  SearchNewsBloc({
    required this.searchNewsRepo,
  }) : super(SearchNewsState(
            searchNewsList: ApiResponse.loading(),
            searchSelectedMenu: 'publishedAt')) {
    on<SearchArticlesEvent>(fetchSearchNews);
    on<SearchedSortedByArticleEvent>(fetchSortByNews);
  }
  Future<void> fetchSearchNews(
      SearchArticlesEvent event, Emitter<SearchNewsState> emit) async {
    await searchNewsRepo.fetchNewsSearches(event.keyword).then((response) {
      emit(
        state.copyWith(searchNewsList: state.searchNewsList),
      );
    }).onError(
      (error, stackTrace) {
        state.copyWith(
          searchNewsList: ApiResponse.error(error.toString()),
        );
      },
    );
  }

  Future<void> fetchSortByNews(SearchedSortedByArticleEvent event,
      Emitter<SearchNewsState> state) async {}
}// bloc end
