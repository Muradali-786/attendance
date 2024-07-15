import 'package:attendance/models/student/student_model.dart';
import 'package:attendance/utils/components/dialogs/add_student_dialog.dart';
import 'package:attendance/utils/components/dialogs/confirmation_dialogs.dart';
import 'package:attendance/utils/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../constant/app_style/app_color.dart';
import '../../../../size_config.dart';
import '../../../../utils/components/common.dart';
import '../../../../utils/components/custom_list_tile.dart';
import '../../../../utils/components/custom_round_button.dart';
import '../../../../utils/components/custom_shiffer_effects.dart';
import '../../../../utils/components/dialogs/update_std_dialog.dart';
import '../../../../view_model/boxes/boxes.dart';

class StudentTab extends StatefulWidget {
  final String subId;
  const StudentTab({super.key, required this.subId});

  @override
  State<StudentTab> createState() => _StudentTabState();
}

class _StudentTabState extends State<StudentTab> {
  final String title = 'No Student has been added in this Subject';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ValueListenableBuilder<Box<StudentModel>>(
        valueListenable: Boxes.getStdData(widget.subId).listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<StudentModel>();
          if (box.lazy) {
            return const SubNStdShimmerEffect();
          } else if (box.isEmpty) {
            return EmptyStateText(title: title);
          } else if (box.isNotEmpty) {
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
                  onPress: () {
                    Navigator.pushNamed(
                      context,
                      RouteName.studentProfilePage,
                      arguments: {
                        'subId': widget.subId,
                        'stdId': data[index].studentId,
                        'index': index
                      },
                    );
                  },
                  onLongPress: () async {
                    await updateStudentDialog(
                        context, widget.subId, index, data[index]);
                  },
                  onDismiss: () async {
                    await showStdDelConfirmationDialog(context, data[index]);
                  },
                );
              },
            );
          } else {
            return const CustomError();
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
          onPress: () async {
            await addStudentDialog(context, widget.subId);
          },
          buttonColor: kSecondaryColor,
        ),
      ),
    );
  }
}
