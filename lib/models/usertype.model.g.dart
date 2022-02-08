// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usertype.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserTypeAdapter extends TypeAdapter<UserType> {
  @override
  final int typeId = 0;

  @override
  UserType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserType(
      typeId: fields[0] == null ? 0 : fields[0] as int,
      name: fields[1] as String,
      priority: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserType obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.typeId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.priority);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
