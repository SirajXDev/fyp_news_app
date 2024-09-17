import 'package:flutter/material.dart';
import 'package:news_application_2/configs/components/back_button_widget.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/utils/utils.dart';

class HeaderProfileReadOnlyView extends StatelessWidget {
  const HeaderProfileReadOnlyView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BackButtonWidget(
          isBackArrow: true,
          size: 18,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            // profile editable naviagting view
            Navigator.pushNamed(context, RoutesName.EDIT_PROFILE);
            debugPrint('EDIT PROFFILE');
          },
          child: const TitleTextThemeWidget(
            title: 'Edit Profile',
            size: 12,
          ),
        ),
      ],
    );
  }
}
