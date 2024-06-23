import 'package:attendance/constant/app_style/app_style.dart';
import 'package:attendance/models/attendance/attendance_model.dart';
import 'package:attendance/models/student/student_model.dart';
import 'package:attendance/models/subject/subject_model.dart';
import 'package:attendance/utils/routes/route_name.dart';
import 'package:attendance/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'constant/app_style/app_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(SubjectModelAdapter());
  Hive.registerAdapter(StudentModelAdapter());
  Hive.registerAdapter(AttendanceModelAdapter());

  await Hive.openBox<SubjectModel>(SUBJECT);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: kPrimaryColor,
  ));

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: kBgColor,
        appBarTheme: const AppBarTheme(
          color: kPrimaryColor,
        ),
      ),
      builder: EasyLoading.init(),
      initialRoute: RouteName.homePage,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
