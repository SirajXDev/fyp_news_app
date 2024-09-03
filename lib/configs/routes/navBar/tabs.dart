import 'package:flutter/material.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/screens/home/home_screen.dart';
import 'package:news_application_2/screens/setting/setting_view.dart';

final List<Widget> tabsViews = [
  const HomeScreen(),
  const SearchView(),
  const BookMarkView(),
  const SettingView(),
];

// class CategView extends StatelessWidget {
//   const CategView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       appBar: AppBar(
//         title: const Text('Category'),
//         centerTitle: true,
//       ),
//       body: const Column(
//         children: [],
//       ),
//     );
//   }
// }

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}

class BookMarkView extends StatelessWidget {
  const BookMarkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: const Text('BookMark'),
        centerTitle: true,
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
