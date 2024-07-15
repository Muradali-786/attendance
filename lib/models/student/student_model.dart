import 'package:hive/hive.dart';
part 'student_model.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject {
  @HiveField(0)
  String? studentId;
  @HiveField(2)
  final String studentName;
  @HiveField(3)
  final String studentRollNo;
  @HiveField(4)
  int attendancePercentage;
  @HiveField(5)
  int totalPresent;
  @HiveField(6)
  int totalAbsent;
  @HiveField(7)
  int totalLeaves;

  StudentModel({
    this.studentId,
    required this.studentName,
    required this.studentRollNo,
    this.attendancePercentage = 0,
    this.totalPresent = 0,
    this.totalAbsent = 0,
    this.totalLeaves = 0,
  });
}
