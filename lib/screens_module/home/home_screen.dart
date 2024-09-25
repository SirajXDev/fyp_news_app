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
import 'package:news_application_2/screens_module/home/parts/headlines_news_card_widget.dart';
import 'package:news_application_2/screens_module/home/parts/home_news_separator.dart';
import 'package:news_application_2/screens_module/home/parts/pop_up_menu_widget.dart';
import 'package:news_application_2/screens_module/categ/category_screen.dart';
import 'package:news_application_2/screens_module/home/read_personalise_news.dart';
import 'package:news_application_2/state_mgt/bloc/admin/bloc/manage_news_admin_bloc.dart';
import 'package:news_application_2/state_mgt/bloc/news_home/news_home_bloc.dart';
import 'package:news_application_2/utils/extensions/date_time_extension.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/helper_methods/navigation_utils.dart';
import 'package:news_application_2/utils/utils.dart';

import '../admin/dashboard/home/admin-dashboard-parts/read_news/parts/read_articles_admin_Panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late NewsHomeBloc _newsHomeBloc;
  
  @override
  void initState() {
    context.read<ManageNewsAdminBloc>().add(FetchNewsAdminDashboard());
    super.initState();
  }
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
          actions:  [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: GestureDetector(onTap: () => NavigationUtils.pushNamed(context, RoutesName.profile), child: CustomIconWidget(icon: CupertinoIcons.profile_circled, size: 24,)),
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


                SizedBox(height: context.mqh * .01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TitleTextThemeWidget(title: 'Personalize News'),
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

                // A  D M I N _ S E C T I O N
                BlocBuilder<ManageNewsAdminBloc,ManageNewsAdminState>(builder: (context,state){
                  var data = state.createNewsAdminModel.data;

                  if(state.createNewsAdminModel.status == Status.loading){
                    return const CircularProgressIndicator();
                  }
                  else if(state.createNewsAdminModel.status == Status.error){
                    return TitleTextThemeWidget(title: "ERROR: ${state.createNewsAdminModel.message}");
                  }
                  else if(state.createNewsAdminModel.status == Status.completed){

                    return SizedBox(
                      height: context.mqh * .4,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: context.mqh * .012),
                        child: ListView.builder(itemCount: data?.length, itemBuilder: (BuildContext, index){
                          var adminObj = data?[index];
                          return    GestureDetector(
                            onTap: ()=> Navigator.pushNamed(context, RoutesName.PERSONALIZE_NEWS_DETAIL, arguments: adminObj),
                            child: ReadPersonaliseNewsWidget(
                            imageUrl: adminObj?.image,
                              title: adminObj?.title,
                              desc: adminObj?.desc,
                              author: adminObj?.author,
                              source: adminObj?.source,
                              // timeAgo: adminObj?.,
                            ),
                          );
                        },),
                      ),
                    );

                  }
                  else{
                    return SizedBox.shrink();
                  }

                },),
                // personalise news section

                SizedBox(height: context.mqh * .01),
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


