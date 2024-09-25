import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_application_2/configs/components/divider_horizontal_widget.dart';
import 'package:news_application_2/screens_module/admin/dashboard/home/admin-dashboard-parts/global-admin-widgets/text_form_fields_via_admin_cu.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/utils.dart';

import '../global-admin-widgets/pick_image_via_admin_cu.dart';

class CreateNewsAdminPanelView extends StatelessWidget {
  CreateNewsAdminPanelView({super.key});
  //images
  ValueNotifier<File?> imgFile = ValueNotifier(null);
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
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
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
                SizedBox(height: context.mqh * .044),
                //image picker here...
                const TitleTextThemeWidget(title: 'Pick Image', size: 14),
                SizedBox(height: context.mqh * .01),
                Center(
                  child: PickImageViaAdminViewCU(
                    imgFile: imgFile,
                  ),
                ),
                //height
                SizedBox(height: context.mqh * .03),
                //fields // in this widget clc will performs
                TextFormFieldsViaAdminCU(imgFile: imgFile),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
