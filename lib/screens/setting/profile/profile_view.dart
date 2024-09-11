import 'package:flutter/material.dart';
import 'package:news_application_2/screens/setting/profile/parts/profile_body.dart';
import 'package:news_application_2/screens/setting/profile/parts/profile_header.dart';
import 'package:news_application_2/screens/setting/profile/parts/profile_image.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void dispose() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      //   leading: const BackButtonWidget(),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: context.mqh * .04),
            // header
            const ProfileHeader(),
            SizedBox(height: context.mqh * .04),
            // image
            const ProfileImage(),
            //body
            const ProfileBody(),
          ],
        ),
      ),
    );
  }
}







// class MedQuerySizedBox extends StatelessWidget {
//   const MedQuerySizedBox({super.key, this.width  , this.height });
// final double? width;
// final double? height;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: (context.mqw ) * (width ?? .001) ,
//       height: (context.mqw ) * (height ?? .001),
//     );
//   }
// }