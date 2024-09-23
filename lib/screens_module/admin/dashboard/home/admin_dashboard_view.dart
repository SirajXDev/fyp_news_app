import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/configs/components/divider_horizontal_widget.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/screens_module/admin/dashboard/home/admin-dashboard-parts/read_news/read_news_admin_panel_view.dart';
import 'package:news_application_2/screens_module/admin/dashboard/home/admin-dashboard-parts/logout/logout_admin_panel_widget.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class AdminDashBoardView extends StatelessWidget {
  const AdminDashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.outline,
          title: const TitleTextThemeWidget(
            title: 'Admin Dashboard For Personlize News',
            size: 16,
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: LogoutAdminPanelWidget(),
            ),
          ],
          elevation: 1,
          automaticallyImplyLeading: false, // Remove back button
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleTextThemeWidget(
              title: 'Personalise News',
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            const DividerHorizontalWidget(
              weight: .2,
            ),
            SizedBox(
              height: context.mqh * .02,
            ),
            const Expanded(child: ReadNewsAdminPanelView()),
          ],
        ).paddingSymmetric(horizontal: 15, vertical: 15),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RoutesName.createNewsAdminPanel);
          },
          backgroundColor:
              Theme.of(context).floatingActionButtonTheme.backgroundColor,
          child: const CustomIconWidget(
            icon: CupertinoIcons.plus,
            size: 24,
          ),
        ),
      ),
    );
  }
}
