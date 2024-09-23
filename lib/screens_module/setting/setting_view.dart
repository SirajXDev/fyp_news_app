import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/configs/components/custom_alert_dialog.dart';
import 'package:news_application_2/main.dart';
import 'package:news_application_2/state_mgt/cubit/theme_cubit.dart';
import 'package:news_application_2/configs/components/heading_text_widget.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/screens_module/setting/parts/custom_list_tile_widget.dart';
import 'package:news_application_2/screens_module/setting/parts/custom_switch_list_tile_widget.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/helper_methods/navigation_utils.dart';
import 'package:news_application_2/utils/helper_methods/shared_preferences_helper.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, isDarkMode) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 20.h,
                SizedBox(
                  height: context.mqh * .03,
                ),
                HeadingTextWidget(
                  headingText: 'Setting',
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(
                  height: context.mqh * .03,
                ),
                // listtiles
                CustomListTileWidget(
                  leadingIcon: CupertinoIcons.person,
                  title: 'Profile',
                  trailIcon: Icons.arrow_forward_ios,
                  onTap: () => Navigator.pushNamed(
                    context,
                    RoutesName.profile,
                  ),
                ),
                15.h,
                CustomSwitchListTileWidget(
                  leadingIcon: CupertinoIcons.bell,
                  title: 'Notification',
                  switchValue: true,
                  onChanged: (bool v) {},
                  isThemeSwitchSelected: false,
                  // trailIcon: null,
                ),
                15.h,

                CustomSwitchListTileWidget(
                  leadingIcon: CupertinoIcons.moon,
                  title: 'Dark Mode',
                  switchValue: AdaptiveTheme.of(context).mode.isDark,
                  onChanged: (bool value) {
                    if (value) {
                      AdaptiveTheme.of(context).setDark();
                    } else {
                      AdaptiveTheme.of(context).setLight();
                    }
                  },
                  isThemeSwitchSelected: true,
                ),
                15.h,
                //end tile
                CustomListTileWidget(
                  leadingIcon: Icons.logout_outlined,
                  title: 'Logout',
                  trailIcon: Icons.arrow_forward_ios,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => customAlertDialog(
                          onAlert: () async {
                            var prefs = getIt<SharedPreferencesHelper>();
                            // make sure delete role before singingOff()
                            await prefs.removeString('role');
                            FirebaseAuth auth = FirebaseAuth.instance;
                            await auth.signOut();
                            if (context.mounted) {
                              NavigationUtils.pushNamedAndRemoveUntil(
                                  context, RoutesName.login);
                            }
                            debugPrint(
                                'logoutUID: ${auth.currentUser?.uid ?? 'UID-03'}');
                            // debugPrint('logoutUID: ${removeString('role') }');
                          },
                          onCancel: () {
                            Navigator.of(context).pop();
                          },
                          backgroundColor:
                              Theme.of(context).colorScheme.outline),
                    );
                  },
                ),
              ],
            ).paddingSymmetric(
              horizontal: 15,
              vertical: 20,
            ),
          ),
        );
      },
    );
  }
}
