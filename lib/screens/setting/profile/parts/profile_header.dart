import 'package:flutter/material.dart';
import 'package:news_application_2/configs/components/back_button_widget.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        BackButtonWidget(
          size: 18,
        ),
        Spacer(),
        TitleTextThemeWidget(
          title: 'Edit Profile',
          size: 12,
        ),
      ],
    ).paddingSymmetric(horizontal: context.mqw * .02);
  }
}
