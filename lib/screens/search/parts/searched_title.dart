import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/utils/utils.dart';

class SearchedTitle extends StatelessWidget {
  const SearchedTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const TitleTextThemeWidget(
          title: 'Shows Data For ',
          color: AppColors.grey,
        ),
        TitleTextThemeWidget(
          title: title,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ],
    );
  }
}
