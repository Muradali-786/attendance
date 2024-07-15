import 'package:attendance/models/attendance/attendance_model.dart';
import 'package:attendance/models/student/student_model.dart';
import 'package:attendance/view_model/boxes/boxes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uuid/uuid.dart';
import '../../utils/utils.dart';

class StudentController {
  final Uuid _uuid = const Uuid();
  Future<void> addStudent(StudentModel model, String subId) async {
    try {
      final box = Boxes.getStdData(subId);
      await box.add(model);
      Utils.toastMessage("${model.studentRollNo}-${model.studentName} added");
    } catch (e) {
      Utils.toastMessage('Error. Please try again');
    }
  }

  Future<void> addStudentFromOtherSubject(
    String subId,
    String refSubId,
  ) async {
    try {
      EasyLoading.show();
      final box = Boxes.getStdData(refSubId);
      final regNewBox = Boxes.getStdData(subId);
      List<StudentModel> stdList = [];
      List<StudentModel> refSubjectStdList = box.values.toList();

      if (refSubjectStdList.isEmpty) {
        EasyLoading.dismiss();
        Utils.toastMessage('Empty main class. Cannot import students');
        return;
      } else {
        for (var i in refSubjectStdList) {
          StudentModel model = StudentModel(
            studentId: i.studentId,
            studentName: i.studentName,
            studentRollNo: i.studentRollNo,
          );
          stdList.add(model);
        }
        await regNewBox.addAll(stdList);
        EasyLoading.dismiss();
        Utils.toastMessage('Students added successfully');
      }
    } catch (e) {
      EasyLoading.dismiss();
      Utils.toastMessage('Error. Please try again');
    }
  }

  Future<void> addStudentList(
    String subId,
    List stdRollsList,
    List stdNamesList,
  ) async {
    try {
      EasyLoading.show();
      final box = Boxes.getStdData(subId);
      if (stdRollsList.length != stdNamesList.length) {
        EasyLoading.dismiss();
        Utils.toastMessage(
            'The lists of roll numbers and names must have the same length.');
        return;
      } else if (stdRollsList.isEmpty || stdNamesList.isEmpty) {
        EasyLoading.dismiss();
        Utils.toastMessage(
            'Please ensure the Excel sheet is not empty and is in the correct format.');
        return;
      }

      List<StudentModel> studentModelList = [];
      Set<String> uniqueRollNumbers = {};
      Set<String> uniqueNames = {};

      for (int i = 0; i < stdRollsList.length; i++) {
        String studentRollNo = stdRollsList[i];
        String studentName = stdNamesList[i];

        // Check if the student roll number is already in the set
        if (uniqueRollNumbers.contains(studentRollNo)) {
          Utils.toastMessage(
              'Duplicate entry: $studentName with Roll Number: $studentRollNo');
          continue; // Skip adding this entry
        } else if (studentName.isEmpty ||
            studentRollNo.isEmpty ||
            studentName.length < 3) {
          Utils.toastMessage(
              'Invalid entry: $studentName or Roll Number: $studentRollNo');
          continue;
        }

        // Add roll number and name to the set to keep track of unique entries
        uniqueRollNumbers.add(studentRollNo);
        uniqueNames.add(studentName);

        StudentModel model = StudentModel(
          studentId: _uuid.v4().toString(),
          studentName: studentName.trim(),
          studentRollNo: studentRollNo.trim(),
        );

        studentModelList.add(model);
      }

      await box.addAll(studentModelList);
      EasyLoading.dismiss();
      Utils.toastMessage('Students added successfully');
    } catch (e) {
      EasyLoading.dismiss();
      Utils.toastMessage('Error. Please try again');
    }
  }

  Future<void> updateStudentData(
      StudentModel model, int index, String subId) async {
    try {
      final box = Boxes.getStdData(subId);
      await box.putAt(index, model);
      Utils.toastMessage('Student updated successfully');
    } catch (e) {
      Utils.toastMessage('Error. Please try again');
    }
  }

  bool checkStudentAlreadyExist(StudentModel model, String subId) {
    final box = Boxes.getStdData(subId);
    bool studentExists = box.values
        .any((student) => student.studentRollNo == model.studentRollNo);
    return studentExists;
  }

  Future<void> deleteStudent(StudentModel model) async {
    try {
      await model.delete();
      Utils.toastMessage(
          "Student ${model.studentName} (${model.studentRollNo}) deleted");
    } catch (e) {
      Utils.toastMessage('Error. Please try again');
    }
  }

  Future<void> deleteStudentBox(String subId) async {
    try {
      final box = Boxes.getStdData(subId);
      await box.deleteFromDisk();
    } catch (e) {
      Utils.toastMessage('Error. Please try again');
    }
  }

