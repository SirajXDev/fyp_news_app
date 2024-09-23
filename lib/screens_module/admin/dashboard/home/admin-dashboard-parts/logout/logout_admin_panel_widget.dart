import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/configs/components/custom_alert_dialog.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/main.dart';
import 'package:news_application_2/utils/helper_methods/navigation_utils.dart';
import 'package:news_application_2/utils/helper_methods/shared_preferences_helper.dart';

class LogoutAdminPanelWidget extends StatelessWidget {
  const LogoutAdminPanelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _showLogoutDialog(context);
        },
        child: const CustomIconWidget(icon: Icons.logout_outlined));
  }

  // Extracted showing dialogue popup in method
  Future<void> _showLogoutDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => customAlertDialog(
        backgroundColor: Theme.of(context).colorScheme.outline,
        onAlert: () async => await _handleLogout(context),
        onCancel: () => NavigationUtils.popNavigation,
      ),
    );
  }

// Extracted handling logout logic in method
  Future<void> _handleLogout(BuildContext context) async {
    assert(getIt.isRegistered<SharedPreferencesHelper>());
    final prefs = getIt<SharedPreferencesHelper>();

    // Remove cache before logout
    await prefs.removeString('role');

    final auth = FirebaseAuth.instance;
    await auth.signOut();

    // Navigate to login screen after logout
    if (context.mounted) {
      NavigationUtils.pushNamedAndRemoveUntil(context, RoutesName.login);
    }

    debugPrint('logout: ${auth.currentUser?.uid}');
  }
}
