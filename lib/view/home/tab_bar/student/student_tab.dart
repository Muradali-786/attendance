import 'package:attendance/models/student/student_model.dart';
import 'package:attendance/utils/components/dialogs/add_student_dialog.dart';
import 'package:attendance/view_model/student/student_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../constant/app_style/app_color.dart';
import '../../../../constant/app_style/app_style.dart';
import '../../../../size_config.dart';
import '../../../../utils/components/custom_list_tile.dart';
import '../../../../utils/components/custom_round_button.dart';
import '../../../../view_model/boxes/boxes.dart';

class StudentTab extends StatefulWidget {
  final String subId;
  const StudentTab({super.key, required this.subId});

  @override
  State<StudentTab> createState() => _StudentTabState();
}

class _StudentTabState extends State<StudentTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ValueListenableBuilder<Box<StudentModel>>(
        valueListenable: Boxes.getStdData(widget.subId).listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<StudentModel>();

          if (box.isNotEmpty) {
            return ListView.builder(
              itemCount: box.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CustomListTile(
                  title: data[index].studentName.toString(),
                  keyValue: data[index].studentId.toString(),
                  subtitle: data[index].studentRollNo.toString(),
                  trailingFirstText:
                      "${data[index].attendancePercentage.toString()}%",
                  trailingSecondText: 'Attendance',
                  onPress: () {},
                  onLongPress: () {},
                  onDismiss: () {},
                );
              },
            );
          } else {
            return Center(child: Text('No students found'));
          }
        },
      ),
      bottomSheet: Container(
        height: 36,
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.only(bottom: 16),
        child: CustomRoundButton(
          height: getProportionalHeight(36),
          width: getProportionalWidth(140),
          title: 'ADD STUDENT',
          onPress: () {
            addStudentDialog(context, widget.subId);
          },
          buttonColor: kSecondaryColor,
        ),
      ),
    );
  }
}
