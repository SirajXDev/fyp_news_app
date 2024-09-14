import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/configs/components/custom_notification_count_widget.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/data/response/status.dart';
import 'package:news_application_2/main.dart';
import 'package:news_application_2/models/categ_news/categ_news.dart';
import 'package:news_application_2/models/channels_headlines/channels_news_headlines.dart';
import 'package:news_application_2/screens/home/parts/headlines_news_card_widget.dart';
import 'package:news_application_2/screens/home/parts/home_news_separator.dart';
import 'package:news_application_2/screens/home/parts/pop_up_menu_widget.dart';
import 'package:news_application_2/screens/news/category_screen.dart';
import 'package:news_application_2/state_mgt/bloc/bloc/bookmark_bloc.dart';
import 'package:news_application_2/state_mgt/bloc/news_home/news_home_bloc.dart';
import 'package:news_application_2/utils/extensions/date_time_extension.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  // late NewsHomeBloc _newsHomeBloc;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: const TitleTextThemeWidget(
            title: 'The HeadLine News',
            size: 20,
          ),
          centerTitle: false,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: CustomNotificationCountWidget(icon: CupertinoIcons.bell),
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => NewsHomeBloc(
            categNewsRepo: getIt(),
            headlinesNewsRepo: getIt(),
          )
            ..add(HeadLinesArticleNewsEvent(categ: "bbc-news"))
            ..add(FetchNewsByCategoryEvent(categ: "General")),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Row(
                  children: [
                    TitleTextThemeWidget(title: "HeadLines"),
                    Spacer(),
                    PopupMenuWidget(),
                  ],
                ).paddingOnly(left: 10, right: 10),
                const SizedBox(height: 10),

                // Separate BlocBuilder for Headlines
                BlocBuilder<NewsHomeBloc, NewsHomeState>(
                  buildWhen: (previous, current) =>
                      previous.headLinesList != current.headLinesList,
                  builder: (context, state) {
                    if (state.headLinesList.status == Status.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.headLinesList.status == Status.error) {
                      return Center(
                        child: Text('Error: ${state.headLinesList.message}'),
                      );
                    } else if (state.headLinesList.status == Status.completed) {
                      NewsChannelHeadlineModel headLinesListState =
                          state.headLinesList.data!;

                      return SizedBox(
                        height: context.mqh * .31,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: headLinesListState.articles?.length ?? 0,
                          itemBuilder: (context, index) {
                            String timeAgo = DateTime.parse(
                              headLinesListState.articles![index].publishedAt
                                  .toString(),
                            ).timeAgo();
                            var headLinesData =
                                headLinesListState.articles![index];

                            return headLinesData.description != null
                                ? GestureDetector(
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      RoutesName.NEWS_DETAIL_SCREEN,
                                      arguments:
                                          headLinesListState.articles![index],
                                    ),
                                    child: HeadLinesNewsCardWidget(
                                      headlines:
                                          headLinesListState.articles![index],
                                      timeAgo: timeAgo,
                                    ),
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),

                const SizedBox(height: 10),
                const HomeNewsSeparator(),
                const SizedBox(height: 6),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TitleTextThemeWidget(title: 'Articles'),
                      const Spacer(),
                      CustomIconWidget(
                        icon: Icons.more_vert_outlined,
                        size: 17,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.mqh * .01),

                // Separate BlocBuilder for Categories
                BlocBuilder<NewsHomeBloc, NewsHomeState>(
                  buildWhen: (previous, current) =>
                      previous.categNewsList != current.categNewsList,
                  builder: (context, state) {
                    if (state.categNewsList.status == Status.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.categNewsList.status == Status.error) {
                      return Center(
                        child: Text('Error: ${state.categNewsList.message}'),
                      );
                    } else if (state.categNewsList.status == Status.completed) {
                      CategoriesNewsModel categArticleState =
                          state.categNewsList.data!;

                      return SizedBox(
                        height: 400,
                        child: CategoriesScreen(
                          categoriesNewsModel: categArticleState,
                          newsHomeState: state,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
