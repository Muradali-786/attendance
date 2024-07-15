import 'package:attendance/models/attendance/attendance_model.dart';
import 'package:attendance/models/student/student_model.dart';
import 'package:attendance/utils/components/custom_student_profile.dart';
import 'package:attendance/utils/components/dialogs/update_std_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../../constant/app_style/app_style.dart';
import '../../../../../size_config.dart';
import '../../../../../utils/components/common.dart';
import '../../../../../utils/components/custom_attendance_list.dart';
import '../../../../../utils/components/custom_shiffer_effects.dart';
import '../../../../../view_model/boxes/boxes.dart';

class StudentProfilePage extends StatefulWidget {
  final Map data;
  const StudentProfilePage({super.key, required this.data});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  final String title = 'No Attendance has been taken of this Subject';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final String subId = widget.data['subId'];
    final String stdId = widget.data['stdId'];
    final int indexNo = widget.data['index'];
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueListenableBuilder<Box<StudentModel>>(
              valueListenable: Boxes.getStdData(subId).listenable(),
              builder: (context, box, _) {
                final StudentModel stdInfo = box.getAt(indexNo) as StudentModel;

                if (box.isEmpty) {
                  return const SizedBox();
                } else {
                  return SizedBox(
                    height: SizeConfig.screenHeight! * 0.26,
                    child: CustomStudentProfile(
                      stdInfo: stdInfo,
                      onPressEdit: () async{
                       await updateStudentDialog(context, subId, indexNo, stdInfo);
                      },
                    ),
                  );
                }
              },
            ),
            ValueListenableBuilder<Box<AttendanceModel>>(
              valueListenable: Boxes.getAtdData(subId).listenable(),
              builder: (context, box, _) {
                var snap = box.values.toList().cast<AttendanceModel>();

                if (box.lazy) {
                  return const SubNStdShimmerEffect();
                } else if (box.isEmpty) {
                  return EmptyStateText(title: title,h: 0.25);
                } else if (box.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        if (snap[index].attendanceList.containsKey(stdId)) {
                          return CustomAttendanceList3(
                            dateTime:
                                "${formatDate(snap[index].selectedDate)}\t\t${snap[index].currentTime}",
                            attendanceStatus: snap[index].attendanceList[stdId],
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  );
                } else {
                  return const CustomError();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
