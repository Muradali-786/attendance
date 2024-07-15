import 'package:attendance/constant/app_style/app_style.dart';
import 'package:attendance/models/attendance/attendance_model.dart';
import 'package:attendance/models/student/student_model.dart';
import 'package:hive/hive.dart';

import '../../models/subject/subject_model.dart';

class Boxes {
  static Box<SubjectModel> getSubData() => Hive.box(SUBJECT);
  static Box<StudentModel> getStdData(String subId) =>
      Hive.box("$STUDENT$subId");
  static Box<AttendanceModel> getAtdData(String subId) =>
      Hive.box("$ATTENDANCE$subId");

  Future<void> openStudentBox(String subId) async {
    await Hive.openBox<StudentModel>(
      "$STUDENT$subId",
    );
  }

  Future<void> openAttendanceBox(String subId) async {
    await Hive.openBox<AttendanceModel>(
      "$ATTENDANCE$subId",
    );
  }

  Future<void> openAllAvialableBoxes() async {
    final box = getSubData().values.toList().cast<SubjectModel>();

    if (box.isNotEmpty) {
      for (var i in box) {
        openStudentBox(i.subjectId!);
        openAttendanceBox(i.subjectId!);
      }
    } else {
      return;
    }
  }
}
