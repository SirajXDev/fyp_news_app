import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/main.dart';
import 'package:news_application_2/models/categ_news/categ_news.dart';
import 'package:news_application_2/repository/book_mark/book_mark_repo.dart';
import 'package:news_application_2/screens_module/widgets/news_web_launcher.dart';
import 'package:news_application_2/screens_module/widgets/sub_tile_news_source_widget.dart';
import 'package:news_application_2/state_mgt/bookmark/bookmark_bloc.dart';

import 'package:news_application_2/utils/extensions/date_time_extension.dart';
import 'package:news_application_2/utils/helper_methods/share_helper.dart';
import 'package:news_application_2/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryNewsDetailScreen extends StatelessWidget {
  const CategoryNewsDetailScreen({super.key, required this.article});
  final Articles article;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DateTime dateTime =
        DateTime.parse(article.publishedAt ?? DateTime.now().toString());
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
                  await ShareHelper.shareLink(
                      url: '${article.url}', title: '${article.title}');
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
                    imageUrl: article.urlToImage!,
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
                      title: article.title!,
                      size: 16,
                    ),
                    SizedBox(height: height * 0.02),
                    SubTilesNewsSourceWidget(
                      source: article.source!.name,
                      author: article.author!.length > 8
                          ? article.author?.substring(0, 8)
                          : article.author!,
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
                      title: article.description ?? '',
                      shrinkWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    NewsWebLauncherWidget(
                      url: article.url!,
                      onTap: () => launchUrl(Uri.parse('${article.url}')),
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
            // final bookmarkBloc = context.read<BookmarkBloc>();
            // final articleBookMarkAdaptor = BookMarkHive();

            // if (!bookmarkBloc.state.bookMarkList
            //     .contains(articleBookMarkAdaptor)) {
            //   bookmarkBloc
            //       .add(AddToBookMarkEvent(article: articleBookMarkAdaptor));
            // }
          },
          backgroundColor:
              Theme.of(context).floatingActionButtonTheme.backgroundColor,
          child: BlocBuilder<BookmarkBloc, BookmarkState>(
            builder: (ctx, state) {
              // var b = state.bookMarkList;
              bool isFavourite = state.bookMarkList
                  .any((categArticle) => categArticle.title == article.title);
              return CustomIconWidget(
                icon: isFavourite
                    ? CupertinoIcons.bookmark
                    : CupertinoIcons.bookmark_fill,
                size: 22,
                color: Theme.of(context).colorScheme.primary,
              );
            },
          ),
        ),
      ),
    );
  }
}
