import 'package:attendance/models/subject/subject_model.dart';
import 'package:attendance/view_model/boxes/boxes.dart';

class SubjectController{
  final box = Boxes.getSubData();

  void addSubject(SubjectModel model) {
    box.add(model);
  }

  void deleteSubject(SubjectModel model) {
    model.delete();
  }
}
