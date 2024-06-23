import 'package:attendance/constant/app_style/app_style.dart';
import 'package:attendance/models/attendance/attendance_model.dart';
import 'package:attendance/models/student/student_model.dart';
import 'package:hive/hive.dart';

import '../models/subject/subject_model.dart';

class Boxes {
  static Box<SubjectModel> getSubData() => Hive.box(SUBJECT);
  static Box<StudentModel> getStdData() => Hive.box(STUDENT);
  static Box<AttendanceModel> getAtdData() => Hive.box(ATTENDANCE);
}
