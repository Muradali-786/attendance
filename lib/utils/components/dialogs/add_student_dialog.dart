import 'package:attendance/view_model/student/student_controller.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../constant/app_style/app_color.dart';
import '../../../models/student/student_model.dart';
import '../../utils.dart';
import '../custom_round_button.dart';
import 'dialog_text_field.dart';

Future<void> addStudentDialog(BuildContext context, String subId) async {
  final _formKey = GlobalKey<FormState>();
  Uuid idGen = const Uuid();
  TextEditingController stdNameController = TextEditingController();
  FocusNode stdNameFocus = FocusNode();
  TextEditingController rollNController = TextEditingController();
  FocusNode rollNoFocus = FocusNode();
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
                  const Text('Add Student',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    DialogInputTextField(
                      labelText: 'Student Name',
                      myController: stdNameController,
                      focusNode: stdNameFocus,
                      onFieldSubmittedValue: (val) {
                        Utils.onFocusChange(context, stdNameFocus, rollNoFocus);
                      },
                      hint: 'Student Name',
                      onValidator: (val) {
                        if (val.trim().isEmpty) {
                          return 'Please enter Student Name';
                        } else if (val.trim().length < 3) {
                          return 'Student Name  at least 3 characters long';
                        } else if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(val)) {
                          return 'Student Name cannot contain special characters';
                        }
                        return null;
                      },
                      keyBoardType: TextInputType.text,
                    ),
                    DialogInputTextField(
                      labelText: 'Roll Number / Registration#',
                      myController: rollNController,
                      focusNode: rollNoFocus,
                      onFieldSubmittedValue: (val) {},
                      hint: 'Roll Number / Registration#',
                      onValidator: (val) {
                        if (val.trim().isEmpty) {
                          return 'Please enter student Roll No';
                        } else if (val.trim().length < 2) {
                          return 'Roll No  at least 2 characters long';
                        } else if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(val)) {
                          return 'Roll No cannot contain special characters';
                        }
                        return null;
                      },
                      keyBoardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: CustomRoundButton(
                        title: 'SAVE & CLOSE',
                        height: 32,
                        onPress: () async {
                          if (_formKey.currentState!.validate()) {
                            StudentModel studentModel = StudentModel(
                              studentId: idGen.v4().toString(),
                              studentName: stdNameController.text.trim(),
                              studentRollNo: rollNController.text.trim(),
                            );
                            bool isExist = StudentController()
                                .checkStudentAlreadyExist(studentModel, subId);
                            if (isExist) {
                              Utils.toastMessage(
                                  'Student with same registration exist');
                            } else {
                              Navigator.pop(context);
                              await StudentController()
                                  .addStudent(studentModel, subId);
                            }
                          }
                        },
                        buttonColor: kSecondaryColor),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: CustomRoundButton(
                        title: 'ADD ANOTHER',
                        height: 32,
                        onPress: () async {
                          if (_formKey.currentState!.validate()) {
                            StudentModel studentModel = StudentModel(
                              studentId: idGen.v4().toString(),
                              studentName: stdNameController.text.trim(),
                              studentRollNo: rollNController.text.trim(),
                            );
                            bool isExist = StudentController()
                                .checkStudentAlreadyExist(studentModel, subId);
                            if (isExist) {
                              Utils.toastMessage(
                                  'Student with same registration exist');
                            } else {
                              await StudentController()
                                  .addStudent(studentModel, subId);
                              stdNameController.clear();
                              rollNController.clear();
                            }
                          }
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
