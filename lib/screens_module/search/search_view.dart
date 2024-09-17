import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/configs/components/heading_text_widget.dart';
import 'package:news_application_2/main.dart';
import 'package:news_application_2/screens_module/search/parts/render_searched_data.dart';
import 'package:news_application_2/screens_module/search/parts/search_news_text_field.dart';
import 'package:news_application_2/state_mgt/bloc/search/bloc/search_news_bloc.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchTextController = TextEditingController();
  final ValueNotifier<String> searchTextNotifier = ValueNotifier('');
  Timer? _debounce; // Timer for debounce

  @override
  void dispose() {
    searchTextController.dispose();
    searchTextNotifier.dispose();
    _debounce?.cancel(); // Cancel the timer if it exists

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchNewsBloc(searchNewsRepo: getIt()),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.mqh * .03,
                  ),
                  // page titlle
                  HeadingTextWidget(
                    headingText: 'Search',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(
                    height: context.mqh * .02,
                  ),
                  // searh field
                  SearchNewsTextField(
                    searchTextController: searchTextController,
                    onChanged: (text) {
                      // Cancel the previous timer
                      _debounce?.cancel();
                      // Start a new timer
                      _debounce = Timer(const Duration(milliseconds: 300), () {
                        searchTextNotifier.value =
                            text; // Update ValueNotifier after delay
                      });
                    },
                  ),
                  SizedBox(
                    height: context.mqh * .02,
                  ),
                  // render searched data
                  RenderSearchedData(
                    searchTextNotifier: searchTextNotifier,
                  ),
                ],
              ).paddingSymmetric(horizontal: 15),
            ),
          ),
        ),
      ),
    );
  }
}
