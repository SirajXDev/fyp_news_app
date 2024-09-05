import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/utils/enums.dart';

class PopupMenuCubit extends Cubit<String> {
  PopupMenuCubit() : super('bbc-news');

  void selectMenu(FilterList item) {
    switch (item) {
      case FilterList.bbcNews:
        emit('bbc-news');
        break;
      case FilterList.cnn:
        emit('cnn');
        break;
      case FilterList.aljazeera:
        emit('al-jazeera-english');
        break;
      case FilterList.aryNews:
        emit('ary-news');
        break;
      case FilterList.independent:
        emit('independent');
        break;
    }
  }
}
