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
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'popup_menu_cubit.dart'; // Import the Cubit file

// class PopupMenuWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => PopupMenuCubit(),
//       child: BlocBuilder<PopupMenuCubit, String>(
//         buildWhen: (previous, current) => previous != current,
//         builder: (context, state) {
//           return Column(
//             children: [
//               PopupMenuButton<FilterList>(
//                 onSelected: (FilterList item) {
//                   context.read<PopupMenuCubit>().selectMenu(item);
//                 },
//                 itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
//                   PopupMenuItem<FilterList>(
//                     value: FilterList.bbcNews,
//                     child: Text('BBC News'),
//                   ),
//                   PopupMenuItem<FilterList>(
//                     value: FilterList.aryNews,
//                     child: Text('Ary News'),
//                   ),
//                   // Add other menu items here
//                 ],
//               ),
//      
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
