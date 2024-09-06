import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/data/response/api_response.dart';
import 'package:news_application_2/models/categ_news/categ_news.dart';
import 'package:news_application_2/models/channels_headlines/channels_news_headlines.dart';
import 'package:news_application_2/repository/categ/categ_news_repo.dart';
import 'package:news_application_2/repository/headlines/headlines_news_repo.dart';

part 'news_home_event.dart';
part 'news_home_state.dart';

class NewsHomeBloc extends Bloc<NewsHomeEvent, NewsHomeState> {
  CategNewsRepo categNewsRepo;
  HeadlinesNewsRepo headlinesNewsRepo;

  NewsHomeBloc({required this.categNewsRepo, required this.headlinesNewsRepo})
      : super(
          NewsHomeState(
            headLinesList: ApiResponse.loading(),
            categNewsList: ApiResponse.loading(),
          ),
        ) {
    on<HeadLinesArticleNewsEvent>(fetchHeadLinesNews);
    on<CategArticleNewsEvent>(fetchCategNews);
  }
  Future<void> fetchCategNews(
      CategArticleNewsEvent event, Emitter<NewsHomeState> emit) async {
    await categNewsRepo.fetchNewsCategoires(event.categ).then(
      (response) {
        emit(
          state.copyWith(
            categNewsList: ApiResponse.completed(response),
          ),
        );
        debugPrint('${response.articles}');
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

  // Future<void> fetchHeadLinesNews(HeadLinesArticleNewsEvent event, Emitter<NewsHomeState> emit)async{}
  Future<void> fetchHeadLinesNews(
      HeadLinesArticleNewsEvent event, Emitter<NewsHomeState> emit) async {
    await headlinesNewsRepo.fetchNewsChannelHeadline(event.categ).then(
      (response) {
        emit(
          state.copyWith(
            headLinesList: ApiResponse.completed(response),
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
}// class end
