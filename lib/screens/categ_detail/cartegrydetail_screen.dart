import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_application_2/configs/color/color.dart';

import 'package:news_application_2/models/category_model.dart';
import 'package:news_application_2/screens/widgets/sub_tile_news_source_widget.dart';
import 'package:news_application_2/utils/extensions/date_time_extension.dart';
import 'package:news_application_2/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryNewsDetailScreen extends StatefulWidget {
  final Articles article;

  const CategoryNewsDetailScreen({super.key, required this.article});

  @override
  State<CategoryNewsDetailScreen> createState() =>
      _CategoryNewsDetailScreenState();
}

class _CategoryNewsDetailScreenState extends State<CategoryNewsDetailScreen> {
  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DateTime dateTime =
        DateTime.parse(widget.article.publishedAt ?? DateTime.now().toString());
    String timeAgo = dateTime.timeAgo();

    return Scaffold(
      appBar: AppBar(
        title: const TitleTextThemeWidget(title: 'Article Detail View'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: Image(
              image: const AssetImage('assets/images/share.png'),
              height: 25,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Stack(
          children: [
            SizedBox(
              height: height * 0.45,
              width: width,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.article.urlToImage ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.4),
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              height: height * 0.6,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                children: [
                  SizedBox(height: height * 0.01),
                  const TitleTextThemeWidget(title: 'Title :'),
                  SizedBox(height: height * 0.01),
                  TitleTextThemeWidget(
                    title: widget.article.title ?? 'No title',
                    size: 17,
                  ),
                  SizedBox(height: height * 0.02),
                  SubTilesNewsSourceWidget(
                    source: widget.article.source?.name,
                    author: widget.article.author,
                    timeAgo: timeAgo,
                  ),
                  SizedBox(height: height * 0.01),
                  const Divider(),
                  SizedBox(height: height * 0.01),
                  const TitleTextThemeWidget(title: 'Description :'),
                  SizedBox(height: height * 0.01),
                  BodyTextThemeWidget(
                    title: widget.article.content ?? 'No content',
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            launchUrl(
                              Uri.parse('https:${widget.article.url}'),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 1.2),
                            decoration: BoxDecoration(
                              color: AppColors.orangeLight,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const BodyTextThemeWidget(
                                title: "learn More.."),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.bookmark_outline,
          size: 30,
          color: AppColors.blackLight,
        ),
      ),
    );
  }
}
