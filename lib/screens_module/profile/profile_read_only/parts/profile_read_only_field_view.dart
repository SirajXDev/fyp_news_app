import 'package:flutter/material.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class ProfileReadOnlyFieldView extends StatelessWidget {
  const ProfileReadOnlyFieldView({
    super.key,
    required this.title,
    required this.labelText,
  });
  final String title;
  final String labelText;
  final int maxLinesT = 2;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextThemeWidget(
          title: labelText,
          size: 15,
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(height: context.mqh * .006),
        Container(
          padding: const EdgeInsets.only(),
          width: double.infinity,
          height: title.length <= 52 ? context.mqh * .05 : context.mqh * .08,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.outline,
            // border: Border.all(
            //     color: Theme.of(context).colorScheme.onPrimary, width: .4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: BodyTextThemeWidget(
              title: title,
              maxLines: maxLinesT,
              size: 16,
              color: Theme.of(context).colorScheme.surface,
            ).paddingOnly(
              left: 10,
            ),
          ),
        ),
        // Align(
        //   alignment: Alignment.bottomRight,
        //   child: BodyTextThemeWidget(
        //     title: maxLinesT <= 2 ? '${title.length}' : '',
        //     size: 10,
        //   ),
        // )
      ],
    );
  }
}
