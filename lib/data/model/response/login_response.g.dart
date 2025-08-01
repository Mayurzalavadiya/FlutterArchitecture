// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginResponseAdapter extends TypeAdapter<LoginResponse> {
  @override
  final int typeId = 1;

  @override
  LoginResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginResponse(
      id: fields[0] as int?,
      firstName: fields[1] as String?,
      lastName: fields[2] as String?,
      maidenName: fields[3] as String?,
      age: fields[4] as int?,
      gender: fields[5] as String?,
      email: fields[6] as String?,
      phone: fields[7] as String?,
      username: fields[8] as String?,
      password: fields[9] as String?,
      birthDate: fields[10] as String?,
      image: fields[11] as String?,
      bloodGroup: fields[12] as String?,
      height: fields[13] as double?,
      weight: fields[14] as double?,
      eyeColor: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginResponse obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.maidenName)
      ..writeByte(4)
      ..write(obj.age)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.username)
      ..writeByte(9)
      ..write(obj.password)
      ..writeByte(10)
      ..write(obj.birthDate)
      ..writeByte(11)
      ..write(obj.image)
      ..writeByte(12)
      ..write(obj.bloodGroup)
      ..writeByte(13)
      ..write(obj.height)
      ..writeByte(14)
      ..write(obj.weight)
      ..writeByte(15)
      ..write(obj.eyeColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
