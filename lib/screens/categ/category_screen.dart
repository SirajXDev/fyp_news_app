import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_application_2/configs/color/color.dart';

import 'package:news_application_2/models/category_model.dart';
import 'package:news_application_2/repositiry%20copy/category_repo.dart';
import 'package:news_application_2/screens/categ_detail/cartegrydetail_screen.dart';
import 'package:news_application_2/screens/news_detail/news_detail_screen.dart';
import 'package:news_application_2/utils/extensions/date_time_extension.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final format = DateFormat('MMM dd, yyyy');
  String categoryName = 'General';
  final NewsCategoriesRepo newsRepo = NewsCategoriesRepo();
  CategoriesNewsMdl? newsData;

  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];

  @override
  void initState() {
    super.initState();
    fetchNewsData('General');
    // Fetch initial data for the 'General' category
  }

  Future<void> fetchNewsData(String category) async {
    try {
      final data = await newsRepo.fetchNewsCategoires(category);
      setState(() {
        newsData = data;
        // Sort articles by published date in ascending order
        newsData!.articles!.sort((a, b) => DateTime.parse(b.publishedAt!)
            .compareTo(DateTime.parse(a.publishedAt!)));
      });
    } catch (e) {
      // Handle error
      print('Error fetching news: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: context.mqh * .033,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      categoryName = categoriesList[index];
                    });
                    fetchNewsData(categoriesList[
                        index]); // Fetch and update news based on selected category
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: categoryName == categoriesList[index]
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
            child: newsData == null
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: newsData!.articles
                            ?.where((article) => article.urlToImage != null)
                            .length ??
                        0, // Use the actual item count

                    itemBuilder: (context, index) {
                      final filteredArticles = newsData!.articles!
                          .where((article) => article.urlToImage != null)
                          .toList();
                      final article = filteredArticles[index];
                      // final article = newsData!.articles![index];
                      String timeAgo = DateTime.parse(article.publishedAt!)
                          .timeAgo(); // Replace with the actual published date

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryNewsDetailScreen(
                                        article: article,
                                      )));
                        },
                        child: article.author != null &&
                                article.urlToImage != null
                            ? Row(
                                children: [
                                  article.urlToImage != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl: article.urlToImage ??
                                                '', // Use the actual image URL
                                            fit: BoxFit.cover,
                                            height: height * .18,
                                            width: width * .3,
                                            placeholder: (context, url) =>
                                                const Center(
                                              child: SpinKitCircle(
                                                  size: 50, color: Colors.blue),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.error_outline,
                                              color: Colors.red,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  Expanded(
                                    child: Container(
                                      height: height * .18,
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          article.author != null
                                              ? CustomChip(
                                                  child: BodyTextThemeWidget(
                                                    title: article.author ?? '',
                                                    size: 12,
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          article.author != null
                                              ? const SizedBox(
                                                  height: 10,
                                                )
                                              : const SizedBox(
                                                  height: 30,
                                                ),
                                          TitleTextThemeWidget(
                                            title: article.title ?? '',
                                            size: 16,
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: CustomChip(
                                                  color: AppColors.greenLight,
                                                  child: BodyTextThemeWidget(
                                                    title:
                                                        article.source?.name ??
                                                            '',
                                                    size: 12,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: BodyTextThemeWidget(
                                                  title: timeAgo,
                                                  size: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
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
