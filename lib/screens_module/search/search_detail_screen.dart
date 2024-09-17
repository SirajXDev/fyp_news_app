import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/models/categ_news/categ_news.dart';
import 'package:news_application_2/screens_module/widgets/news_web_launcher.dart';
import 'package:news_application_2/screens_module/widgets/sub_tile_news_source_widget.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SearchDetailScreen extends StatelessWidget {
  SearchDetailScreen({
    required this.searchedArticle,
    super.key,
  });
  Articles? searchedArticle;

  @override
  Widget build(BuildContext context) {
    // DateTime dateTime = DateTime.parse(searchedArticle!.publishedAt!);
    // String timeAgo = dateTime.timeAgo();

    return Scaffold(
      appBar: AppBar(
        title: const TitleTextThemeWidget(title: 'News Detail View'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: CustomIconWidget(
            icon: Icons.arrow_back_ios,
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
              height: 22,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Stack(
          children: [
            SizedBox(
              height: context.mqh * 0.45,
              width: context.mqw,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: CachedNetworkImage(
                  imageUrl: searchedArticle?.urlToImage ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: context.mqh * 0.4),
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              height: context.mqh * 0.6,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                children: [
                  const TitleTextThemeWidget(title: "Title :"),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleTextThemeWidget(
                    title: searchedArticle?.title ?? 'title',
                    size: 16,
                  ),
                  SizedBox(height: context.mqh * 0.02),
                  SubTilesNewsSourceWidget(
                    source: searchedArticle?.source?.name,
                    author: searchedArticle?.author,
                    // timeAgo: timeAgo,
                  ),
                  SizedBox(
                    height: context.mqh * 0.01,
                  ),
                  const Divider(
                    thickness: .8,
                  ),
                  SizedBox(
                    height: context.mqh * 0.001,
                  ),
                  const TitleTextThemeWidget(title: "Description :"),
                  SizedBox(
                    height: context.mqh * 0.01,
                  ),
                  BodyTextThemeWidget(
                    title: searchedArticle?.description ?? '',
                    shrinkWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(
                    height: context.mqh * 0.006,
                  ),
                  NewsWebLauncherWidget(
                    // url: searchedArticle.url!,
                    onTap: () =>
                        launchUrl(Uri.parse('${searchedArticle?.url}')),
                  ),
                  SizedBox(
                    height: context.mqh * 0.04,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
