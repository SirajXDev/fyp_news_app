import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/configs/components/divider_horizontal_widget.dart';
import 'package:news_application_2/configs/components/heading_text_widget.dart';
import 'package:news_application_2/screens_module/bookmark/parts/emty_book_mark_widget.dart';
import 'package:news_application_2/screens_module/widgets/categ_articles_list_tile_widget.dart';
import 'package:news_application_2/state_mgt/bloc/bookmark/bookmark_bloc.dart';
import 'package:news_application_2/utils/extensions/flush_bar_extension.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';

class BookMarkView extends StatefulWidget {
  const BookMarkView({super.key});

  @override
  State<BookMarkView> createState() => _BookMarkViewState();
}

class _BookMarkViewState extends State<BookMarkView> {
  @override
  void initState() {
    super.initState();
    context.read<BookmarkBloc>().add(ReadDataFromBookMarkEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: context.mqh * .03,
            ),
            HeadingTextWidget(
              headingText: 'BookMark',
              color: Theme.of(context).colorScheme.primary,
            ),
            const DividerHorizontalWidget(
              endIndent: 20,
            ),
            SizedBox(
              height: context.mqh * .01,
            ),
            BlocBuilder<BookmarkBloc, BookmarkState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                if (state.bookMarkList.isNotEmpty) {
                  return Expanded(
                    child: GestureDetector(
                        child: ListView.builder(
                      itemCount: state.bookMarkList.length,
                      itemBuilder: (context, index) {
                        var bookMarkArticles = state.bookMarkList[index];

                        return Dismissible(
                          key: ValueKey(
                            bookMarkArticles.publishedAt,
                          ), // Unique key for each item
                          onDismissed: (direction) {
                            context.read<BookmarkBloc>().add(
                                  RemoveFromBookMarkEvent(
                                    key: bookMarkArticles.publishedAt!,
                                  ),
                                );
                            context.flushBarSuccessMessage(
                                message:
                                    "Removed from Bookmarks!:\t${bookMarkArticles.title}",
                                color: AppColors.red);
                          },
                          background: Container(
                            alignment: Alignment.centerRight,
                            child: const CustomIconWidget(
                              icon: Icons.delete,
                              color: AppColors.redLight,
                              size: 30,
                            ),
                          ),

                          child: GestureDetector(
                            onTap: () {
                              debugPrint(
                                  'bookMrkFavList: ${state.bookMarkList}');
                            },
                            child: CategArticlesListTilesWidget(
                              imageUrl: bookMarkArticles.urlToImage,
                              title: bookMarkArticles.title,
                              author: bookMarkArticles.author,
                              source: bookMarkArticles.source,
                              // timeAgo: timeAgo,
                            ).paddingOnly(bottom: context.mqw * .02),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                    )),
                  );
                } else {
                  return const Expanded(child: EmptyBookMarkWidget());
                }
              },
            ),
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 15),
      ),
    );
  }
}
