import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_application_2/repository/book_mark/book_mark_repo.dart';
import 'package:news_application_2/services/hive/adaptor/book_mark_adaptor.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final BaseBookMarkRepo baseBookMarkRepo;
  BookmarkBloc({required this.baseBookMarkRepo})
      : super(
          const BookMarkInitial(
            bookMarkList: [],
          ),
        ) {
    on<AddToBookMarkEvent>(_addToBookMark);
    on<RemoveFromBookMarkEvent>(_removeFromBookMark);
    on<ReadDataFromBookMarkEvent>(_loadDataFromBookMark);
  }

  Future<void> _addToBookMark(
      AddToBookMarkEvent event, Emitter<BookmarkState> emit) async {
    await baseBookMarkRepo.addFavorite(
      event.article,
    );
    List<BookMarkHive> readBookMark = await baseBookMarkRepo.loadFavorites();
    emit(
      state.copyWith(
        bookMarkList: readBookMark,
      ),
    );
  }

  Future<void> _removeFromBookMark(
      RemoveFromBookMarkEvent event, Emitter<BookmarkState> emit) async {
    await baseBookMarkRepo.removeFavorite(event.key);

    List<BookMarkHive> readBookMarkData =
        await baseBookMarkRepo.loadFavorites();
    emit(
      state.copyWith(
        bookMarkList: readBookMarkData,
      ),
    );
  }

  Future<void> _loadDataFromBookMark(
      ReadDataFromBookMarkEvent event, Emitter<BookmarkState> emit) async {
    List<BookMarkHive> readBookMark = await baseBookMarkRepo.loadFavorites();
    emit(
      state.copyWith(
        bookMarkList: readBookMark,
      ),
    );
  }
}
