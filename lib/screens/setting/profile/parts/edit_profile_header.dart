import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/configs/components/back_button_widget.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class ProfileReadOnlyHeader extends StatelessWidget {
  const ProfileReadOnlyHeader({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BackButtonWidget(
          isBackArrow: false,
          size: 18,
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: const TitleTextThemeWidget(
            title: 'Edit Profile',
            size: 12,
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: context.mqw * .02);
  }
}
