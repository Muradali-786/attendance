import 'package:attendance/models/attendance/attendance_model.dart';
import 'package:attendance/models/student/student_model.dart';
import 'package:attendance/models/subject/subject_model.dart';
import 'package:attendance/utils/routes/route_name.dart';
import 'package:attendance/view/add_subject/add_student/add_student_page.dart';
import 'package:attendance/view/add_subject/add_subject_page.dart';
import 'package:attendance/view/home/home_page.dart';
import 'package:attendance/view/home/tab_bar/attendance/mark_student_attendance/mark_student_attendance.dart';
import 'package:attendance/view/home/tab_bar/attendance/update_attendance/update_attendance_page.dart';
import 'package:attendance/view/home/tab_bar/custom_tab_bar_page.dart';
import 'package:attendance/view/home/tab_bar/history/attendance_history/attendance_history_page.dart';
import 'package:attendance/view/home/tab_bar/student/student_profile/student_profile_page.dart';
import 'package:flutter/material.dart';

//
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RouteName.addSubjectPage:
        return MaterialPageRoute(builder: (_) => const AddSubjectPage());
      case RouteName.addStudentPage:
        return MaterialPageRoute(
            builder: (_) =>
                AddStudentPage(model: settings.arguments as SubjectModel));
      case RouteName.markStudentAttendancePage:
        return MaterialPageRoute(
            builder: (_) =>
                MarkStudentAttendancePage(data: settings.arguments as Map));
      case RouteName.customTabBarPage:
        return MaterialPageRoute(
            builder: (_) =>
                CustomTabBarPage(model: settings.arguments as SubjectModel));
      case RouteName.attendanceHistoryPage:
        return MaterialPageRoute(
            builder: (_) => AttendanceHistoryPage(
                model: settings.arguments as AttendanceModel));
      case RouteName.updateAttendancePage:
        return MaterialPageRoute(
            builder: (_) => UpdateAttendancePage(
                model: settings.arguments as AttendanceModel));
      case RouteName.studentProfilePage:
        return MaterialPageRoute(builder: (_) => StudentProfilePage(data: settings.arguments as Map));

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
