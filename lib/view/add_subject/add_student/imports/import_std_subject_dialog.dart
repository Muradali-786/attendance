import 'package:attendance/models/subject/subject_model.dart';
import 'package:attendance/view/add_subject/add_student/imports/all_subject_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../constant/app_style/app_color.dart';
import '../../../../utils/components/common.dart';
import '../../../../utils/components/custom_round_button.dart';

import '../../../../view_model/boxes/boxes.dart';

Future<void> importStudentFromSubjectDialog(
    BuildContext context, SubjectModel? e, String subId) async {
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 40,
              decoration: const BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  const Text('Import Students',
                      style: TextStyle(fontSize: 22, color: kTextWhiteColor)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.cancel,
                      color: kWhite,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            Column(
              children: [
                ValueListenableBuilder<Box<SubjectModel>>(
                  valueListenable: Boxes.getSubData().listenable(),
                  builder: (context, box, _) {
                    var data = box.values.toList().cast<SubjectModel>();
                    if (box.isEmpty) {
                      return const ErrorImportStudentClass();
                    } else {
                      SubjectModel model = e ?? data.first;

                      return GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                          await showAllSubDialog(context, subId);
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 33),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${model.subjectName}(${model.departmentName}-${model.batchName})",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  const Icon(Icons.arrow_drop_down_sharp)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(25, 0, 25, 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: CustomRoundButton(
                                      title: 'CLOSE',
                                      height: 32,
                                      onPress: () {
                                        Navigator.pop(context);
                                      },
                                      buttonColor: kSecondaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: CustomRoundButton(
                                      title: 'IMPORT',
                                      height: 32,
                                      onPress: () {},
                                      buttonColor: kSecondaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ],
        ),
      );
    },
  );
}
