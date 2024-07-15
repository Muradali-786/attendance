import 'package:attendance/models/attendance/attendance_model.dart';
import 'package:hive/hive.dart';

import '../student/student_model.dart';
part 'subject_model.g.dart';

@HiveType(typeId: 0)
class SubjectModel extends HiveObject {
  @HiveField(0)
  String? subjectId;
  @HiveField(1)
  final String? subjectName;
  @HiveField(2)
  final String? teacherId;
  @HiveField(3)
  final String? departmentName;
  @HiveField(4)
  final String? batchName;
  @HiveField(5)
  final int? percentage;
  @HiveField(6)
  final String creditHour;
  @HiveField(7)
  int totalClasses;

  SubjectModel({
    this.subjectId,
    this.totalClasses = 0,
    required this.subjectName,
    required this.teacherId,
    required this.departmentName,
    required this.batchName,
    required this.creditHour,
    required this.percentage,
  });
}
