import 'package:attendance/models/subject/subject_model.dart';
import 'package:attendance/utils/routes/route_name.dart';
import 'package:attendance/view/add_subject/add_student/add_student_page.dart';
import 'package:attendance/view/add_subject/add_subject_page.dart';
import 'package:attendance/view/home/home_page.dart';
import 'package:attendance/view/home/tab_bar/custom_tab_bar_page.dart';
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
          builder: (_) => AddStudentPage(
            model: settings.arguments as SubjectModel,
          ),
        );
      case RouteName.customTabBarPage:
        return MaterialPageRoute(
          builder: (_) => CustomTabBarPage(
            model: settings.arguments as SubjectModel,
          ),
        );

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
