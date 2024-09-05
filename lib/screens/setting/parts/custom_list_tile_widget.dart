import 'package:flutter/material.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.trailIcon,
    this.onTap,
  });

  final IconData leadingIcon;
  final String title;
  final IconData trailIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: context.mqh * .055,
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
              color: Theme.of(context).colorScheme.primary,
            )
          ],
        ),
      ),
    );
  }
}
