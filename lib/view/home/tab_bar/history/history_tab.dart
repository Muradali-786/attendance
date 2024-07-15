import 'package:attendance/models/attendance/attendance_model.dart';
import 'package:flutter/material.dart';
import '../../../../constant/app_style/app_color.dart';
import '../../../../constant/app_style/app_style.dart';
import '../../../../size_config.dart';
import '../../../../utils/components/common.dart';
import '../../../../utils/components/custom_attendance_list.dart';
import '../../../../utils/components/custom_round_button.dart';
import '../../../../utils/components/custom_shiffer_effects.dart';
import '../../../../utils/routes/route_name.dart';
import '../../../../view_model/boxes/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryTab extends StatefulWidget {
  final String subId;
  const HistoryTab({super.key, required this.subId});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  final String title = 'No Attendance has been taken of this Subject';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<Box<AttendanceModel>>(
        valueListenable: Boxes.getAtdData(widget.subId).listenable(),
        builder: (context, box, _) {
          var snap = box.values.toList().cast<AttendanceModel>();
          if (box.lazy) {
            return const HistoryShimmerEffect();
          } else if (box.isEmpty) {
            return EmptyStateText(title: title);
          } else if (box.isNotEmpty) {
            return ListView.builder(
              itemCount: box.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CustomAttendanceList2(
                  title:
                      "${formatDate(snap[index].selectedDate)}\t${snap[index].currentTime} ",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteName.attendanceHistoryPage,
                      arguments: snap[index],
                    );
                  },
                );
              },
            );
          } else {
            return const CustomError();
          }
        },
      ),
      bottomSheet:Container(
        height: 36,
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.only(bottom: 16),
        child: CustomRoundButton(
          height: getProportionalHeight(36),
          width: getProportionalWidth(190),
          title: 'EXPORT ATTENDANCE',

          onPress: () {

          },
          buttonColor: kSecondaryColor,
        ),
      )
    );
  }
}
