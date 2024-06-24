import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Black text styles
TextStyle kBlackRegular = const TextStyle(
  fontSize: 16.0,
  color: Colors.black,
  fontWeight: FontWeight.normal,
);

TextStyle kBlackMedium = const TextStyle(
  fontSize: 16.0,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);

TextStyle kBlackBold = const TextStyle(
  fontSize: 16.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

// White text styles
TextStyle kWhiteRegular = const TextStyle(
  fontSize: 16.0,
  color: Colors.white,
  fontWeight: FontWeight.normal,
);

TextStyle kWhiteMedium = const TextStyle(
  fontSize: 16.0,
  color: Colors.white,
  fontWeight: FontWeight.w500,
);

TextStyle kWhiteBold = const TextStyle(
  fontSize: 16.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);
String formatDate(DateTime dateTime) {
  final formatter = DateFormat('yMMMMd');
  return formatter.format(dateTime);
}


const String SUBJECT = 'Subject';
const String STUDENT = 'Student';
const String ATTENDANCE = 'Attendance';
