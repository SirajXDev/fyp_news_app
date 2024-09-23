part of 'bookmark_bloc.dart';

class BookmarkState extends Equatable {
  const BookmarkState({required this.bookMarkList});
  final List<BookMarkHive> bookMarkList;

  BookmarkState copyWith({
    List<BookMarkHive>? bookMarkList,
  }) {
    return BookmarkState(
      bookMarkList: bookMarkList ?? this.bookMarkList,
    );
  }

  @override
  List<Object?> get props => [bookMarkList];
}

class BookMarkInitial extends BookmarkState {
  const BookMarkInitial({required super.bookMarkList});
}
