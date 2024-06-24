import 'package:attendance/constant/app_style/app_color.dart';
import 'package:attendance/models/attendance/attendance_model.dart';
import 'package:attendance/models/student/student_model.dart';
import 'package:attendance/utils/utils.dart';
import 'package:attendance/view_model/attendance/attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import '../../../../../constant/app_style/app_style.dart';
import '../../../../../size_config.dart';
import '../../../../../utils/components/custom_attendance_list.dart';
import '../../../../../utils/components/custom_round_button.dart';
import '../../../../../view_model/boxes/boxes.dart';

class UpdateAttendancePage extends StatefulWidget {
  final AttendanceModel? model;
  const UpdateAttendancePage({super.key, required this.model});

  @override
  State<UpdateAttendancePage> createState() => _UpdateAttendancePageState();
}

class _UpdateAttendancePageState extends State<UpdateAttendancePage> {
  List<dynamic> studentIdList = [];
  bool isChange = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: TextButton(
              onPressed: () {
                // _selectTime(context);
              },
              child: Text('12:30 PM',
                  style: TextStyle(
                      fontSize: getProportionalHeight(42),
                      color: kPrimaryTextColor,
                      fontWeight: FontWeight.w500,
                      height: 1.5)),
            ),
          ),
          ValueListenableBuilder<Box<StudentModel>>(
            valueListenable:
                Boxes.getStdData(widget.model!.classId).listenable(),
            builder: (context, box, _) {
              var snap = box.values.toList().cast<StudentModel>();

              if (box.isNotEmpty) {
                return Consumer<AttendanceProvider>(
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: box.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (widget.model!.attendanceList
                            .containsKey(snap[index].studentId)) {
                          return CustomAttendanceList(
                            stdName: snap[index].studentName,
                            stdRollNo: snap[index].studentRollNo,
                            attendanceStatus: widget
                                .model!.attendanceList[snap[index].studentId],
                            onTap: () {
                              if (!isChange) {
                                value
                                    .setStatusMap(widget.model!.attendanceList);
                                isChange = true;
                              }

                              value.updateStatusListBasedOnKey(
                                snap[index].studentId!,
                              );
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  },
                );
              } else {
                return const Center(child: Text('No students found'));
              }
            },
          ),
        ],
      )),
      bottomSheet: Container(
        height: 36,
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.only(bottom: 16),
        child: CustomRoundButton(
          height: getProportionalHeight(36),
          width: getProportionalWidth(185),
          title: 'UPDATE ATTENDANCE',
          onPress: () {
            AttendanceProvider p =
                Provider.of<AttendanceProvider>(context, listen: false);
            if (isChange) {
              final model = AttendanceModel(
                  classId: widget.model!.classId,
                  createdAtDate: widget.model!.createdAtDate,
                  selectedDate: widget.model!.selectedDate,
                  currentTime: widget.model!.currentTime,
                  attendanceList: p.updatedStatusMap!);
              Navigator.pop(context);
              AttendanceController().updateAttendance(model);
            } else {
              Utils.toastMessage('update Attendance Status First');
            }
          },
          buttonColor: kSecondaryColor,
        ),
      ),
    );
  }
}
