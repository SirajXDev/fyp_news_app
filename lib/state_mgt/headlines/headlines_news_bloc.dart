import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_application_2/data/response/api_response.dart';
import 'package:news_application_2/models/categ_news/categ_news.dart';
import 'package:news_application_2/models/channels_headlines/channels_news_headlines.dart';
import 'package:news_application_2/repository/headlines/headlines_news_repo.dart';

part 'headlines_news_event.dart';
part 'headlines_news_state.dart';

class HeadlinesNewsBloc extends Bloc<HeadLinesNewsEvent, HeadlinesNewsState> {
  // CategNewsRepo? categNewsRepo;
  HeadlinesNewsRepo headlinesNewsRepo;
  HeadlinesNewsBloc({
    required this.headlinesNewsRepo,
  }) : super(
          HeadlinesNewsState(
            // categNewsList: ApiResponse.loading(),
            newsChannelHeadlineList: ApiResponse.loading(),
          ),
        ) {
    on<HeadLinesEvent>(fetchNewsChannelHeadlines);
  }

  Future<void> fetchNewsChannelHeadlines(
      HeadLinesEvent event, Emitter<HeadlinesNewsState> emit) async {
    await headlinesNewsRepo.fetchNewsChannelHeadline(event.channel).then(
      (response) {
        emit(state.copyWith(
            newsChannelHeadlineList: ApiResponse.completed(response)));
      },
    ).onError(
      (error, stackTrace) {
        emit(
          state.copyWith(
            newsChannelHeadlineList: ApiResponse.error(
              error.toString(),
            ),
          ),
        );
      },
    );
  }
}
