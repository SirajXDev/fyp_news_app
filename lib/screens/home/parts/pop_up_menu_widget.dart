import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/configs/const/news_filter_name.dart';
import 'package:news_application_2/state_mgt/cubit/popup_menu_cubit.dart';
import 'package:news_application_2/utils/enums.dart';
import 'package:news_application_2/utils/utils.dart';

class PopupMenuWidget extends StatelessWidget {
  const PopupMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopupMenuCubit(),
      child: BlocBuilder<PopupMenuCubit, String>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return PopupMenuButton<FilterList>(
            icon: const CustomIconWidget(
              icon: Icons.more_vert,
              size: 16,
            ),
            color: Theme.of(context).colorScheme.outline,
            onSelected: (FilterList item) {
              context.read<PopupMenuCubit>().selectMenu(item);
            },
            itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
              PopupMenuItem<FilterList>(
                value: FilterList.bbcNews,
                child: TitleTextThemeWidget(
                  title: 'BBC NEWS',
                  size: state == NewsFilterName.BBC ? 14 : 12,
                ),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.aryNews,
                child: TitleTextThemeWidget(
                  title: 'CNN NEWS',
                  size: state == NewsFilterName.CNN ? 14 : 12,
                ),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.aryNews,
                child: TitleTextThemeWidget(
                  title: 'AL JAZEERA ENGLISH',
                  size: state == NewsFilterName.ALJAZEERA ? 14 : 12,
                ),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.aryNews,
                child: TitleTextThemeWidget(
                  title: 'ARY NEWS',
                  size: state == NewsFilterName.ARY ? 14 : 12,
                ),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.aryNews,
                child: TitleTextThemeWidget(
                  title: 'INDEPENDENT NEWS',
                  size: state == NewsFilterName.INDEPENDENT ? 14 : 12,
                ),
              ),
              // Add other menu items here
            ],
          );
          // Text('Selected: $state'),
        },
      ),
    );
  }
}
