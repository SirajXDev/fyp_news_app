import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/state_mgt/bloc/news_home/news_home_bloc.dart';
import 'package:news_application_2/utils/enums.dart';
import 'package:news_application_2/utils/utils.dart';

class PopupMenuWidget extends StatelessWidget {
  const PopupMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<FilterList>(
      icon: const CustomIconWidget(
        icon: Icons.more_vert,
        size: 16,
      ),
      color: Theme.of(context).colorScheme.outline,
      onSelected: (FilterList item) {
        context
            .read<NewsHomeBloc>()
            .add(HeadLinesArticleNewsEvent(categ: item.name));
      },
      itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
        const PopupMenuItem<FilterList>(
          value: FilterList.bbcNews,
          child: TitleTextThemeWidget(
            title: 'BBC NEWS',
            size: 12,
          ),
        ),
        const PopupMenuItem<FilterList>(
          value: FilterList.aryNews,
          child: TitleTextThemeWidget(
            title: 'CNN NEWS',
            size: 12,
          ),
        ),
        const PopupMenuItem<FilterList>(
          value: FilterList.aryNews,
          child: TitleTextThemeWidget(
            title: 'AL JAZEERA ENGLISH',
            size: 12,
          ),
        ),
        const PopupMenuItem<FilterList>(
          value: FilterList.aryNews,
          child: TitleTextThemeWidget(
            title: 'ARY NEWS',
            size: 12,
          ),
        ),
        const PopupMenuItem<FilterList>(
          value: FilterList.aryNews,
          child: TitleTextThemeWidget(
            title: 'INDEPENDENT NEWS',
            size: 12,
          ),
        ),
        // Add other menu items here
      ],
    );
  }
}
