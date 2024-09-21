part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileSetEvent extends ProfileEvent {
  const ProfileSetEvent({
    required this.id,
    this.username,
    required this.email,
    required this.phone,
    this.imageFile,
    this.bio,
  }) : super();
  final String id;
  final String? username;
  final String email;
  final String phone;
  final File? imageFile;
  final String? bio;

  @override
  List<Object> get props => [id, username!, email, phone, imageFile!, bio!];
}

class ProfileGetEvent extends ProfileEvent {
  const ProfileGetEvent({
    required this.id,
  }) : super();
  final String id;

  @override
  List<Object> get props => [id];
}
