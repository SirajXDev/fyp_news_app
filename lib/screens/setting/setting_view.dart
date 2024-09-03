import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/bloc/cubit/theme_cubit.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/configs/components/heading_text_widget.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // appBar: AppBar(
          //   title: const Text('Setting'),
          //   centerTitle: true,
          // ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.h,
                HeadingTextWidget(
                  headingText: 'Setting',
                  color: Theme.of(context).colorScheme.primary,
                ),
                20.h,
                // listtiles
                const CustomListTileWidget(
                  leadingIcon: CupertinoIcons.person,
                  title: 'Profile',
                  trailIcon: Icons.arrow_forward_ios,
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
                const CustomListTileWidget(
                  leadingIcon: Icons.logout_outlined,
                  title: 'Logout',
                  trailIcon: Icons.arrow_forward_ios,
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

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.trailIcon,
  });

  final IconData leadingIcon;
  final String title;
  final IconData trailIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.greyLightest,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomIconWidget(
                icon: leadingIcon,
                size: 20,
                color: Theme.of(context).iconTheme.color,
              ),
              6.w,
              TitleTextThemeWidget(
                  title: title, size: 17, weight: FontWeight.w500),
            ],
          ),
          CustomIconWidget(
            icon: trailIcon,
            size: 14,
          )
        ],
      ),
    );
  }
}

class CustomSwitchListTileWidget extends StatelessWidget {
  CustomSwitchListTileWidget({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.switchValue = false,
    required this.onChanged,
    required this.isThemeSwitchSelected,
    // required this.trailIcon,
  });

  final IconData leadingIcon;
  final String title;
  bool switchValue;
  void Function(bool)? onChanged;
  bool isThemeSwitchSelected;
  // final IconData trailIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.only(left: 10, right: 0, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.greyLightest,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomIconWidget(
                icon: leadingIcon,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              6.w,
              TitleTextThemeWidget(
                  title: title, size: 17, weight: FontWeight.w500),
            ],
          ),
          Transform.scale(
            scale: 0.75, // Reduce the size by 25%
            child: isThemeSwitchSelected
                ? Switch.adaptive(
                    activeColor: Theme.of(context).colorScheme.onPrimary,
                    value: switchValue,
                    onChanged: onChanged,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )
                : Switch(
                    activeColor: Theme.of(context).colorScheme.onPrimary,
                    value: switchValue,
                    onChanged: onChanged,
                    // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
          )
        ],
      ),
    );
  }
}

class CustomIconWidget extends StatelessWidget {
  const CustomIconWidget({
    super.key,
    required this.icon,
    this.size = 20,
    this.color = AppColors.blackLight,
  });
  final IconData icon;
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}
