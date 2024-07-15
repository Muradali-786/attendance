import 'package:attendance/models/attendance/attendance_model.dart';
import 'package:attendance/models/student/student_model.dart';
import 'package:attendance/size_config.dart';
import 'package:attendance/utils/utils.dart';
import 'package:attendance/view_model/attendance/attendance_controller.dart';
import 'package:attendance/view_model/student/student_controller.dart';
import 'package:attendance/view_model/subject/subject_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../../../../../constant/app_style/app_color.dart';
import '../../../../../utils/components/common.dart';
import '../../../../../utils/components/custom_attendance_list.dart';
import '../../../../../utils/components/custom_round_button.dart';
import '../../../../../utils/components/custom_shiffer_effects.dart';
import '../../../../../utils/components/time_picker.dart';
import '../../../../../view_model/boxes/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MarkStudentAttendancePage extends StatefulWidget {
  final dynamic data;
  const MarkStudentAttendancePage({super.key, required this.data});

  @override
  State<MarkStudentAttendancePage> createState() =>
      _MarkStudentAttendancePageState();
}

class _MarkStudentAttendancePageState extends State<MarkStudentAttendancePage> {
  final AttendanceController _controller = AttendanceController();
  List<String> stdIdList = [];
  List<StudentModel> stdDataList = [];

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay pickedTime = await showTimePickerDialog(context);

    if (pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  final String title = 'No Student has been added in this Subject';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String period = selectedTime.hour < 12 ? 'AM' : 'PM';
    String hour = selectedTime.hourOfPeriod.toString().padLeft(2, '0');
    String minute = selectedTime.minute.toString().padLeft(2, '0');
    String currentTime = '$hour:$minute $period';
    String subId = widget.data['classId'].toString();
    DateTime selectedDate = widget.data['selectedDate'];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: TextButton(
                onPressed: () {
                  _selectTime(context);
                },
                child: Center(
                  child: Text(
                    currentTime.toString(),
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight! * 0.057,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
            ValueListenableBuilder<Box<StudentModel>>(
              valueListenable: Boxes.getStdData(subId).listenable(),
              builder: (context, box, _) {
                var snap =
                    stdDataList = box.values.toList().cast<StudentModel>();
                if (box.lazy) {
                  return const AttendanceShimmerEffect();
                } else if (box.isEmpty) {
                  return EmptyStateText(title: title,h: 0.4);
                } else if (box.isNotEmpty) {
                  return Consumer<AttendanceProvider>(
                    builder: (context, provider, child) {
                      if (provider.attendanceStatus.length != snap.length) {
                        provider.attendanceStatusProvider(snap.length);
                      }
                      if (stdIdList.length != snap.length) {
                        for (var std in snap) {
                          stdIdList.add(std.studentId!);
                        }
                      }
                      return Expanded(
                        child: ListView.builder(
                          itemCount: box.length,
                          itemBuilder: (context, index) {
                            if (stdIdList.length != snap.length) {
                              stdIdList.add(snap[index].studentId!);
                            }
                            return CustomAttendanceList(
                              stdName: snap[index].studentName,
                              stdRollNo: snap[index].studentRollNo,
                              attendanceStatus:
                                  provider.attendanceStatus[index],
                              onTap: () {
                                provider.updateStatusList(index);
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const CustomError();
                }
              },
            )
          ],
        ),
      ),
      bottomSheet: Container(
        height: 36,
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.only(bottom: 16),
        child: CustomRoundButton(
          height: getProportionalHeight(36),
          width: getProportionalWidth(175),
          title: 'SAVE ATTENDANCE',
          onPress: () async {
            AttendanceProvider p =
                Provider.of<AttendanceProvider>(context, listen: false);

            if (stdIdList.isNotEmpty) {
              final model = AttendanceModel(
                classId: subId,
                createdAtDate: DateTime.now(),
                selectedDate: selectedDate,
                currentTime: currentTime.toString(),
                attendanceList: Map.fromIterables(
                  stdIdList,
                  p.attendanceStatus,
                ),
              );
              Navigator.pop(context);
              EasyLoading.show();
              await _controller.markAttendance(model);
              await SubjectController().addSubCount(subId);
              await StudentController()
                  .addStudentAttendance(stdDataList, model, subId);
              EasyLoading.dismiss();
            } else {
              Utils.toastMessage('Please add student first');
            }
          },
          buttonColor: kSecondaryColor,
        ),
      ),
    );
  }
}
