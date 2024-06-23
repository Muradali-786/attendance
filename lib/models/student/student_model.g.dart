// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentModelAdapter extends TypeAdapter<StudentModel> {
  @override
  final int typeId = 1;

  @override
  StudentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentModel(
      studentId: fields[0] as String?,
      studentName: fields[2] as String,
      studentRollNo: fields[3] as String,
      attendancePercentage: fields[4] as int,
      totalPresent: fields[5] as int,
      totalAbsent: fields[6] as int,
      totalLeaves: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, StudentModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.studentId)
      ..writeByte(2)
      ..write(obj.studentName)
      ..writeByte(3)
      ..write(obj.studentRollNo)
      ..writeByte(4)
      ..write(obj.attendancePercentage)
      ..writeByte(5)
      ..write(obj.totalPresent)
      ..writeByte(6)
      ..write(obj.totalAbsent)
      ..writeByte(7)
      ..write(obj.totalLeaves);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
