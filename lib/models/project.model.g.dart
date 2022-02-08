// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectAdapter extends TypeAdapter<Project> {
  @override
  final int typeId = 1;

  @override
  Project read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Project(
      projectId: fields[0] as String?,
      projectStartdate: fields[4] as String?,
      projectEnddate: fields[5] as String?,
      projectName: fields[1] as String,
      projectCode: fields[2] == null ? 0 : fields[2] as int,
      projectDescription: fields[3] as String,
      status: fields[6] == null ? 1 : fields[6] as int,
      clientId: fields[7] == null ? '' : fields[7] as String,
      leadId: fields[8] == null ? '' : fields[8] as String,
      taskId: fields[9] == null ? [] : (fields[9] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Project obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.projectId)
      ..writeByte(1)
      ..write(obj.projectName)
      ..writeByte(2)
      ..write(obj.projectCode)
      ..writeByte(3)
      ..write(obj.projectDescription)
      ..writeByte(4)
      ..write(obj.projectStartdate)
      ..writeByte(5)
      ..write(obj.projectEnddate)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.clientId)
      ..writeByte(8)
      ..write(obj.leadId)
      ..writeByte(9)
      ..write(obj.taskId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
