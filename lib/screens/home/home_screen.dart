import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/configs/components/custom_chip.dart';
import 'package:news_application_2/firebase/Firebase_Auth_view/login_screen.dart';
import 'package:news_application_2/models/news_channel_headline.dart';
import 'package:news_application_2/screens/categ/category_screen.dart';
import 'package:news_application_2/screens/news_detail/news_detail_screen.dart';
import 'package:news_application_2/screens/setting/setting_view.dart';
import 'package:news_application_2/utils/extensions/date_time_extension.dart';
import 'package:news_application_2/utils/extensions/flush_bar_extension.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/utils.dart';
import 'package:news_application_2/view_model/news_view_model.dart';

import '../../configs/components/components_export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, aryNews, independent, cnn, aljazeera, googleNews }

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  final format = DateFormat('MMMM dd, yyyy');

  String name = 'bbc-news';
  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenu;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: const TitleTextThemeWidget(
            title: 'The HeadLine News',
            size: 20,
          ),
          centerTitle: false,
          actions: [
            // notification section ...
            Padding(
              padding: const EdgeInsets.only(
                right: 0,
              ),
              child: IconButton(
                  onPressed: () {},
                  icon: Badge.count(
                    count: 1,
                    child: Icon(CupertinoIcons.bell,
                        color: Theme.of(context).colorScheme.primary),
                  )),
              // Icon(
              //   CupertinoIcons.bell,
              //   size: 20,
              //   color: Theme.of(context).colorScheme.primary,
              // ),
            ),
          ],
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              height: context.mqh * .02,
            ),
            if (AdaptiveTheme.of(context).mode.isLight)
              AdaptiveTheme.of(context).mode.isLight
                  ? DividerHorizontalWidget(
                      height: 0,
                      startIndent: context.mqw * .028,
                      endIndent: context.mqw * .44,
                    )
                  : const SizedBox.shrink(),

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 0),
              child: Row(
                children: [
                  const TitleTextThemeWidget(title: "HeadLines"),
                  const Spacer(),
                  // 10.w,
                  PopupMenuButton<FilterList>(
                    surfaceTintColor: AppColors.black,
                    initialValue: selectedMenu,
                    icon: CustomIconWidget(
                      icon: Icons.more_vert_outlined,
                      size: 15,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onSelected: (FilterList item) {
                      setState(() {
                        selectedMenu = item;
                        if (item == FilterList.bbcNews) {
                          name = 'bbc-news';
                        }
                        if (item == FilterList.aryNews) {
                          name = 'ary-news';
                        }
                        if (item == FilterList.aljazeera) {
                          name = 'al-jazeera-english';
                        }
                        if (item == FilterList.cnn) {
                          name = 'cnn';
                        }
                        if (item == FilterList.independent) {
                          name = 'independent';
                        }
                        if (item == FilterList.googleNews) {
                          name = 'google-news';
                        }
                      });
                    },
                    itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                      const PopupMenuItem<FilterList>(
                        value: FilterList.bbcNews,
                        child: Text('BBC News'),
                      ),
                      const PopupMenuItem<FilterList>(
                        value: FilterList.aryNews,
                        child: Text('Ary News'),
                      ),
                      const PopupMenuItem<FilterList>(
                        value: FilterList.aljazeera,
                        child: Text('Al Jazeera English'),
                      ),
                      const PopupMenuItem<FilterList>(
                        value: FilterList.cnn,
                        child: Text('CNN'),
                      ),
                      const PopupMenuItem<FilterList>(
                        value: FilterList.independent,
                        child: Text('Independent'),
                      ),
                      const PopupMenuItem<FilterList>(
                        value: FilterList.independent,
                        child: Text('google-news'),
                      ),
                      PopupMenuItem(
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Logout'),
                            Icon(Icons.logout_outlined)
                          ],
                        ),
                        onTap: () {
                          auth.signOut().then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          }).onError((error, stackTrace) {
                            debugPrint(
                              error.toString(),
                            );
                            context.flushBarErrorMessage(
                              message: error.toString(),
                            );
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: height * .30,
              width: width,
              child: FutureBuilder<NewsChannelHeadlineMdl>(
                future: newsViewModel.fetchNewsChannelHeadlineApi(name),
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
                    // Sort the articles by publication date in descending order
                    List<Articles> sortedArticles = snapshot.data!.articles!
                      ..sort(
                          (a, b) => a.publishedAt!.compareTo(b.publishedAt!));

                    return ListView.builder(
                      itemCount: sortedArticles.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var timeAgo = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString())
                            .timeAgo();
                        Articles headlines = sortedArticles[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetailScreen(
                                    headLines: headlines,
                                  ),
                                ));
                          },
                          child: SizedBox(
                            child: Stack(
                              // alignment: Alignment.center,
                              children: [
                                Container(
                                  height: height * 0.24, // Set a fixed height
                                  width: width * .95,
                                  padding: EdgeInsets.only(
                                      right: width * .001,
                                      left: width * .026,
                                      top: 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      // height: height * 0.9,
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Container(child: spinKit2),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: height * .16,
                                  left: width * .08,
                                  child: Card(
                                    color: Theme.of(context).cardColor,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        top: context.mqh * .01,
                                        bottom: context.mqh * .006,
                                        left: context.mqw * .02,
                                        right: context.mqw * .02,
                                      ),
                                      height: height * .13,
                                      alignment: Alignment.bottomCenter,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: width * 0.7,
                                            child: Text(
                                              snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12.6,
                                                color: AppColors.blackLight,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            width: width * 0.7,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: CustomChip(
                                                    color: AppColors.whiteLight,
                                                    child: Text(
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .source!
                                                          .name
                                                          .toString(),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TimeAgoWidget(
                                                  timeAgo: timeAgo,
                                                  iconColor:
                                                      AppColors.blackLight,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: .33,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 16),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleTextThemeWidget(title: 'Articles'),
                  Spacer(),
                  CustomIconWidget(
                    icon: Icons.more_vert_outlined,
                    size: 15,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.mqh * .01,
            ),

            // const TabbarWithIndicator(),
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

const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);

class TimeAgoWidget extends StatelessWidget {
  const TimeAgoWidget({
    super.key,
    required this.timeAgo,
    this.iconColor,
    this.iconSize,
    this.chipColor,
  });
  final String timeAgo;
  final Color? iconColor;
  final double? iconSize;
  final Color? chipColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          CupertinoIcons.time,
          size: iconSize ?? 18,
          color: iconColor ?? AppColors.redLight,
        ),
        4.w,
        CustomChip(
          color: chipColor ?? AppColors.whiteLight,
          child: Text(
            timeAgo,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
