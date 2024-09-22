import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_application_2/configs/components/loading_widget.dart';
import 'package:news_application_2/data/response/status.dart';
import 'package:news_application_2/main.dart';
import 'package:news_application_2/repository/profile/base_profile_repo.dart';
import 'package:news_application_2/state_mgt/bloc/profile/profile_bloc.dart';
import 'package:news_application_2/utils/enums.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/helper_widgets/validator_rules.dart';
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
    String? userUID = FirebaseAuth.instance.currentUser?.uid;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (context) => ProfileBloc(getIt<BaseProfileRepository>())
                ..add(ProfileGetEvent(id: userUID ?? '01')),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<ProfileBloc, ProfileState>(
                    buildWhen: (previous, current) =>
                        previous.profile != current.profile,
                    builder: (context, state) {
                      var profile = state.profile.data;
                      var status = state.profile.status;
                      // _userNameTxtEdtController.text = profile?.name ?? '';
                      // _emailTxtEdtController.text = profile?.email ?? '';
                      // _phoneNoTxtEdtController.text = profile?.phone ?? '';
                      // _bioTxtEdtController.text = profile?.bio ?? '';

                      switch (status) {
                        case Status.loading:
                          return const Center(
                            child: LoadingWidget(),
                          );
                        case Status.error:
                          return Center(
                            child: Text('Error: ${state.profile.message}'),
                          );

                        case Status.completed:
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              profile == null
                                  ? const HeaderProfileEdiatbleView()
                                  : HeaderProfileEdiatbleView(
                                      onTap: () {
                                        FirebaseAuth auth =
                                            FirebaseAuth.instance;
                                        var user = auth.currentUser;
                                        String phoneNo =
                                            user?.phoneNumber ?? '';
                                        String id = user?.uid ?? '112';
                                        String email = user?.email ?? '';
                                        // String username = user?.displayName ?? '';
                                        // String? imagePath = user?.photoURL;
                                        // File? imageFile = imgFile.value;

                                        // null safty validation

                                        var emaiAddress = email.isEmpty
                                            ? _emailTxtEdtController
                                                    .text.isEmpty
                                                ? profile.email ?? ''
                                                : _emailTxtEdtController.text
                                            : email;
                                        var name = _userNameTxtEdtController
                                                .text.isEmpty
                                            ? profile.name ?? ''
                                            : _userNameTxtEdtController.text;
                                        var bioo =
                                            _bioTxtEdtController.text.isEmpty
                                                ? profile.bio ?? ''
                                                : _bioTxtEdtController.text;
                                        var phone = phoneNo.isEmpty
                                            ? _phoneNoTxtEdtController
                                                    .text.isEmpty
                                                ? profile.phone ?? ''
                                                : _phoneNoTxtEdtController.text
                                            : phoneNo;
                                        var photoFile =
                                            imgFile.value ?? File('');

                                        debugPrint(
                                            'imageState: ${File(profile.image ?? '')}');
                                        if (imgFile.value == null) return;
                                        context.read<ProfileBloc>().add(
                                              ProfileSetEvent(
                                                id: id,
                                                email: emaiAddress,
                                                phone: phone,
                                                imageFile: photoFile,
                                                bio: bioo,
                                                username: name,
                                                imageUrl: profile.image ?? '',
                                              ),
                                            );
                                        Utils.snackBarMessage(
                                            context, 'profile data is stored!');

                                        Future.delayed(
                                            const Duration(seconds: 1), () {
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                            context
                                                .read<ProfileBloc>()
                                                .add(ProfileGetEvent(id: id));
                                            // Display SnackBar on success or error
                                            context
                                                        .read<ProfileBloc>()
                                                        .state
                                                        .profile
                                                        .status ==
                                                    Status.completed
                                                ? ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Profile updated successfully!')))
                                                : ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Error updating profile! ')));
                                          }
                                          // Prints after 1 second.
                                        });
                                        // auth
                                        debugPrint('auth');
                                        debugPrint('email: ${user?.email}');
                                        debugPrint(
                                            'phoneNo: ${user?.phoneNumber}');

                                        // text controllers

                                        debugPrint('Save Profile data');
                                        debugPrint(
                                            'imagePath: ${imgFile.value ?? File(profile.image ?? '')}');
                                        debugPrint('username: $name');
                                        debugPrint('email: $emaiAddress');
                                        debugPrint(
                                            'phoneNo.: ${_phoneNoTxtEdtController.text}');
                                        debugPrint('bio: $bioo');
                                        debugPrint('id: $id');
                                      },
                                    ),
                              SizedBox(height: context.mqh * .04),
                              ImagePickerProfileEditableView(
                                picker: _picker,
                                imgFile: imgFile,
                                profileImg: profile?.image,
                              ),
                              SizedBox(height: context.mqh * .03),
                              const BodyTextThemeWidget(title: 'User Name *'),
                              SizedBox(height: context.mqh * .006),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: UserNameTextFieldProfile(
                                  userNameTxtEdtController:
                                      _userNameTxtEdtController,
                                  hint: profile?.name ?? 'tester',
                                ),
                              ),
                              SizedBox(height: context.mqh * .012),
                              const BodyTextThemeWidget(title: 'Email *'),
                              SizedBox(height: context.mqh * .006),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: EmailTextFieldProfile(
                                  emailTxtEdtController: _emailTxtEdtController,
                                  // initialValue:
                                  hint: profile?.email ?? 'tester@gmail.com',
                                ),
                              ),
                              SizedBox(height: context.mqh * .012),
                              const BodyTextThemeWidget(title: ' Phone No. *'),
                              SizedBox(height: context.mqh * .006),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: PhoneNoTextFieldProfile(
                                  phoneNoTxtEdtController:
                                      _phoneNoTxtEdtController,
                                  hint: profile?.phone ?? '+92636363636363',
                                ),
                              ),
                              SizedBox(height: context.mqh * .012),
                              const BodyTextThemeWidget(title: 'Bio *'),
                              SizedBox(height: context.mqh * .006),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: BioTextFieldProfile(
                                  bioTxtEdtController: _bioTxtEdtController,
                                  hint: profile?.bio ??
                                      'this is tester profile, use for testing purposes..',
                                ),
                              ),
                            ],
                          );
                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: userNameTxtEdtController,
      decoration: Utils.commonDecoration(
          hint: hint ?? 'Enter Username Here', context: context),
      validator: (value) =>
          ValidationRules.validate(ValidationType.username, value),
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: emailTxtEdtController,
      decoration: Utils.commonDecoration(
          hint: hint ?? 'Enter Email Address Here', context: context),
      validator: (value) =>
          ValidationRules.validate(ValidationType.email, value),
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: phoneNoTxtEdtController,
      decoration: Utils.commonDecoration(
          hint: hint ?? 'Enter Phone Number Here', context: context),
      validator: (value) =>
          ValidationRules.validate(ValidationType.phoneNo, value),
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: bioTxtEdtController,
      decoration: Utils.commonDecoration(
          hint: hint ?? 'Enter Bio Here', context: context),
      maxLines: 3,
      style: const TextStyle(fontSize: 15),
      // validator: (value) {

      // },

      onChanged: onChanged,
      // onFieldSubmitted: ,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
    );
  }
}
