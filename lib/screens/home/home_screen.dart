import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/configs/components/custom_notification_count_widget.dart';
import 'package:news_application_2/models/news_channel_headline.dart';
import 'package:news_application_2/screens/news/category_screen.dart';
import 'package:news_application_2/screens/home/parts/headlines_news_card_widget.dart';
import 'package:news_application_2/screens/home/parts/home_news_separator.dart';
import 'package:news_application_2/screens/home/parts/pop_up_menu_widget.dart';
import 'package:news_application_2/screens/news_detail/news_detail_screen.dart';
import 'package:news_application_2/utils/extensions/date_time_extension.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/utils.dart';
import 'package:news_application_2/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final format = DateFormat('MMMM dd, yyyy');

  NewsViewModel newsViewModel = NewsViewModel();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

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
            // notification section ...
            Padding(
              padding: EdgeInsets.only(
                right: 10,
              ),
              child: CustomNotificationCountWidget(icon: CupertinoIcons.bell),
            ),
          ],
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                TitleTextThemeWidget(title: "HeadLines"),
                Spacer(),
                PopupMenuWidget(),
              ],
            ).paddingOnly(left: 10, right: 10),

            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: height * .30,
              width: width,
              child: FutureBuilder<NewsChannelHeadlineMdl>(
                future: newsViewModel.fetchNewsChannelHeadlineApi('bbc-news'),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(
                        color: Colors.blue,
                        size: 50,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData ||
                      snapshot.data!.articles!.isEmpty) {
                    return const Center(
                      child: Text('No data available'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(
                          snapshot.data!.articles![index].publishedAt
                              .toString(),
                        );

                        String timeAgo = dateTime.timeAgo();
                        Articles headLines = snapshot.data!.articles![index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetailScreen(
                                    headLines: headLines,
                                  ),
                                ));
                          },
                          child:
                              // HeadlinesNewsCardWidget(),
                              HeadLinesNewsCardWidget(
                                  headlines: headLines, timeAgo: timeAgo),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const HomeNewsSeparator(),
            const SizedBox(
              height: 6,
            ),
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
            SizedBox(
              height: context.mqh * .01,
            ),

            //here the list which show down the headline section
            const SizedBox(
              height: 400,
              child: CategoriesScreen(),
              // NewslistScreen()
            ),
          ],
        ),
      ),
    );
  }
}
