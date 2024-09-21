part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({required this.profile});

  final ApiResponse<Profile> profile;

  ProfileState copyWith({ApiResponse<Profile>? profile}) {
    return ProfileState(profile: profile ?? this.profile);
  }

  @override
  List<Object> get props => [];
}

// final class ProfileInitial extends ProfileState {}
