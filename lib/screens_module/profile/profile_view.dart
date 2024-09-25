import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/main.dart';
import 'package:news_application_2/repository/profile/base_profile_repo.dart';
import 'package:news_application_2/screens_module/profile/profile_read_only/profile_read_only_view.dart';
import 'package:news_application_2/state_mgt/bloc/profile/profile_bloc.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // @override

  @override
  void initState() {
    String? userUID = FirebaseAuth.instance.currentUser?.uid;

    context.read<ProfileBloc>().add(ProfileGetEvent(id: userUID ?? '01'));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String? userUID = FirebaseAuth.instance.currentUser?.uid;
    debugPrint('USER_UID: $userUID');
    return BlocProvider(
      create: (context) => ProfileBloc(getIt<BaseProfileRepository>())
        ..add(ProfileGetEvent(id: userUID ?? '01')),
      lazy: false,
      child:
      Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: const SafeArea(
          child:
              ProfileReadOnlyView(), // inside this widget it is editable view also..
        ),
      ),
    );
  }
}
