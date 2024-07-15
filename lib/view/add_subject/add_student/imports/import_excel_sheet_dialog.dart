import 'package:attendance/view_model/media/media_controller.dart';
import 'package:attendance/view_model/student/student_controller.dart';
import 'package:flutter/material.dart';
import '../../../../constant/app_style/app_color.dart';
import '../../../../utils/components/custom_round_button.dart';


Future<void> importExcelSheetDialog(
  BuildContext context,
  String currentSubId,
) async {
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
                  const Text('Import From Excel',
                      style: TextStyle(
                        fontSize: 21,
                        color: kTextWhiteColor,
                      )),
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
            const Padding(
              padding: EdgeInsets.fromLTRB(25, 8, 25, 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '-> Expected format of Excel is Roll#, Student Name',
                    style: TextStyle(color: kTextGreyColor, height: 1.5),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '-> First row is consider as header',
                    style: TextStyle(color: kTextGreyColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: CustomRoundButton(
                        title: 'SELECT FILE',
                        height: 35,
                        onPress: () async {
                          await MediaController()
                              .getStudentDataFromExcel()
                              .then((value) async {
                                Navigator.pop(context);
                            StudentController().addStudentList(
                              currentSubId,
                              value[1],
                              value[0],
                            );
                          });
                        },
                        buttonColor: kSecondaryColor),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
