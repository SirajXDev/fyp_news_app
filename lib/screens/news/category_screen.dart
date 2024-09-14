// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/configs/const/news_categ_list.dart';
import 'package:news_application_2/models/categ_news/categ_news.dart';

import 'package:news_application_2/screens/categ_detail/cartegrydetail_screen.dart';
import 'package:news_application_2/screens/widgets/categ_articles_list_tile_widget.dart';
import 'package:news_application_2/state_mgt/bloc/news_home/news_home_bloc.dart';
import 'package:news_application_2/utils/extensions/date_time_extension.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.categoriesNewsModel,
      required this.newsHomeState});

  final CategoriesNewsModel categoriesNewsModel;
  final NewsHomeState newsHomeState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: context.mqh * .033,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: NewsCategList.categoriesList.length,
              itemBuilder: (context, index) {
                String categ = NewsCategList.categoriesList[index];
                return GestureDetector(
                  onTap: () {
                    context
                        .read<NewsHomeBloc>()
                        .add(FetchNewsByCategoryEvent(categ: categ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: newsHomeState.selectedCategory == categ
                            ? AppColors.blueLight
                            : AppColors.greyLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Center(
                          child: BodyTextThemeWidget(title: categ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          15.h,
          Expanded(
            child: categoriesNewsModel == null
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: categoriesNewsModel.articles
                            ?.where((article) => article.urlToImage != null)
                            .length ??
                        0, // Use the actual item count

                    itemBuilder: (context, index) {
                      final categFilteredArticles = categoriesNewsModel
                          .articles!
                          .where((article) => article.urlToImage != null)
                          .toList();
                      final categArticles = categFilteredArticles[index];
                      String timeAgo =
                          DateTime.parse(categArticles.publishedAt!).timeAgo();

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryNewsDetailScreen(
                                article: categArticles,
                              ),
                            ),
                          );
                        },
                        child: categArticles.author != null
                            ? CategArticlesListTilesWidget(
                                imageUrl: categArticles.urlToImage,
                                author: categArticles.author,
                                source: categArticles.source?.name,
                                title: categArticles.title,
                                timeAgo: timeAgo)
                            : const SizedBox.shrink(),
                      ).paddingOnly(bottom: 4);
                    },
                  ),
          ),
        ],
      ).paddingSymmetric(
        horizontal: 10,
      ),
    );
  }
}
