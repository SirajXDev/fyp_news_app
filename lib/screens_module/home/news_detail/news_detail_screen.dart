import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/main.dart';
import 'package:news_application_2/models/channels_headlines/channels_news_headlines.dart';
import 'package:news_application_2/repository/book_mark/book_mark_repo.dart';
import 'package:news_application_2/screens_module/widgets/news_web_launcher.dart';
import 'package:news_application_2/screens_module/widgets/sub_tile_news_source_widget.dart';
import 'package:news_application_2/services/local/hive/adaptor/book_mark_adaptor.dart';
import 'package:news_application_2/state_mgt/bloc/bookmark/bookmark_bloc.dart';
import 'package:news_application_2/utils/extensions/date_time_extension.dart';
import 'package:news_application_2/utils/extensions/flush_bar_extension.dart';
import 'package:news_application_2/utils/helper_methods/share_helper.dart';
import 'package:news_application_2/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

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

    return BlocProvider(
      create: (context) =>
          BookmarkBloc(baseBookMarkRepo: getIt<BaseBookMarkRepo>()),
      child: Scaffold(
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
              child: GestureDetector(
                onTap: () async {
                  // a link or just text if is an invalid url
                  await ShareHelper.shareLink(
                      url: '${headLines.url}', title: '${headLines.title}');

                  debugPrint('share it...');
                },
                child: Image(
                  image: const AssetImage('assets/images/share.png'),
                  height: 22,
                  color: Theme.of(context).colorScheme.primary,
                ),
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
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
                      // url: headLines.url!,
                      onTap: () => launchUrl(Uri.parse('${headLines.url}')),
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
          onPressed: () {
            String id = DateTime.now().toIso8601String();

            final bookMark = BookMarkHive()
              ..urlToImage = headLines.urlToImage
              ..title = headLines.title
              ..description = headLines.description
              ..author = headLines.author
              ..source = headLines.source?.name
              ..publishedAt = headLines.publishedAt
              ..id = id;

            final isFavorite = context
                .read<BookmarkBloc>()
                .baseBookMarkRepo
                .isFavorite(headLines.publishedAt!);

            if (isFavorite) {
              context.read<BookmarkBloc>().add(
                    RemoveFromBookMarkEvent(
                      key: bookMark.publishedAt!,
                    ),
                  );
              context.flushBarSuccessMessage(
                message: "Removed From Bookmarks! ${bookMark.title}",
                color: AppColors.red,
              );
            } else {
              context.read<BookmarkBloc>().add(
                    AddToBookMarkEvent(article: bookMark),
                  );
              context.flushBarSuccessMessage(
                message: "Added To Bookmarks! ${bookMark.title}",
              );
            }
            debugPrint('bookMarkTitle: $bookMark');
          },
          backgroundColor:
              Theme.of(context).floatingActionButtonTheme.backgroundColor,
          child: CustomIconWidget(
            icon: context.watch<BookmarkBloc>().state.bookMarkList.any(
                    (bookmark) => bookmark.publishedAt == headLines.publishedAt)
                ? CupertinoIcons.bookmark_fill
                : CupertinoIcons.bookmark,
            size: 22,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
