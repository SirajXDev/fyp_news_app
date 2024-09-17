// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_mark_adaptor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookMarkHiveAdapter extends TypeAdapter<BookMarkHive> {
  @override
  final int typeId = 1;

  @override
  BookMarkHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookMarkHive()
      ..urlToImage = fields[0] as String?
      ..title = fields[1] as String?
      ..description = fields[2] as String?
      ..source = fields[3] as String?
      ..author = fields[4] as String?
      ..publishedAt = fields[5] as String?
      ..id = fields[6] as String?;
  }

  @override
  void write(BinaryWriter writer, BookMarkHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.urlToImage)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.source)
      ..writeByte(4)
      ..write(obj.author)
      ..writeByte(5)
      ..write(obj.publishedAt)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookMarkHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
