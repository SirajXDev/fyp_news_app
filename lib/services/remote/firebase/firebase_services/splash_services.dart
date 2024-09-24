import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/main.dart';
import 'package:news_application_2/utils/helper_methods/navigation_utils.dart';
import 'package:news_application_2/utils/helper_methods/shared_preferences_helper.dart';

class SplashServices {
  void checkLoginStatus(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));

    final sp = getIt<SharedPreferencesHelper>();
    try {
      final role = sp.getString('role');

      if (context.mounted) {
        if (role != null) {
          NavigationUtils.pushReplacementNamed(
              context, RoutesName.roleBasedNavigation);
        } else {
          NavigationUtils.pushReplacementNamed(context, RoutesName.login);
        }
      } else {
        debugPrint("Context is not mounted");
      }
    } catch (e) {
      debugPrint("Error retrieving stored role: $e");
    }
  }
}
