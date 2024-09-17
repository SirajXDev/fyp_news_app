import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/configs/components/divider_horizontal_widget.dart';
import 'package:news_application_2/data/response/status.dart';
import 'package:news_application_2/screens_module/search/parts/search_news_list_tiles.dart';
import 'package:news_application_2/screens_module/search/parts/searched_title.dart';
import 'package:news_application_2/state_mgt/bloc/search/bloc/search_news_bloc.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class RenderSearchedData extends StatelessWidget {
  const RenderSearchedData({
    super.key,
    required this.searchTextNotifier,
  });
  final ValueNotifier<String> searchTextNotifier;
  @override
  Widget build(BuildContext context) {
    // var articleList =
    //     context.watch<SearchNewsBloc>().state.searchNewsList.data!.articles!.where((v)=> v.title == ).;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder<String>(
          valueListenable: searchTextNotifier,
          builder: (context, searchText, child) {
            if (searchText.isNotEmpty) {
              return SearchedTitle(
                title: searchText,
              );
            }
            return const SizedBox.shrink();
          },
        ),
        const DividerHorizontalWidget(
          weight: .1,
          height: 1,
          endIndent: 100,
        ),
        SizedBox(
          height: context.mqh * .02,
        ),
        SizedBox(
          height: context.mqh * .7,
          child: BlocBuilder<SearchNewsBloc, SearchNewsState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              // var s = state.searchNewsList.data;
              switch (state.searchNewsList.status) {
                case Status.loading:
                  return const Align(
                    alignment: Alignment.center,
                    child: TitleTextThemeWidget(
                      title:
                          'News is not searched, please search your desired News ..',
                      size: 16,
                      textAlign: TextAlign.center,
                    ),
                  );
                case Status.error:
                  return Center(
                    child: BodyTextThemeWidget(
                      title: state.searchNewsList.message.toString(),
                    ),
                  );
                case Status.completed:
                  // Return your completed widget here
                  if (state.searchNewsList.data == null ||
                      state.searchNewsList.data!.articles == null ||
                      state.searchNewsList.data!.articles!.isEmpty) {
                    return const Align(
                      alignment: Alignment.center,
                      child: TitleTextThemeWidget(
                        title:
                            'No Data Found!, please use the correct keywords for better result, try again ..',
                        size: 16,
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return SearchNewsListTiles(
                      searchCategoriesNewsModel: state.searchNewsList.data,
                    );
                  }

                default:
                  // Handle default case
                  return const TitleTextThemeWidget(title: 'No Data !');
              }
            },
          ),
        )
      ],
    );
  }
}
