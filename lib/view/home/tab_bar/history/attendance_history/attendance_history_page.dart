import 'package:attendance/constant/app_style/app_color.dart';
import 'package:attendance/models/attendance/attendance_model.dart';
import 'package:attendance/models/student/student_model.dart';
import 'package:flutter/material.dart';
import '../../../../../constant/app_style/app_style.dart';
import '../../../../../size_config.dart';
import '../../../../../utils/components/common.dart';
import '../../../../../utils/components/custom_attendance_list.dart';
import '../../../../../utils/components/custom_shiffer_effects.dart';
import '../../../../../view_model/boxes/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AttendanceHistoryPage extends StatelessWidget {
  final AttendanceModel? model;
  const AttendanceHistoryPage({super.key, required this.model});
  final String title='No Student has been added in this Subject';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(formatDate(model!.selectedDate),
                style: TextStyle(
                    color: kPrimaryTextColor,
                    fontSize: getProportionalHeight(35),
                    height: 1.6)),
          ),
          Center(
            child: Text(model!.currentTime.toString(),
                style: TextStyle(
                    color: kPrimaryTextColor,
                    fontSize: getProportionalHeight(35),
                    height: 1.2)),
          ),
          ValueListenableBuilder<Box<StudentModel>>(
            valueListenable: Boxes.getStdData(model!.classId).listenable(),
            builder: (context, box, _) {
              var snap = box.values.toList().cast<StudentModel>();
              if (box.lazy) {
                return const AttendanceShimmerEffect();
              } else if (box.isEmpty) {
                return EmptyStateText(title: title,h: 0.4);
              } else if (box.isNotEmpty) {
                return ListView.builder(
                  itemCount: box.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (model!.attendanceList
                        .containsKey(snap[index].studentId)) {
                      return CustomAttendanceList(
                        stdName: snap[index].studentName,
                        stdRollNo: snap[index].studentRollNo,
                        attendanceStatus:
                        model!.attendanceList[snap[index].studentId],
                        onTap: () {},
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              } else {
                return const CustomError();
              }

            },
          )
        ],
      ),
    ));
  }
}