  Future<void> calculateStudentAttendance(String subId) async {
    try {
      dynamic stdBox = Boxes.getStdData(subId);
      dynamic atnBox = Boxes.getAtdData(subId);
      List<AttendanceModel> attendanceList =
          atnBox.values.toList().cast<AttendanceModel>();
      List<StudentModel> stdData = stdBox.values.toList().cast<StudentModel>();

      if (attendanceList.isEmpty) {
        return;
      } else {
        for (int i = 0; i < stdData.length; i++) {
          int totalPresent = 0;
          int totalAbsent = 0;
          int totalLeaves = 0;
          for (var e in attendanceList) {
            if (e.attendanceList.containsKey(stdData[i].studentId)) {
              if (e.attendanceList[stdData[i].studentId] == 'P') {
                totalPresent += 1;
              } else if (e.attendanceList[stdData[i].studentId] == 'L') {
                totalLeaves += 1;
              } else {
                totalAbsent += 1;
              }
            } else {
              continue;
            }
          }
          int total = totalLeaves + totalPresent + totalAbsent;
          int stdAttend = totalLeaves + totalPresent;
          int percentage = 0;
          if (total == 0 || stdAttend == 0) {
            percentage = 0;
          } else {
            percentage = ((stdAttend / total) * 100).toInt();
          }

          StudentModel model = StudentModel(
            studentId: stdData[i].studentId,
            studentName: stdData[i].studentName,
            studentRollNo: stdData[i].studentRollNo,
            totalPresent: totalPresent,
            totalAbsent: totalAbsent,
            totalLeaves: totalLeaves,
            attendancePercentage: percentage,
          );

          await stdBox.putAt(i, model);
        }
      }
    } catch (e) {
      Utils.toastMessage('Error');
    }
  }

  Future<void> addStudentAttendance(
    List<StudentModel> stdData,
    AttendanceModel atnModel,
    String subId,
  ) async {
    try {
      final stdBox = Boxes.getStdData(subId);

      for (int i = 0; i < stdData.length; i++) {
        int totalPresent = stdData[i].totalPresent;
        int totalAbsent = stdData[i].totalAbsent;
        int totalLeaves = stdData[i].totalLeaves;

        if (atnModel.attendanceList.containsKey(stdData[i].studentId)) {
          switch (atnModel.attendanceList[stdData[i].studentId]) {
            case 'P':
              totalPresent += 1;
              break;
            case 'L':
              totalLeaves += 1;
            default:
              totalAbsent += 1;
              break;
          }
        }
        int total = totalLeaves + totalPresent + totalAbsent;
        int stdAttend = totalLeaves + totalPresent;
        int percentage = 0;
        if (total == 0 || stdAttend == 0) {
          percentage = 0;
        } else {
          percentage = ((stdAttend / total) * 100).toInt();
        }

        StudentModel model = StudentModel(
          studentId: stdData[i].studentId,
          studentName: stdData[i].studentName,
          studentRollNo: stdData[i].studentRollNo,
          totalPresent: totalPresent,
          totalAbsent: totalAbsent,
          totalLeaves: totalLeaves,
          attendancePercentage: percentage,
        );
        await stdBox.putAt(i, model);
      }
    } catch (e) {
      Utils.toastMessage('Error. Please try again');
    }
  }

  Future<void> subtractStudentAttendance(
    AttendanceModel atnModel,
    String subId,
  ) async {
    try {
      final stdBox = Boxes.getStdData(subId);
      List<StudentModel> stdData = stdBox.values.toList().cast<StudentModel>();

      for (int i = 0; i < stdData.length; i++) {
        int totalPresent = stdData[i].totalPresent;
        int totalAbsent = stdData[i].totalAbsent;
        int totalLeaves = stdData[i].totalLeaves;

        if (atnModel.attendanceList.containsKey(stdData[i].studentId)) {
          switch (atnModel.attendanceList[stdData[i].studentId]) {
            case 'P':
              totalPresent -= 1;
              break;
            case 'L':
              totalLeaves -= 1;
              break;
            default:
              totalAbsent -= 1;
              break;
          }
        }
        int total = totalLeaves + totalPresent + totalAbsent;
        int stdAttend = totalLeaves + totalPresent;
        int percentage = 0;
        if (total == 0 || stdAttend == 0) {
          percentage = 0;
        } else {
          percentage = ((stdAttend / total) * 100).toInt();
        }

        StudentModel model = StudentModel(
          studentId: stdData[i].studentId,
          studentName: stdData[i].studentName,
          studentRollNo: stdData[i].studentRollNo,
          totalPresent: totalPresent,
          totalAbsent: totalAbsent,
          totalLeaves: totalLeaves,
          attendancePercentage: percentage,
        );
        await stdBox.putAt(i, model);
      }
    } catch (e) {
      Utils.toastMessage('Error. Please try again');
    }
  }
}
