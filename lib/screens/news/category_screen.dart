import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/models/categ_news/categ_news.dart';

import 'package:news_application_2/screens/categ_detail/cartegrydetail_screen.dart';
import 'package:news_application_2/screens/widgets/categ_articles_list_tile_widget.dart';
import 'package:news_application_2/state_mgt/bloc/news_home/news_home_bloc.dart';
import 'package:news_application_2/utils/extensions/date_time_extension.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen(
      {super.key,
      required this.categoriesNewsModel,
      required this.newsHomeState});

  final CategoriesNewsModel categoriesNewsModel;
  final NewsHomeState newsHomeState;

  // String categoryName = 'General';
  // final NewsCategoriesRepo newsRepo = NewsCategoriesRepo();
  // CategoriesNewsMdl? newsData;

  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   fetchNewsData('General');
  //   // Fetch initial data for the 'General' category
  // }

  // Future<void> fetchNewsData(String category) async {
  //   try {
  //     final data = await newsRepo.fetchNewsCategoires(category);
  //     setState(() {
  //       newsData = data;
  //       // Sort articles by published date in ascending order
  //       newsData!.articles!.sort((a, b) => DateTime.parse(b.publishedAt!)
  //           .compareTo(DateTime.parse(a.publishedAt!)));
  //     });
  //   } catch (e) {
  //     // Handle error
  //     print('Error fetching news: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: context.mqh * .033,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                var categArticleList =
                    newsHomeState.categNewsList.data!.articles;
                return GestureDetector(
                  onTap: () {
                    // event  -> context.read<NewsHomeBloc>().add(Categ(categEvent: categoriesList[index]))
                    context.read<NewsHomeBloc>().add(
                        CategArticleNewsEvent(categ: categoriesList[index]));
                    context.read<NewsHomeBloc>().add(
                          UpdateSelectedCategoryEvent(
                              category: categoriesList[index]),
                        );
                    // setState(() {
                    //   categoryName = categoriesList[index];
                    // });

                    // fetchNewsData(categoriesList[
                    //     index]); // Fetch and update news based on selected category
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: newsHomeState.selectedCategory ==
                                categoriesList[index]
                            ? AppColors.blueLight
                            : AppColors.greyLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Center(
                          child:
                              BodyTextThemeWidget(title: categoriesList[index]),
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
                      // final categSrticle = categoriesNewsModel!.articles![index];
                      String timeAgo = DateTime.parse(
                              categArticles.publishedAt!)
                          .timeAgo(); // Replace with the actual published date

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
