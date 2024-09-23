import 'package:flutter/material.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/main.dart';
import 'package:news_application_2/screens_module/admin/dashboard/home/admin-dashboard-parts/create_news/create_news_admin_panel_view.dart';
import 'package:news_application_2/screens_module/admin/dashboard/home/admin-dashboard-parts/update_news/update_news_admin_panel_view.dart';
import 'package:news_application_2/services/remote/firebase/Firebase_Auth_view/login_screen.dart';
import 'package:news_application_2/models/channels_headlines/channels_news_headlines.dart'
    as channels_articles;
import 'package:news_application_2/models/categ_news/categ_news.dart'
    as categ_articles;
import 'package:news_application_2/screens_module/home/news_detail/news_detail_screen.dart';
import 'package:news_application_2/screens_module/search/search_detail_screen.dart';
import 'package:news_application_2/screens_module/profile/profile_editable/profile_editable_view.dart';
import 'package:news_application_2/screens_module/profile/profile_view.dart';
import 'package:news_application_2/screens_module/splash/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesName.roleBasedNavigation:
        return MaterialPageRoute(
          builder: (BuildContext context) => const RoleBasedNavigation(),
        );

      case RoutesName.NEWS_DETAIL_SCREEN:
        return MaterialPageRoute(
          settings: RouteSettings(
            arguments: settings.arguments, // Pass the arguments here
          ),
          builder: (BuildContext context) => NewsDetailScreen(
            headLines: settings.arguments as channels_articles
                .Articles, // Specify the correct Articles class
          ),
        );

      case RoutesName.profile:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ProfileView(),
        );

      case RoutesName.EDIT_PROFILE:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ProfileEditableView(),
        );

      case RoutesName.SEARCH_DETAIL:
        if (settings.arguments != null &&
            settings.arguments is categ_articles.Articles) {
          return MaterialPageRoute(
            settings: RouteSettings(
              arguments: settings.arguments,
            ),
            builder: (BuildContext context) => SearchDetailScreen(
              searchedArticle: settings.arguments as categ_articles
                  .Articles, // Specify the correct Articles class
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorScreen(),
          );
        }

      case RoutesName.createNewsAdminPanel:
        return MaterialPageRoute(
          builder: (BuildContext context) => CreateNewsAdminPanelView(),
        );

      case RoutesName.updateNewsAdminPanel:
        return MaterialPageRoute(
          builder: (BuildContext context) => const UpdateNewsAdminPanelView(),
        );

      default:
        return MaterialPageRoute(builder: (_) {
          return const ErrorScreen();
        });
    }
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('No route defined'),
      ),
    );
  }
}
