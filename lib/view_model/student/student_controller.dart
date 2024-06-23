import 'package:attendance/models/student/student_model.dart';
import 'package:attendance/view_model/boxes/boxes.dart';

class StudentController {
  void addStudent(StudentModel model, String subId) {
    final box = Boxes.getStdData(subId);
    box.add(model);
  }

  bool checkStudentAlreadyExist(StudentModel model, String subId) {
    final box = Boxes.getStdData(subId);
    bool studentExists = box.values
        .any((student) => student.studentRollNo == model.studentRollNo);
    return studentExists;
  }

  void deleteStudent(StudentModel model) {
    model.delete();
  }
}
