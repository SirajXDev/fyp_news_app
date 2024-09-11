import 'package:flutter/material.dart';
import 'package:news_application_2/configs/components/heading_text_widget.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';

class BookMarkView extends StatelessWidget {
  const BookMarkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: context.mqh * .03,
              ),
              // page titlle
              HeadingTextWidget(
                headingText: 'BookMark',
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ).paddingSymmetric(
            horizontal: 15,
          ),
        ),
      ),
    );
  }
}
