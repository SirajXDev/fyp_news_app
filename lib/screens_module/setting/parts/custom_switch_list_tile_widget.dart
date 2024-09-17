import 'package:flutter/material.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/utils.dart';

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
