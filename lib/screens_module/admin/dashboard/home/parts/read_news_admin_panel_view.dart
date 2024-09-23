import 'package:flutter/material.dart';
import 'package:news_application_2/utils/utils.dart';

class ReadNewsAdminPanelView extends StatelessWidget {
  const ReadNewsAdminPanelView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TitleTextThemeWidget(title: "ReadNewsAdminPanelView"),
      ],
    );
  }
}
