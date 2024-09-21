import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/state_mgt/bloc/search/search_news_bloc.dart';
import 'package:news_application_2/utils/enums.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class SearchNewsTextField extends StatelessWidget {
  const SearchNewsTextField({
    super.key,
    required this.searchTextController,
    required this.onChanged,
  });

  final TextEditingController searchTextController;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextField(
            controller: searchTextController,
            onChanged: onChanged,
            autofocus: false,
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(
                CupertinoIcons.search,
                color: Theme.of(context).colorScheme.secondary,
              ),
              labelStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              suffixIcon: PopupMenuButton(
                icon: CustomIconWidget(
                  icon: Icons.sort,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                color: Theme.of(context).colorScheme.outline,
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: SearchFilter.publishedAt,
                    child: TitleTextThemeWidget(
                      title: 'Published At',
                      size: 12,
                    ),
                  ),
                  const PopupMenuItem(
                    value: SearchFilter.relevancy,
                    child: TitleTextThemeWidget(
                      title: 'Relevancy',
                      size: 12,
                    ),
                  ),
                  const PopupMenuItem(
                    value: SearchFilter.popularity,
                    child: TitleTextThemeWidget(
                      title: 'popularity',
                      size: 12,
                    ),
                  ),
                ],
                onSelected: (filter) {
                  context.read<SearchNewsBloc>().add(
                        SearchedSortedByArticleEvent(searchFilter: filter),
                      );

                  if (kDebugMode) {
                    print('Selected: ${filter.name}');
                  }
                },
              ),
            ),
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
        SizedBox(
          width: context.mqw * .02,
        ),
        GestureDetector(
          onTap: () {
            String text = searchTextController.text.trim();
            String sortBy =
                context.read<SearchNewsBloc>().state.searchSelectedMenu;
            if (text.isEmpty) return;
            context.read<SearchNewsBloc>().add(
                  SearchArticlesEvent(keyword: text, sortBy: sortBy),
                );

            debugPrint('SearchtText: $text');
            debugPrint('SearchSortBy: $sortBy');
          },
          child: Image(
            image: const AssetImage(
              'assets/images/search.png',
            ),
            height: context.mqh * .04,
            color: Theme.of(context).colorScheme.secondary,
          ),
        )
      ],
    );
  }
}
