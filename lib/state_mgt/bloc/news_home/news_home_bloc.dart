import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/data/response/api_response.dart';
import 'package:news_application_2/models/categ_news/categ_news.dart';
import 'package:news_application_2/models/channels_headlines/channels_news_headlines.dart';
import 'package:news_application_2/repository/categ/categ_news_repo.dart';
import 'package:news_application_2/repository/headlines/headlines_news_repo.dart';
import 'package:news_application_2/utils/enums.dart';

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
            selectedCategory: 'General',
            selectedMenu: 'bbc-news',
          ),
        ) {
    on<HeadLinesArticleNewsEvent>(fetchHeadLinesNews);
    on<CategArticleNewsEvent>(fetchCategNews);
    on<UpdateSelectedCategoryEvent>(updateSelectedCategory);
    on<SelectMenuEvent>(updatePopupMenuSelectedItems);
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

  Future<void> updateSelectedCategory(
    UpdateSelectedCategoryEvent event,
    Emitter<NewsHomeState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedCategory: event.category,
      ),
    );
  }

  Future<void> updatePopupMenuSelectedItems(
    SelectMenuEvent event,
    Emitter<NewsHomeState> emit,
  ) async {
    switch (event.item) {
      case FilterList.bbcNews:
        emit(state.copyWith(selectedMenu: 'bbc-news'));
        add(HeadLinesArticleNewsEvent(categ: 'bbc-news'));
        break;
      case FilterList.cnn:
        emit(state.copyWith(selectedMenu: 'cnn'));
        add(HeadLinesArticleNewsEvent(categ: 'cnn'));
        break;
      case FilterList.aljazeera:
        emit(state.copyWith(selectedMenu: 'al-jazeera-english'));
        add(HeadLinesArticleNewsEvent(categ: 'al-jazeera-english'));
        break;
      case FilterList.aryNews:
        emit(state.copyWith(selectedMenu: 'ary-news'));
        add(HeadLinesArticleNewsEvent(categ: 'ary-news'));
        break;
    }
  }
}// class end
