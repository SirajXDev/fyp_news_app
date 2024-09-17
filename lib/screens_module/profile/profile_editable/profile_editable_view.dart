import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/utils.dart';
import 'parts/header_profile_editable_view.dart';
import 'parts/image_picker_profile_editable_view.dart';

class ProfileEditableView extends StatefulWidget {
  const ProfileEditableView({super.key});

  @override
  State<ProfileEditableView> createState() => _ProfileEditableViewState();
}

class _ProfileEditableViewState extends State<ProfileEditableView> {
//image
  final TextEditingController _userNameTxtEdtController =
      TextEditingController();
  final TextEditingController _emailTxtEdtController = TextEditingController();
  final TextEditingController _phoneNoTxtEdtController =
      TextEditingController();
  final TextEditingController _bioTxtEdtController = TextEditingController();
  //images
  late ImagePicker _picker;
  ValueNotifier<File?> imgFile = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
  }

  @override
  void dispose() {
    super.dispose();
    _userNameTxtEdtController.dispose();
    _emailTxtEdtController.dispose();
    _phoneNoTxtEdtController.dispose();
    _bioTxtEdtController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderProfileEdiatbleView(
                  onTap: () {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    debugPrint('email: ${auth.currentUser?.email}');
                    debugPrint('phoneNo: ${auth.currentUser?.phoneNumber}');

                    debugPrint('Save Profile data');
                    debugPrint('imageData');
                    String? imgPath = imgFile.value?.path;
                    debugPrint('imagePath: $imgPath');
                    debugPrint('user input data');
                    debugPrint('username: ${_userNameTxtEdtController.text}');
                    debugPrint('email: ${_emailTxtEdtController.text}');
                    debugPrint('phoneNo.: ${_phoneNoTxtEdtController.text}');
                    debugPrint('bio: ${_bioTxtEdtController.text}');
                  },
                ),
                SizedBox(height: context.mqh * .04),
                ImagePickerProfileEditableView(
                  picker: _picker,
                  imgFile: imgFile,
                ),
                SizedBox(height: context.mqh * .03),
                const BodyTextThemeWidget(title: 'User Name'),
                SizedBox(height: context.mqh * .006),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: UserNameTextFieldProfile(
                    hint: 'Enter Username here',
                    userNameTxtEdtController: _userNameTxtEdtController,
                  ),
                ),
                SizedBox(height: context.mqh * .012),
                const BodyTextThemeWidget(title: 'Email'),
                SizedBox(height: context.mqh * .006),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: EmailTextFieldProfile(
                    hint: 'Enter Email Address here',
                    emailTxtEdtController: _emailTxtEdtController,
                  ),
                ),
                SizedBox(height: context.mqh * .012),
                const BodyTextThemeWidget(title: ' Phone No.'),
                SizedBox(height: context.mqh * .006),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: PhoneNoTextFieldProfile(
                    hint: 'Enter Phone No. here',
                    phoneNoTxtEdtController: _phoneNoTxtEdtController,
                  ),
                ),
                SizedBox(height: context.mqh * .012),
                const BodyTextThemeWidget(title: 'Bio'),
                SizedBox(height: context.mqh * .006),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BioTextFieldProfile(
                    hint: 'Enter Bio Here',
                    bioTxtEdtController: _bioTxtEdtController,
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: context.mqw * .04, vertical: 15),
          ),
        ),
      ),
    );
  }
}

class UserNameTextFieldProfile extends StatelessWidget {
  const UserNameTextFieldProfile({
    super.key,
    this.onChanged,
    this.hint,
    this.userNameTxtEdtController,
  });
  final String? hint;
  final void Function(String)? onChanged;
  final TextEditingController? userNameTxtEdtController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: userNameTxtEdtController,
      decoration: InputDecoration(
        hintText: hint ?? 'username',
        filled: true,
        hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.surface, fontSize: 12),
        fillColor: Theme.of(context).colorScheme.outline,
        contentPadding: const EdgeInsets.only(left: 10, right: 5),
        border: InputBorder.none,
      ),
      onChanged: onChanged,
      style: const TextStyle(fontSize: 15),
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
    );
  }
}

class EmailTextFieldProfile extends StatelessWidget {
  const EmailTextFieldProfile({
    super.key,
    this.onChanged,
    this.hint,
    this.emailTxtEdtController,
  });
  final String? hint;
  final void Function(String)? onChanged;
  final TextEditingController? emailTxtEdtController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailTxtEdtController,
      decoration: InputDecoration(
        hintText: hint ?? 'email',
        filled: true,
        hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.surface, fontSize: 12),
        fillColor: Theme.of(context).colorScheme.outline,
        contentPadding: const EdgeInsets.only(left: 10, right: 5),
        border: InputBorder.none,
      ),
      onChanged: onChanged,
      style: const TextStyle(fontSize: 15),
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
    );
  }
}

class PhoneNoTextFieldProfile extends StatelessWidget {
  const PhoneNoTextFieldProfile({
    super.key,
    this.onChanged,
    this.hint,
    this.phoneNoTxtEdtController,
  });
  final String? hint;
  final void Function(String)? onChanged;
  final TextEditingController? phoneNoTxtEdtController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneNoTxtEdtController,
      decoration: InputDecoration(
        hintText: hint ?? 'phone no.',
        filled: true,
        hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.surface, fontSize: 12),
        fillColor: Theme.of(context).colorScheme.outline,
        contentPadding: const EdgeInsets.only(left: 10, right: 5),
        border: InputBorder.none,
      ),
      onChanged: onChanged,
      style: const TextStyle(fontSize: 15),
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
    );
  }
}

class BioTextFieldProfile extends StatelessWidget {
  const BioTextFieldProfile({
    super.key,
    this.onChanged,
    this.hint,
    this.bioTxtEdtController,
  });
  final String? hint;
  final void Function(String)? onChanged;
  final TextEditingController? bioTxtEdtController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: bioTxtEdtController,
      decoration: InputDecoration(
        hintText: hint ?? 'bio',
        filled: true,
        hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.surface, fontSize: 12),
        fillColor: Theme.of(context).colorScheme.outline,
        contentPadding:
            const EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
        border: InputBorder.none,
      ),
      maxLines: 3,
      style: const TextStyle(fontSize: 15),
      onChanged: onChanged,
      // onFieldSubmitted: ,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
    );
  }
}
