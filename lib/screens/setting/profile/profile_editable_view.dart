import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/configs/components/back_button_widget.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/configs/components/heading_text_widget.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';

class ProfileEditableView extends StatelessWidget {
  const ProfileEditableView({super.key});
//image
//username
//email -> readOnly
//bio
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const BackButtonWidget(
                  isBackArrow: false,
                  size: 20,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.EDIT_PROFILE);
                    debugPrint('Save Profile');
                  },
                  child: const CustomIconWidget(
                    icon: CupertinoIcons.check_mark,
                    size: 20,
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: context.mqw * .04),
            SizedBox(height: context.mqh * .04),
            const Center(
              child: HeadingTextWidget(
                headingText: 'Profile Editable View',
              ),
            ),
          ],
        ).paddingSymmetric(vertical: 15),
      ),
    );
  }
}
