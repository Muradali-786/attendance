import 'package:hive/hive.dart';
part 'attendance_model.g.dart';

@HiveType(typeId: 3)
class AttendanceModel extends HiveObject{
  @HiveField(0)
  final String classId;
  @HiveField(1)
  String? attendanceId;
  @HiveField(2)
  int? indexNo;
  @HiveField(3)
  final DateTime selectedDate;
  @HiveField(4)
  final DateTime createdAtDate;
  @HiveField(5)
  final String currentTime;
  @HiveField(6)
  final Map<dynamic, dynamic> attendanceList;

  AttendanceModel({
    required this.classId,
    this.attendanceId,
    this.indexNo=0,
    required this.createdAtDate,
    required this.selectedDate,
    required this.currentTime,
    required this.attendanceList,
  });
}
