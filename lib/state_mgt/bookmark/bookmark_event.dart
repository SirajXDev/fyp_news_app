part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class AddToBookMarkEvent extends BookmarkEvent {
  final BookMarkHive article;
  const AddToBookMarkEvent({
    required this.article,
  });
  @override
  List<Object> get props => [
        article,
      ];
}

class RemoveFromBookMarkEvent extends BookmarkEvent {
  final String key;
  const RemoveFromBookMarkEvent({required this.key});
  @override
  List<Object> get props => [key];
}

class ReadDataFromBookMarkEvent extends BookmarkEvent {
  @override
  List<Object> get props => [];
}
