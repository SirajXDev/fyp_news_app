import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/main.dart';
import 'package:news_application_2/utils/helper_methods/shared_preferences_helper.dart';

class LogoutAdminPanelWidget extends StatelessWidget {
  const LogoutAdminPanelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          assert(getIt.isRegistered<SharedPreferencesHelper>());
          final prefs = getIt<SharedPreferencesHelper>();
          // remove cache before logout()
          await prefs.removeString('role');
          var auth = FirebaseAuth.instance;
          await auth.signOut();
          if (context.mounted) {
            pushNamedAndRemoveUntil(context, RoutesName.login);
          }
          debugPrint('logout:${auth.currentUser?.uid}');
        },
        child: const CustomIconWidget(icon: Icons.logout_outlined));
  }
}

void pushNamedAndRemoveUntil(BuildContext context, String routeName) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    routeName,
    (Route<dynamic> route) => false,
  );
}
