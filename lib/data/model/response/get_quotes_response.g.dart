// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_quotes_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuotesAdapter extends TypeAdapter<Quotes> {
  @override
  final int typeId = 3;

  @override
  Quotes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Quotes(
      id: fields[0] as int?,
      quote: fields[1] as String?,
      author: fields[2] as String?,
      isFavourite: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Quotes obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.quote)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.isFavourite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuotesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
