import 'package:flutter/material.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/screens_module/profile/profile_read_only/profile_read_only_view.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: context.mqh * .04),
            // Editable VIew Innside readOnlyView
            const ProfileReadOnlyView(),
          ],
        ),
      ),
    );
  }
}