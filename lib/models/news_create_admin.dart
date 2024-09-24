// import 'dart:io';

class CreateNewsAdminModel {
  final String id;
  final String? image;
  final String? title;
  final String? desc;
  final String? author;
  final String? source;
  final String? publishedAt;

  CreateNewsAdminModel({
    required this.id,
    this.image,
    this.title,
    this.desc,
    this.author,
    this.source,
    this.publishedAt,
  });

  factory CreateNewsAdminModel.empty() => CreateNewsAdminModel(
        id: '',
        title: '',
        desc: '',
        author: '',
        source: '',
        image: '',
        publishedAt: '',
      );

  factory CreateNewsAdminModel.fromJson(Map<String, dynamic> json) {
    return CreateNewsAdminModel(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      desc: json['desc'],
      author: json['author'],
      source: json['source'],
      publishedAt: json['publishedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'desc': desc,
      'author': author,
      'source': source,
      'publishedAt': publishedAt,
    };
  }
}
