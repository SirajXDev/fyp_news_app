import 'package:flutter/material.dart';
import 'package:news_application_2/screens_module/bookmark/book_mark_view.dart';
import 'package:news_application_2/screens_module/home/home_screen.dart';
import 'package:news_application_2/screens_module/search/search_view.dart';
import 'package:news_application_2/screens_module/setting/setting_view.dart';

final List<Widget> tabsViews = [
  const HomeScreen(),
  const SearchView(),
  const BookMarkView(),
  const SettingView(),
];
