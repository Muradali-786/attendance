import 'package:attendance/utils/components/dialogs/confirmation_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../constant/app_style/app_color.dart';
import '../../../../models/attendance/attendance_model.dart';
import '../../../../size_config.dart';
import '../../../../utils/components/common.dart';
import '../../../../utils/components/custom_attendance_list.dart';
import '../../../../utils/components/custom_round_button.dart';
import '../../../../utils/components/custom_shiffer_effects.dart';
import '../../../../utils/routes/route_name.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../view_model/boxes/boxes.dart';

class AttendanceTab extends StatefulWidget {
  final String subId;
  const AttendanceTab({super.key, required this.subId});

  @override
  State<AttendanceTab> createState() => _AttendanceTabState();
}

class _AttendanceTabState extends State<AttendanceTab> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final String title='No Attendance has been taken of this Subject';
  DateTime _selectedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar<void>(
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 16,
                  color: kTextGreyColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              focusedDay: _selectedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              firstDay: DateTime(2015),
              lastDay: DateTime(2099),
              onDaySelected: _handleDaySelected,
              calendarFormat: _calendarFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: kTextGreyColor,
                  fontSize: 13,
                ),
                weekendStyle: TextStyle(color: kSecondaryTextColor),
              ),
              calendarStyle: CalendarStyle(
                defaultTextStyle: const TextStyle(fontSize: 13),
                weekendTextStyle: const TextStyle(color: kSecondaryTextColor),
                todayDecoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: kSecondaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              rowHeight: getProportionalHeight(42),
              calendarBuilders: CalendarBuilders(
                outsideBuilder: (context, day, dayOfWeek) =>
                    const SizedBox.shrink(),
              ),
            ),
            ValueListenableBuilder<Box<AttendanceModel>>(
              valueListenable: Boxes.getAtdData(widget.subId).listenable(),
              builder: (context, box, _) {
                var snap = box.values.toList().cast<AttendanceModel>();
                if (box.lazy) {
                  return const HistoryShimmerEffect();
                } else if (box.isEmpty) {
                  return EmptyStateText(title: title,h: 0.1);
                } else if (box.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        return CustomAttendanceList2(
                          title: snap[index].currentTime.toString(),
                          onTap: () {
                            snap[index].indexNo = index;
                            Navigator.pushNamed(
                              context,
                              RouteName.updateAttendancePage,
                              arguments: snap[index],
                            );
                          },
                          showDelete: true,
                          onPressDelete: () async {
                            await showAtnDelConfirmationDialog(
                              context,
                              snap[index],
                              widget.subId,
                            );
                          },
                        );
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
      bottomSheet: Container(
        height: 36,
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.only(bottom: 16),
        child: CustomRoundButton(
          height: getProportionalHeight(36),
          width: getProportionalWidth(170),
          title: 'TAKE ATTENDANCE',
          onPress: () => Navigator.pushNamed(
            context,
            RouteName.markStudentAttendancePage,
            arguments: {
              'classId': widget.subId,
              'selectedDate': _selectedDay,
            },
          ),
          buttonColor: kSecondaryColor,
        ),
      ),
    );
  }

  void _handleDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });
  }
}
