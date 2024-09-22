import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashServices {
  // void isLogin(BuildContext context) {
  //   //check user is login or not
  //   final auth = FirebaseAuth.instance;
  //   final user = auth.currentUser;
  //   if (user != null) {
  //     Timer(
  //       const Duration(seconds: 3),
  //       () {
  //         Navigator.pushReplacementNamed(context, RoutesName.navBar);
  //       },
  //     );
  //   } else {
  //     Timer(const Duration(seconds: 3), () {
  //       Navigator.pushNamed(context, RoutesName.login);
  //     });
  //   }
  // }

  void checkLoginStatus(BuildContext context) async {
    Timer(const Duration(seconds: 3), () {
      final prefs = SharedPreferences.getInstance().then((prefs) {
        String? storedRole = prefs.getString('role');

        if (storedRole != null) {
          Navigator.pushReplacementNamed(
              context, RoutesName.roleBasedNavigation);
        } else {
          Navigator.pushReplacementNamed(context, RoutesName.login);
        }
      });
    });
  }
}
