import 'package:flutter/material.dart';
import 'package:news_application_2/configs/navBar/nav_bar.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/firebase/Firebase_Auth_view/login_screen.dart';
import 'package:news_application_2/screens/splash/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      // case RoutesName.signUp:
      //   return MaterialPageRoute(builder: (BuildContext context) => const LoginScreen());
      case RoutesName.navBar:
        return MaterialPageRoute(
            builder: (BuildContext context) => const NavBar());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
