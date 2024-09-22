// import 'dart:io';

class Profile {
  final String id;
  final String? name;
  final String? email;
  final String? phone;
  final String? bio;
  final String? image;

  Profile({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.bio,
    this.image,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['username'],
      email: json['email'],
      phone: json['phone'],
      bio: json['bio'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': name,
      'email': email,
      'phone': phone,
      'bio': bio,
      'image': image,
    };
  }
}
