import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/main.dart';
import 'package:news_application_2/utils/helper_methods/shared_preferences_helper.dart';

class SplashServices {
  void checkLoginStatus(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));

    final sp = getIt<SharedPreferencesHelper>();
    try {
      final storedRole = sp.getString('role');

      if (context.mounted) {
        if (storedRole != null) {
          Navigator.pushReplacementNamed(
            context,
            storedRole == 'admin'
                ? RoutesName.roleBasedNavigation
                : RoutesName.navBar,
          );
        } else {
          Navigator.pushReplacementNamed(context, RoutesName.login);
        }
      } else {
        debugPrint("Context is not mounted");
        // Handle this case, e.g., show error message or retry navigation
      }
    } catch (e) {
      debugPrint("Error retrieving stored role: $e");
      // Handle error, e.g., show error message or redirect to login
    }
  }
}
