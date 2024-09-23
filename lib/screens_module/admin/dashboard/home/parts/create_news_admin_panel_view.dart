import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/configs/components/divider_horizontal_widget.dart';
import 'package:news_application_2/configs/routes/navBar/nav_bar.dart';
import 'package:news_application_2/utils/enums.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/helper_widgets/validator_rules.dart';
import 'package:news_application_2/utils/utils.dart';
import 'package:news_application_2/widgets/round_button.dart';

class CreateNewsAdminPanelView extends StatelessWidget {
  const CreateNewsAdminPanelView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.outline,
          title: const TitleTextThemeWidget(
            title: 'Create Personalize News Admin Panel',
            size: 16,
          ),
          elevation: 1,
          automaticallyImplyLeading: true, // Remove back button
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleTextThemeWidget(
                  title: "Create Personalize News For Users..",
                  size: 14.5,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                //divider
                const DividerHorizontalWidget(),
                //height
                SizedBox(height: context.mqh * .02),
                //image picker here...
                const TitleTextThemeWidget(title: 'Pick Image', size: 14),
                SizedBox(height: context.mqh * .01),
                Center(
                  child: Container(
                    width: context.mqw * .6,
                    height: context.mqh * .2,
                    decoration: BoxDecoration(
                        // color: Theme.of(context).colorScheme.onPrimary,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.onPrimary,
                            width: .4),
                        borderRadius: BorderRadius.circular(12)),
                    child: const CustomIconWidget(
                      icon: Icons.add_photo_alternate_outlined,
                      size: 25,
                    ),
                  ),
                ),
                //height
                SizedBox(height: context.mqh * .03),
                //fields
                TextFormFieldsViaCreateAdmin(),
                //height
                SizedBox(height: context.mqh * .04),
                //submit btn here
                RoundButton(
                  title: 'Submit',
                  onTap: () {},
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFormFieldsViaCreateAdmin extends StatelessWidget {
  TextFormFieldsViaCreateAdmin({super.key});
  final GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title -> The headline or title of the article.
            const TitleTextThemeWidget(title: 'Title', size: 14),
            SizedBox(height: context.mqh * .004),
            TextFormField(
              validator: (value) {
                return null;
              },
              decoration: Utils.commonDecoration(
                  hint: 'Enter Title Here?', context: context),
              // style: const TextStyle(fontSize: 15),

              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: context.mqh * .02),
            //description -> A description or snippet from the article.
            const TitleTextThemeWidget(title: 'description', size: 14),
            SizedBox(height: context.mqh * .004),
            TextFormField(
              decoration: Utils.commonDecoration(
                  hint: 'Enter Description Here?', context: context),
            ),
            SizedBox(height: context.mqh * .02),
            //author -> The author of the article
            const TitleTextThemeWidget(title: 'Author', size: 14),
            SizedBox(height: context.mqh * .004),
            TextFormField(
              decoration: Utils.commonDecoration(
                  hint: 'Enter Author Name Here?', context: context),
            ),
            SizedBox(height: context.mqh * .02),
            // source ->  a display name for the source this article came from
            const TitleTextThemeWidget(title: 'Source Name', size: 14),
            SizedBox(height: context.mqh * .004),

            TextFormField(
              decoration: Utils.commonDecoration(
                  hint: 'Enter Source Name Here?', context: context),
            ),
            SizedBox(height: context.mqh * .02),
            // publishedAt -> The date and time that the article was published, in UTC (+000)
            const TitleTextThemeWidget(title: 'publishedAt', size: 14),
            SizedBox(height: context.mqh * .004),

            TextFormField(
              decoration: Utils.commonDecoration(
                  hint: 'Enter Publish Date Here? ', context: context),
            ),

            // image -> The relevant image for the article.
          ],
        ));
  }
}
