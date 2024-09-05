import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/models/news_channel_headline.dart';
import 'package:news_application_2/screens/setting/setting_view.dart';
import 'package:news_application_2/screens/widgets/sub_tile_news_source_widget.dart';
import 'package:news_application_2/utils/extensions/date_time_extension.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/launch_url_method.dart';
import 'package:news_application_2/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class NewsDetailScreen extends StatefulWidget {
  NewsDetailScreen({
    super.key,
    required this.headLines,
  });
  Articles headLines;
  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format = DateFormat('MMMM dd,yyyy');

  @override
  void initState() {
    super.initState();
    debugPrint(widget.headLines.description);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DateTime dateTime = DateTime.parse(widget.headLines.publishedAt!);
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
                  imageUrl: widget.headLines.urlToImage!,
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
                    title: widget.headLines.title!,
                    size: 16,
                  ),
                  SizedBox(height: height * 0.02),
                  SubTilesNewsSourceWidget(
                    source: widget.headLines.source!.name,
                    author: widget.headLines.author,
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
                    title: widget.headLines.description ?? '',
                    shrinkWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(
                    height: height * 0.006,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            launchUrl(
                              Uri.parse('https:${widget.headLines.url!}'),
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
