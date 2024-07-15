import 'package:attendance/models/subject/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../constant/app_style/app_color.dart';
import '../../../models/attendance/attendance_model.dart';
import '../../../models/student/student_model.dart';
import '../../../view_model/attendance/attendance_controller.dart';
import '../../../view_model/student/student_controller.dart';
import '../../../view_model/subject/subject_controller.dart';
import '../../routes/route_name.dart';

Future<void> showSubDelConfirmationDialog(
    BuildContext context, SubjectModel model) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete"),
        content: Text(
            "Are you sure you want to delete class ${model.subjectName}(${model.departmentName}-${model.batchName}).All the attendance history for this class will be lost"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteName.homePage, (route) => false);
            },
            child: const Text(
              "CANCEL",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await SubjectController().deleteSubject(model);
              await StudentController().deleteStudentBox(model.subjectId!);
              await AttendanceController().deleteAttendanceBox(model.subjectId!);
            },
            child:
                const Text("DELETE", style: TextStyle(color: kSecondaryColor)),
          ),
        ],
      );
    },
  );
}

Future<void> showStdDelConfirmationDialog(
    BuildContext context, StudentModel model) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete"),
        content: Text(
            "Are you sure you want to delete student ${model.studentName}(${model.studentRollNo}).All the attendance history for this student will be lost"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "CANCEL",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();

              await StudentController().deleteStudent(model);
            },
            child:
                const Text("DELETE", style: TextStyle(color: kSecondaryColor)),
          ),
        ],
      );
    },
  );
}

Future<void> showAtnDelConfirmationDialog(
    BuildContext context, AttendanceModel model, String subId) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete"),
        content: Text(
            "Are you sure you want to delete the selected attendance(${model.currentTime})."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "CANCEL",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              EasyLoading.show();
             await AttendanceController()
                  .deleteAttendance(model);
              await StudentController().subtractStudentAttendance(
                  model, subId);
              await SubjectController().subtractSubCount(subId);
              EasyLoading.dismiss();

            },
            child:
                const Text("DELETE", style: TextStyle(color: kSecondaryColor)),
          ),
        ],
      );
    },
  );
}


