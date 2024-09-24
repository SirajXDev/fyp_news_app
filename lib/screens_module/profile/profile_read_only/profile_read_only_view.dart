import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/configs/components/loading_widget.dart';
import 'package:news_application_2/configs/components/network_image_widget.dart';
import 'package:news_application_2/data/response/response.dart';
import 'package:news_application_2/main.dart';
import 'package:news_application_2/repository/profile/base_profile_repo.dart';
import 'package:news_application_2/screens_module/profile/profile_read_only/parts/header_profile_read_only_view.dart';
import 'package:news_application_2/state_mgt/bloc/profile/profile_bloc.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/screens_module/profile/profile_read_only/parts/profile_read_only_field_view.dart';

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
    return BlocProvider(
      create: (context) => ProfileBloc(getIt<BaseProfileRepository>())
        ..add(ProfileGetEvent(id: FirebaseAuth.instance.currentUser!.uid)),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.mqh * .02, vertical: context.mqh * .04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //ImagePickerProfileEditableView() inside HeaderProfileReadOnlyView()
              const HeaderProfileReadOnlyView(),
              SizedBox(height: context.mqh * .026),
              BlocBuilder<ProfileBloc, ProfileState>(
                buildWhen: (previous, current) =>
                    previous.profile != current.profile,
                builder: (context, state) {
                  var profile = state.profile.data;
                  var status = state.profile.status;
                  switch (status) {
                    case Status.loading:
                      return const Align(
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
                          Align(
                            alignment: Alignment.center,
                            child: NetworkImageWidget(
                              imageUrl: profile?.image ?? '',
                              iconSize: 40,
                              width: context.mqw * 0.24,
                              height: context.mqh * 0.12,
                            ),
                          ),
                          SizedBox(height: context.mqh * 0.03),
                          ProfileReadOnlyFieldView(
                            labelText: 'UserName',
                            title: profile?.name ?? 'test',
                          ),
                          SizedBox(height: context.mqh * 0.02),
                          ProfileReadOnlyFieldView(
                            labelText: 'Email',
                            title: profile?.email ?? 'test@gmail.com',
                          ),
                          SizedBox(height: context.mqh * 0.02),
                          ProfileReadOnlyFieldView(
                            labelText: 'Phone No.',
                            title: profile?.phone ?? '+923139726635',
                          ),
                          SizedBox(height: context.mqh * 0.02),
                          ProfileReadOnlyFieldView(
                            labelText: 'Bio',
                            title: profile?.bio ??
                                'hey! this profile is in the testing mode..',
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
        ),
      ),
    );
    // .paddingSymmetric(
    //   horizontal: context.mqw * 0.056,
    // );
  }
}
