import 'package:flutter/material.dart';

import '../../constant/app_style/app_color.dart';

Future<TimeOfDay> showTimePickerDialog(BuildContext context) async {
  final selectedTime = TimeOfDay.now();

  final timePickerTheme = TimePickerThemeData(
    backgroundColor: kBgColor,
    dayPeriodColor: MaterialStateColor.resolveWith(
      (states) => states.contains(MaterialState.selected)
          ? kSecondary54Color
          : kSecondaryColor,
    ),
    dayPeriodTextColor: kTextWhiteColor,
    hourMinuteColor: MaterialStateColor.resolveWith(
      (states) => states.contains(MaterialState.selected)
          ? kSecondary54Color
          : kSecondaryColor,
    ),
    hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? kTextWhiteColor
            : kPrimaryColor),
    dialHandColor: kSecondaryColor,
    dialBackgroundColor: kGrey.withOpacity(0.4),
    hourMinuteTextStyle: const TextStyle(
        fontSize: 32, color: kTextBlackColor, fontWeight: FontWeight.bold),
    dayPeriodTextStyle: const TextStyle(
        fontSize: 16, color: kTextBlackColor, fontWeight: FontWeight.bold),
    helpTextStyle: const TextStyle(
        fontSize: 22, color: kSecondaryColor, fontWeight: FontWeight.bold),
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
      contentPadding: EdgeInsets.all(0),
    ),
    dialTextColor: MaterialStateColor.resolveWith(
        (states) => states.contains(MaterialState.selected) ? kWhite : kBlack),
    entryModeIconColor: kPrimaryColor,
  );
  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: selectedTime,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          // This uses the _timePickerTheme defined above
          timePickerTheme: timePickerTheme,
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateColor.resolveWith((states) => kSecondaryColor),
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  return pickedTime ?? selectedTime;
}
