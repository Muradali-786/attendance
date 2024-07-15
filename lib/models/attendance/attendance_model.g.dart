// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceModelAdapter extends TypeAdapter<AttendanceModel> {
  @override
  final int typeId = 3;

  @override
  AttendanceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttendanceModel(
      classId: fields[0] as String,
      attendanceId: fields[1] as String?,
      indexNo: fields[2] as int?,
      createdAtDate: fields[4] as DateTime,
      selectedDate: fields[3] as DateTime,
      currentTime: fields[5] as String,
      attendanceList: (fields[6] as Map).cast<dynamic, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, AttendanceModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.classId)
      ..writeByte(1)
      ..write(obj.attendanceId)
      ..writeByte(2)
      ..write(obj.indexNo)
      ..writeByte(3)
      ..write(obj.selectedDate)
      ..writeByte(4)
      ..write(obj.createdAtDate)
      ..writeByte(5)
      ..write(obj.currentTime)
      ..writeByte(6)
      ..write(obj.attendanceList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
