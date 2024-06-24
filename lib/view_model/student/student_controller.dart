import 'package:attendance/models/student/student_model.dart';
import 'package:attendance/view_model/boxes/boxes.dart';

import '../../utils/utils.dart';

class StudentController {
  void addStudent(StudentModel model, String subId) {
    try {
      final box = Boxes.getStdData(subId);
      box.add(model);
      Utils.toastMessage("${model.studentRollNo}-${model.studentName} added");
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

  void deleteStudent(StudentModel model) {
    try {
      model.delete();
      Utils.toastMessage(
          "Student ${model.studentName} (${model.studentRollNo}) deleted");
    } catch (e) {
      Utils.toastMessage('Error. Please try again');
    }
  }
}
