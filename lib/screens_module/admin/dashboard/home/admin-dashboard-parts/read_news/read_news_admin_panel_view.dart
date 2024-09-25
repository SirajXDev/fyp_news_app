import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/data/response/status.dart';
import 'package:news_application_2/screens_module/admin/dashboard/home/admin-dashboard-parts/global-admin-widgets/text_form_fields_via_admin_cu.dart';
import 'package:news_application_2/screens_module/widgets/categ_articles_list_tile_widget.dart';
import 'package:news_application_2/state_mgt/bloc/admin/bloc/manage_news_admin_bloc.dart';
import 'package:news_application_2/utils/extensions/date_time_extension.dart';
import 'package:news_application_2/utils/extensions/flush_bar_extension.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/utils.dart';

import 'parts/read_articles_admin_Panel.dart';

class ReadNewsAdminPanelView extends StatefulWidget {
  const ReadNewsAdminPanelView({super.key});

  @override
  State<ReadNewsAdminPanelView> createState() => _ReadNewsAdminPanelViewState();
}

class _ReadNewsAdminPanelViewState extends State<ReadNewsAdminPanelView> {
  @override
  void initState() {
    // String docId = FirebaseAuth.instance.currentUser?.uid ?? 'docId';
    context
        .read<ManageNewsAdminBloc>()
        .add(FetchNewsAdminDashboard());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageNewsAdminBloc, ManageNewsAdminState>(
      builder: (context, state) {
        var dataList = state.createNewsAdminModel.data;
        if (state.createNewsAdminModel.status == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.createNewsAdminModel.status == Status.error) {
          return BodyTextThemeWidget(
              title: 'ERROR: ${state.createNewsAdminModel.message}');
        } else if (state.createNewsAdminModel.status == Status.completed) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: context.mqh * 0.7,
                child: dataList!.isNotEmpty
                    ? ListView.builder(
                        itemCount: dataList.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          var data = dataList[index];
                          var dt = data.publishedAt?.toDate().timeAgo();
                          return Dismissible(
                            key: ValueKey(
                              data.id,
                            ),
                            direction: DismissDirection.vertical,
                            background: Container(
                              alignment: Alignment.center,
                              child: const CustomIconWidget(
                                icon: Icons.delete,
                                color: AppColors.redLight,
                                size: 30,
                              ),
                            ),
                            dragStartBehavior: DragStartBehavior.down,
                            onDismissed: (direction) {
                              context.read<ManageNewsAdminBloc>().add(
                                    DeleteNewsAdminDashboard(
                                        deleteNewsAdminModel: data),
                                  );

                              context.flushBarSuccessMessage(
                                  message:
                                      "Removed from Bookmarks!:\t${data.publishedAt}",
                                  color: AppColors.red);
                            },
                            child: ReadArticlesWidgetAdminPanel(
                              imageUrl: data.image,
                              title: data.title,
                              desc: data.desc,
                              author: data.author,
                              source: data.source,
                              timeAgo: dt,
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Flexible(
                          child: TitleTextThemeWidget(
                            title:
                                'Create Personalize News By Clicking Add Button Below 👇',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
              ),
            ],
          );
        } else {
          return const BodyTextThemeWidget(
              title: 'SomeTHing is went wrong, try again later!');
        }
      },
    );
  }
}
