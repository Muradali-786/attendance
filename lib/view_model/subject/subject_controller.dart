import 'package:attendance/models/subject/subject_model.dart';
import 'package:attendance/utils/utils.dart';
import 'package:attendance/view_model/boxes/boxes.dart';

class SubjectController {
  final _box = Boxes.getSubData();

  Future<void> addSubject(SubjectModel model) async {
    try {
      await _box.add(model);
      Utils.toastMessage('Subject Registered Successfully');
    } catch (e) {
      Utils.toastMessage('Error. Please try again');
    }
  }

  Future<void> deleteSubject(SubjectModel model) async {
    try {
      await model.delete();

      Utils.toastMessage('Subject ${model.subjectName} deleted Successfully');
    } catch (e) {
      Utils.toastMessage('Error. Please try again');
    }
  }

  Future<void> addSubCount(String subId) async {
    try {
      final List<SubjectModel> subjects =
          _box.values.toList().cast<SubjectModel>();
      var subjectIndex =
          subjects.indexWhere((subject) => subject.subjectId == subId);

      var subject = subjects[subjectIndex];
      subject.totalClasses += 1;
      await subject.save();
    } catch (e) {
      Utils.toastMessage('Error. Please try again');
    }
  }

  Future<void> updateSubData(SubjectModel model, int index)async {
    try {
    await  _box.putAt(index, model);
      Utils.toastMessage('subject updated successfully');
    } catch (e) {
      Utils.toastMessage('Error. Please try again');
    }
  }


  Future<void> subtractSubCount(String subId) async{
    try {
      final List<SubjectModel> subjects =
          _box.values.toList().cast<SubjectModel>();
      var subjectIndex =
          subjects.indexWhere((subject) => subject.subjectId == subId);

      var subject = subjects[subjectIndex];
      if (subject.totalClasses == 1 || subject.totalClasses == 0) {
        subject.totalClasses = 0;
      } else {
        subject.totalClasses -= 1;
      }

     await subject.save();
    } catch (e) {
      Utils.toastMessage('Error. Please try again');
    }
  }

  Future<void> subAttendanceCount(SubjectModel model)async {
    model.totalClasses -= 1;
    await model.save();
  }
}
