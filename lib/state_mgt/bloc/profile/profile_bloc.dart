import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_application_2/data/response/api_response.dart';
import 'package:news_application_2/models/profile.dart';
import 'package:news_application_2/repository/profile/base_profile_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final BaseProfileRepository _baseProfileRepository;
  ProfileBloc(this._baseProfileRepository)
      : super(
          ProfileState(
            profile: ApiResponse.loading(),
          ),
        ) {
    on<ProfileSetEvent>(_setProfileMethod);
    on<ProfileGetEvent>(_getProfileMethod);
  }

  Future<void> _setProfileMethod(
      ProfileSetEvent event, Emitter<ProfileState> emit) async {
    await _baseProfileRepository.setProfile(
      id: event.id,
      email: event.email,
      phone: event.phone,
      imageFile: event.imageFile,
      bio: event.bio,
      username: event.username,
    );
    // await _baseProfileRepository.getProfile(event.id).then((profile) {
    //   emit(
    //     state.copyWith(
    //       profile: ApiResponse.completed(profile),
    //     ),
    //   );
    // }).onError(
    //   (error, stackTrace) {
    //     emit(
    //       state.copyWith(
    //         profile: ApiResponse.error(
    //           error.toString(),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  Future<void> _getProfileMethod(
      ProfileGetEvent event, Emitter<ProfileState> emit) async {
    await _baseProfileRepository.getProfile(event.id).then((profile) {
      emit(
        state.copyWith(
          profile: ApiResponse.completed(profile),
        ),
      );
    }).onError(
      (error, stackTrace) {
        emit(
          state.copyWith(
            profile: ApiResponse.error(
              error.toString(),
            ),
          ),
        );
      },
    );
  }
}// class end.


