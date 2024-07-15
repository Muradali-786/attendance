import 'package:attendance/constant/app_style/app_color.dart';
import 'package:attendance/models/subject/subject_model.dart';
import 'package:attendance/utils/components/common.dart';
import 'package:attendance/utils/components/custom_list_tile.dart';
import 'package:attendance/utils/components/custom_shiffer_effects.dart';
import 'package:attendance/utils/components/dialogs/confirmation_dialogs.dart';
import 'package:attendance/utils/components/dialogs/update_subject_dialog.dart';
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
  final String title = 'Click on the + button to add new Subject';
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
        automaticallyImplyLeading: false,
      ),
      body: ValueListenableBuilder<Box<SubjectModel>>(
        valueListenable: Boxes.getSubData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<SubjectModel>();

          if (box.lazy) {
            return const SubNStdShimmerEffect();
          } else if (box.isEmpty) {
            return EmptyStateText(title: title);
          } else if (box.isNotEmpty) {
            return ListView.builder(
              itemCount: box.length,
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
                  onLongPress: () async {
                    await updateSubDialog(context, data[index], index);
                  },
                  onDismiss: () async {
                    await showSubDelConfirmationDialog(context, data[index]);
                  },
                );
              },
            );
          } else {
            return const CustomError();
          }
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
