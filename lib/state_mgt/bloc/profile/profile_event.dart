part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileSetEvent extends ProfileEvent {
  const ProfileSetEvent(
      {required this.id,
      required this.username,
      required this.email,
      required this.phone,
      required this.imageFile,
      required this.bio,
      required this.imageUrl})
      : super();
  final String id;
  final String username;
  final String email;
  final String phone;
  final File imageFile;
  final String bio;
  final String imageUrl;

  @override
  List<Object> get props =>
      [id, username, email, phone, imageFile, bio, imageUrl];
}

class ProfileGetEvent extends ProfileEvent {
  const ProfileGetEvent({
    required this.id,
  }) : super();
  final String id;

  @override
  List<Object> get props => [id];
}
