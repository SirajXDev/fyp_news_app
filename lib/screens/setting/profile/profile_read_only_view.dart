import 'package:flutter/material.dart';
import 'package:news_application_2/configs/components/back_button_widget.dart';
import 'package:news_application_2/configs/components/network_image_widget.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class ProfileReadOnlyView extends StatelessWidget {
  const ProfileReadOnlyView({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;
//image -> readOnly
//username -> readOnly
//email -> readOnly
//bio -> readOnly
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const BackButtonWidget(
              isBackArrow: true,
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
        ),
        SizedBox(height: context.mqh * .026),
        Align(
          alignment: Alignment.center,
          child: NetworkImageWidget(
            imageUrl: '',
            iconSize: 40,
            width: context.mqw * .22,
            height: context.mqh * .11,
          ),
        ),
        SizedBox(height: context.mqh * .03),
        // fields view
        const ProfileReadOnlyFieldView(
          labelText: 'UserName',
          title: 'imOpridayy',
        ),
        SizedBox(height: context.mqh * .02),
        const ProfileReadOnlyFieldView(
          labelText: 'Email',
          title: 'imOpridayy@gmail.com',
        ),
        SizedBox(height: context.mqh * .02),
        const ProfileReadOnlyFieldView(
          labelText: 'Phone No.',
          title: '+923139726635',
        ),
        SizedBox(height: context.mqh * .02),
        const ProfileReadOnlyFieldView(
          labelText: 'Bio',
          title:
              'hey this opriday, flutter developer by proffessionss ms dmsms dmdk s,dm, s,dm,smd ',
        ),
      ],
    ).paddingSymmetric(horizontal: context.mqw * .056);
  }
}

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
          color: Theme.of(context).colorScheme.secondary,
        ),
        SizedBox(height: context.mqh * .006),
        Container(
          padding: const EdgeInsets.only(),
          width: double.infinity,
          height: title.length <= 52 ? context.mqh * .05 : context.mqh * .08,
          decoration: BoxDecoration(
            // color: Theme.of(context).colorScheme.outline,
            border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: BodyTextThemeWidget(
              title: title,
              maxLines: maxLinesT,
              size: 16,
            ).paddingOnly(left: 10),
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
