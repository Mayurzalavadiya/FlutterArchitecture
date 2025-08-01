// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cart_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductsAdapter extends TypeAdapter<Products> {
  @override
  final int typeId = 2;

  @override
  Products read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Products(
      id: fields[0] as int?,
      title: fields[1] as String?,
      price: fields[2] as double?,
      quantity: fields[3] as int?,
      isSelected: fields[4] as bool,
      total: fields[5] as double?,
      discountPercentage: fields[6] as double?,
      discountedTotal: fields[7] as double?,
      thumbnail: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Products obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.isSelected)
      ..writeByte(5)
      ..write(obj.total)
      ..writeByte(6)
      ..write(obj.discountPercentage)
      ..writeByte(7)
      ..write(obj.discountedTotal)
      ..writeByte(8)
      ..write(obj.thumbnail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
