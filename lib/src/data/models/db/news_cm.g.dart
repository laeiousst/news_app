// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsCMAdapter extends TypeAdapter<NewsCM> {
  @override
  final int typeId = 0;

  @override
  NewsCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsCM(
      title: fields[0] as String,
      snippet: fields[1] as String,
      timestamp: fields[2] as String,
      newsUrl: fields[3] as String,
      thumbnail: fields[4] as String,
      thumbnailProxied: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NewsCM obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.snippet)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.newsUrl)
      ..writeByte(4)
      ..write(obj.thumbnail)
      ..writeByte(5)
      ..write(obj.thumbnailProxied);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
