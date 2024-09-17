import 'package:hive/hive.dart';

part 'book_mark_adaptor.g.dart';

@HiveType(typeId: 1)
class BookMarkHive {
  @HiveField(0)
  String? urlToImage;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? source;

  @HiveField(4)
  String? author;

  @HiveField(5)
  String? publishedAt;

  @HiveField(6)
  String? id;
}
