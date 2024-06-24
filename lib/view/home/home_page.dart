import 'package:attendance/constant/app_style/app_color.dart';
import 'package:attendance/models/subject/subject_model.dart';
import 'package:attendance/utils/components/custom_list_tile.dart';
import 'package:attendance/utils/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../view_model/boxes/boxes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Attendance Manager",
          style: TextStyle(
            fontSize: 20,
            color: kTextWhiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ValueListenableBuilder<Box<SubjectModel>>(
        valueListenable: Boxes.getSubData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<SubjectModel>();

          return ListView.builder(
            itemCount: box.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CustomListTile(
                title: data[index].subjectName.toString(),
                keyValue: data[index].subjectId.toString(),
                subtitle:
                    "${data[index].departmentName} - ${data[index].batchName}",
                trailingFirstText: data[index].totalClasses.toString(),
                trailingSecondText: 'Classes',
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.customTabBarPage,
                    arguments: data[index],
                  );
                },
                onLongPress: () {},
                onDismiss: () {},
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kSecondaryColor,
        onPressed: () {
          Navigator.pushNamed(context, RouteName.addSubjectPage);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
