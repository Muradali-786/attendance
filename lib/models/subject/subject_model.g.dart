// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectModelAdapter extends TypeAdapter<SubjectModel> {
  @override
  final int typeId = 0;

  @override
  SubjectModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectModel(
      subjectId: fields[0] as String?,
      totalClasses: fields[7] as int,
      subjectName: fields[1] as String?,
      teacherId: fields[2] as String?,
      departmentName: fields[3] as String?,
      batchName: fields[4] as String?,
      creditHour: fields[6] as String,
      percentage: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.subjectId)
      ..writeByte(1)
      ..write(obj.subjectName)
      ..writeByte(2)
      ..write(obj.teacherId)
      ..writeByte(3)
      ..write(obj.departmentName)
      ..writeByte(4)
      ..write(obj.batchName)
      ..writeByte(5)
      ..write(obj.percentage)
      ..writeByte(6)
      ..write(obj.creditHour)
      ..writeByte(7)
      ..write(obj.totalClasses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
