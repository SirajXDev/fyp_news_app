import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/configs/components/divider_horizontal_widget.dart';
import 'package:news_application_2/configs/components/heading_text_widget.dart';
import 'package:news_application_2/data/response/status.dart';
import 'package:news_application_2/main.dart';
import 'package:news_application_2/models/categ_news/categ_news.dart';
import 'package:news_application_2/screens/widgets/categ_articles_list_tile_widget.dart';
import 'package:news_application_2/state_mgt/bloc/search/bloc/search_news_bloc.dart';
import 'package:news_application_2/utils/enums.dart';
import 'package:news_application_2/utils/extensions/date_time_extension.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

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
                  const SearchNewsTextField(),
                  // sortBy
                  // const SortBySearch(),
                  SizedBox(
                    height: context.mqh * .02,
                  ),

                  SizedBox(
                    height: context.mqh * .01,
                  ),
                  // render searched data
                  const RenderSearchedData(),
                ],
              ).paddingSymmetric(horizontal: 15),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchNewsTextField extends StatefulWidget {
  const SearchNewsTextField({
    super.key,
  });

  @override
  State<SearchNewsTextField> createState() => _SearchNewsTextFieldState();
}

class _SearchNewsTextFieldState extends State<SearchNewsTextField> {
  final TextEditingController _searchTextController = TextEditingController();
  // String? _selectedFilter;

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextField(
            controller: _searchTextController,
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
            String text = _searchTextController.text.trim();
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

class RenderSearchedData extends StatelessWidget {
  const RenderSearchedData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchedTitle(
          title: 'Imran Khan',
        ),
        const DividerHorizontalWidget(
          weight: .1,
          endIndent: 100,
        ),
        SizedBox(
          width: context.mqw * 0.1,
        ),
        SizedBox(
          height: 400,
          child: BlocBuilder<SearchNewsBloc, SearchNewsState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              // var s = state.searchNewsList.data;
              switch (state.searchNewsList.status) {
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());
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
                    return const TitleTextThemeWidget(title: 'No Data Found!');
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

class SearchNewsListTiles extends StatelessWidget {
  const SearchNewsListTiles(
      {super.key, required this.searchCategoriesNewsModel});
  final CategoriesNewsModel? searchCategoriesNewsModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.mqh * 0.7, // Adjust this height as needed
      child: ListView.separated(
        itemBuilder: (context, index) {
          Articles? searchArticles =
              searchCategoriesNewsModel?.articles?[index];
          String timeAgo = DateTime.parse(
            searchArticles!.publishedAt.toString(),
          ).timeAgo();
          debugPrint('searchArticles:$searchArticles');
          return searchCategoriesNewsModel?.articles == null
              ? const TitleTextThemeWidget(title: 'No Data Found')
              : CategArticlesListTilesWidget(
                  imageUrl: searchArticles.urlToImage,
                  title: searchArticles.title ?? 'title',
                  source: searchArticles.source?.name ?? 'source',
                  author: searchArticles.author ?? 'author',
                  timeAgo: timeAgo,
                );
        },
        separatorBuilder: (context, index) => const DividerHorizontalWidget(),
        itemCount: searchCategoriesNewsModel?.articles?.length ?? 0,
        // shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}

class SearchedTitle extends StatelessWidget {
  const SearchedTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        TitleTextThemeWidget(
          title: 'Shows Data For ',
          color: AppColors.grey,
        ),
        TitleTextThemeWidget(
          title: 'Imran Khan',
        ),
      ],
    );
  }
}
