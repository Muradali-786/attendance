import 'package:attendance/view/add_subject/add_student/imports/import_std_subject_dialog.dart';

import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import '../../../../models/subject/subject_model.dart';
import '../../../../view_model/boxes/boxes.dart';

Future<void> showAllSubDialog(BuildContext context, String currentSubId) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                ValueListenableBuilder<Box<SubjectModel>>(
                  valueListenable: Boxes.getSubData().listenable(),
                  builder: (context, box, _) {
                    var data = box.values.toList().cast<SubjectModel>();
                    if (box.isEmpty) {
                      return const Text('data');
                    } else {
                      return ListView.builder(
                        itemCount: data.length,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              Navigator.pop(context);
                              importStudentFromSubjectDialog(
                                  context, data[index], currentSubId);
                              print('lets check the data');
                              print(data[index].subjectName);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${data[index].subjectName}(${data[index].departmentName}-${data[index].batchName})",
                                      style: const TextStyle(fontSize: 20),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                )
              ],
            )
          ],
        ),
      );
    },
  );
}
