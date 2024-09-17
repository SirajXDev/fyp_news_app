import 'package:flutter/material.dart';
import 'package:news_application_2/configs/components/divider_horizontal_widget.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/models/categ_news/categ_news.dart';
import 'package:news_application_2/screens_module/widgets/categ_articles_list_tile_widget.dart';
import 'package:news_application_2/utils/extensions/date_time_extension.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class SearchNewsListTiles extends StatelessWidget {
  const SearchNewsListTiles(
      {super.key, required this.searchCategoriesNewsModel});
  final CategoriesNewsModel? searchCategoriesNewsModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.mqh * 0.7,
      child: ListView.separated(
        itemBuilder: (context, index) {
          Articles? searchArticles =
              searchCategoriesNewsModel?.articles?[index];
          String timeAgo = DateTime.parse(
            searchArticles!.publishedAt.toString(),
          ).timeAgo();
          debugPrint('searchArticles:$searchArticles');
          if (['[Removed]'].every((element) => [
                searchArticles.title,
                searchArticles.author,
                searchArticles.description,
                searchArticles.urlToImage
              ].contains(element))) {
            return const SizedBox.shrink();
          } else if (searchArticles.urlToImage == null ||
              searchArticles.author == null ||
              searchArticles.title == null ||
              searchArticles.description == null ||
              searchArticles.source == null) {
            return const SizedBox.shrink();
          } else {
            return searchCategoriesNewsModel?.articles == null
                ? const TitleTextThemeWidget(title: 'No Data Found')
                : GestureDetector(
                    onTap: () {
                      // search detail...
                      Navigator.pushNamed(
                        context,
                        RoutesName.SEARCH_DETAIL,
                        arguments: searchCategoriesNewsModel?.articles?[index]
                            as Articles,
                      );
                    },
                    child: CategArticlesListTilesWidget(
                      imageUrl: searchArticles.urlToImage,
                      title: searchArticles.title ?? 'title',
                      source: searchArticles.source?.name ?? 'source',
                      author: searchArticles.author ?? 'author',
                      timeAgo: timeAgo,
                    ).paddingOnly(bottom: 6),
                  );
          }
        },
        separatorBuilder: (context, index) => const DividerHorizontalWidget(),
        itemCount: searchCategoriesNewsModel?.articles?.length ?? 0,
        // shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
