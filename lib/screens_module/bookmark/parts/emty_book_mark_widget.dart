import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/configs/components/heading_text_widget.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';

class EmptyBookMarkWidget extends StatelessWidget {
  const EmptyBookMarkWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image(image: AssetImage(''), fit: BoxFit.cover, height: context.mqh * .01,),
        Icon(
          CupertinoIcons.bookmark_fill,
          color: AppColors.redLight,
          size: max(context.mqw * .2, context.mqh * .2),
        ),
        SizedBox(
          height: context.mqh * .02,
        ),
        const HeadingTextWidget(
          headingText: 'BookMark  list is empty. Add one to get started!',
          textAlign: TextAlign.center,
          size: 18,
        ),
      ],
    );
  }
}
