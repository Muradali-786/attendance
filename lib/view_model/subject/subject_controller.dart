import 'package:attendance/models/subject/subject_model.dart';
import 'package:attendance/utils/utils.dart';
import 'package:attendance/view_model/boxes/boxes.dart';

class SubjectController {
  final _box = Boxes.getSubData();

  void addSubject(SubjectModel model) {
    try {
      _box.add(model);
      Utils.toastMessage('Subject Registered Successfully');
    } catch (e) {
      Utils.toastMessage('Error. Please try again');
    }
  }

  void deleteSubject(SubjectModel model) {
    try {
      model.delete();
      Utils.toastMessage('Subject ${model.subjectName} deleted Successfully');
    } catch (e) {
      Utils.toastMessage('Error. Please try again');
    }
  }
}
