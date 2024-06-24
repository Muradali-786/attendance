import 'package:attendance/models/attendance/attendance_model.dart';
import 'package:flutter/cupertino.dart';

import '../../models/subject/subject_model.dart';
import '../../utils/utils.dart';
import '../boxes/boxes.dart';

class AttendanceController {
  void markAttendance(AttendanceModel model) {
    final box = Boxes.getAtdData(model.classId);
    try {
      box.add(model);
      Utils.toastMessage('Attendance Save Successfully');
    } catch (e) {
      Utils.toastMessage('Error. Please try again');
    }
  }

  void deleteAttendance(SubjectModel model) {
    try {
      model.delete();
      Utils.toastMessage('Attendance deleted Successfully');
    } catch (e) {
      Utils.toastMessage('Error. Please try again');
    }
  }
}

class AttendanceProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  List<String> _attendanceStatus = [];
  List<String> get attendanceStatus => _attendanceStatus;

  Map<dynamic, dynamic>? _updatedStatusMap;
  Map<dynamic, dynamic>? get updatedStatusMap => _updatedStatusMap;

  void setStatusMap(Map data) {
    _updatedStatusMap = data;
    notifyListeners();
  }

  attendanceStatusProvider(int length) {
    _attendanceStatus = List.generate(length, (index) => "P");
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void updateStatusList(int index) {
    if (_attendanceStatus[index] == 'P') {
      _attendanceStatus[index] = 'A';
    } else if (_attendanceStatus[index] == 'A') {
      _attendanceStatus[index] = 'L';
    } else {
      _attendanceStatus[index] = 'P';
    }
    notifyListeners();
  }

  void updateStatusListBasedOnKey(String index) {
    if (_updatedStatusMap![index] == 'P') {
      _updatedStatusMap![index] = 'A';
    } else if (_updatedStatusMap![index] == 'A') {
      _updatedStatusMap![index] = 'L';
    } else {
      _updatedStatusMap![index] = 'P';
    }
    notifyListeners();
  }
}
