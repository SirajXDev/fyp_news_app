import 'package:flutter/material.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/utils/utils.dart';

class NewsWebLauncherWidget extends StatelessWidget {
  const NewsWebLauncherWidget({
    super.key,
    this.url,
    required this.onTap,
  });

  final String? url;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1.2),
              decoration: BoxDecoration(
                color: AppColors.orangeLight,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const BodyTextThemeWidget(
                title: "LEARN MORE ...",
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
