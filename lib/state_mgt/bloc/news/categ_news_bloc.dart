import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_application_2/data/response/api_response.dart';
import 'package:news_application_2/models/categ_news/categ_news.dart';
import 'package:news_application_2/repository/categ/categ_news_repo.dart';

part 'categ_news_event.dart';
part 'categ_news_state.dart';

class CategNewsBloc extends Bloc<CategNewsEvent, CategNewsState> {
  CategNewsRepo categNewsRepo;
  CategNewsBloc({required this.categNewsRepo})
      : super(
          CategNewsState(
            categNewsList: ApiResponse.loading(),
          ),
        ) {
    on<CategArticleNewsEvent>(fetchCategNews);
  }
  Future<void> fetchCategNews(
      CategArticleNewsEvent event, Emitter<CategNewsState> emit) async {
    await categNewsRepo.fetchNewsCategoires(event.categ).then(
      (response) {
        emit(
          state.copyWith(
            categNewsList: ApiResponse.completed(response),
          ),
        );
      },
    ).onError(
      (error, stackTrace) {
        emit(
          state.copyWith(
            categNewsList: ApiResponse.error(
              error.toString(),
            ),
          ),
        );
      },
    );
  }
}
