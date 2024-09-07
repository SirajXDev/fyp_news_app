import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/models/channels_headlines/channels_news_headlines.dart';
import 'package:news_application_2/screens/widgets/news_web_launcher.dart';
import 'package:news_application_2/screens/widgets/sub_tile_news_source_widget.dart';
import 'package:news_application_2/utils/extensions/date_time_extension.dart';
import 'package:news_application_2/utils/utils.dart';

// ignore: must_be_immutable
class NewsDetailScreen extends StatelessWidget {
  NewsDetailScreen({
    super.key,
    required this.headLines,
  });
  Articles headLines;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DateTime dateTime = DateTime.parse(headLines.publishedAt!);
    String timeAgo = dateTime.timeAgo();

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
              height: height * 0.45,
              width: width,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: CachedNetworkImage(
                  imageUrl: headLines.urlToImage!,
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
                  const TitleTextThemeWidget(title: "Title :"),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleTextThemeWidget(
                    title: headLines.title!,
                    size: 16,
                  ),
                  SizedBox(height: height * 0.02),
                  SubTilesNewsSourceWidget(
                    source: headLines.source!.name,
                    author: headLines.author,
                    timeAgo: timeAgo,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  const Divider(
                    thickness: .8,
                  ),
                  SizedBox(
                    height: height * 0.001,
                  ),
                  const TitleTextThemeWidget(title: "Description :"),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  BodyTextThemeWidget(
                    title: headLines.description ?? '',
                    shrinkWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(
                    height: height * 0.006,
                  ),
                  NewsWebLauncherWidget(
                    url: headLines.url!,
                    onTap: () => Utils().launcherUrl(headLines.url!),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
        child: CustomIconWidget(
          icon: CupertinoIcons.bookmark,
          size: 22,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
