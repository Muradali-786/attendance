import 'package:attendance/models/subject/subject_model.dart';
import 'package:attendance/utils/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../constant/app_style/app_color.dart';
import '../../size_config.dart';
import '../../utils/components/custom_round_button.dart';
import '../../utils/components/custom_stepper.dart';
import '../../utils/components/custon_input_text_field.dart';
import '../../utils/utils.dart';
import '../../view_model/boxes/boxes.dart';

class AddSubjectPage extends StatefulWidget {
  const AddSubjectPage({super.key});

  @override
  State<AddSubjectPage> createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  final _formKey = GlobalKey<FormState>();
  late final String _subId;
  TextEditingController subjectController = TextEditingController();
  FocusNode subjectFocus = FocusNode();
  TextEditingController batchController = TextEditingController();
  FocusNode batchFocus = FocusNode();
  TextEditingController departmentController = TextEditingController();
  FocusNode departmentFocus = FocusNode();
  TextEditingController percentageController = TextEditingController();
  FocusNode percentageFocus = FocusNode();
  TextEditingController cHourController = TextEditingController();
  FocusNode cHourFocus = FocusNode();
  final Uuid _uuid = const Uuid();

  @override
  void initState() {
    _subId = _uuid.v4().toString();
    Boxes().openStudentBox(_subId);
    Boxes().openAttendanceBox(_subId);
    super.initState();
  }

  @override
  void dispose() {
    subjectController.dispose();
    subjectFocus.dispose();
    batchController.dispose();
    batchFocus.dispose();
    departmentController.dispose();
    departmentFocus.dispose();
    percentageController.dispose();
    percentageFocus.dispose();
    cHourController.dispose();
    cHourFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: kWhite,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight! * 0.03),
                const CustomStepper(),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomInputTextField(
                        myController: subjectController,
                        focusNode: subjectFocus,
                        onFieldSubmittedValue: (val) {
                          Utils.onFocusChange(
                              context, subjectFocus, departmentFocus);
                        },
                        labelText: 'Subject',
                        onValidator: (val) {
                          if (val.trim().isEmpty) {
                            return 'Please enter a subject';
                          } else if (val.trim().length < 3) {
                            return 'Subject cannot contain special characters';
                          } else if (!RegExp(r'^[a-zA-Z0-9 ]+$')
                              .hasMatch(val)) {
                            return 'Subject cannot contain special characters';
                          }
                          return null;
                        },
                        keyBoardType: TextInputType.text,
                      ),
                      CustomInputTextField(
                          myController: departmentController,
                          focusNode: departmentFocus,
                          onFieldSubmittedValue: (val) {
                            Utils.onFocusChange(
                                context, departmentFocus, batchFocus);
                          },
                          labelText: 'Department',
                          onValidator: (val) {
                            if (val.trim().isEmpty) {
                              return 'Please enter a department';
                            } else if (val.trim().length < 2) {
                              return 'Subject must be at least 2 characters long';
                            } else if (!RegExp(r'^[a-zA-Z0-9 ]+$')
                                .hasMatch(val)) {
                              return 'Department cannot contain special characters';
                            }
                            return null;
                          },
                          keyBoardType: TextInputType.emailAddress),
                      CustomInputTextField(
                          myController: batchController,
                          focusNode: batchFocus,
                          onFieldSubmittedValue: (val) {
                            Utils.onFocusChange(
                                context, batchFocus, cHourFocus);
                          },
                          labelText: 'Semester/Batch',
                          onValidator: (val) {
                            if (val.trim().isEmpty) {
                              return 'Please enter a Semester/Batch';
                            } else if (val.trim().length < 4) {
                              return 'Semester/Batch must be at least 4 characters long';
                            } else if (!RegExp(r'^[a-zA-Z0-9 ]+$')
                                .hasMatch(val)) {
                              return 'Semester/Batch cannot contain special characters';
                            }

                            return null;
                          },
                          keyBoardType: TextInputType.streetAddress),
                      CustomInputTextField(
                          myController: cHourController,
                          focusNode: cHourFocus,
                          onFieldSubmittedValue: (val) {
                            Utils.onFocusChange(
                                context, cHourFocus, percentageFocus);
                          },
                          labelText: 'Credit Hour',
                          onValidator: (val) {
                            if (val.isEmpty) {
                              return 'Please enter a credit Hour';
                            } else if (val.length != 1 ||
                                !(val == '1' ||
                                    val == '2' ||
                                    val == '3' ||
                                    val == '4')) {
                              return 'Please Enter 1,2, 3, or 4';
                            }
                            return null;
                          },
                          keyBoardType: TextInputType.number),
                      CustomInputTextField(
                          myController: percentageController,
                          focusNode: percentageFocus,
                          onFieldSubmittedValue: (val) {},
                          labelText: 'Attendance Requirement (%)',
                          onValidator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter attendance percentage.';
                            } else if (double.tryParse(val) == null) {
                              return 'Please enter a valid number.';
                            } else if (double.parse(val) >= 100 ||
                                double.parse(val) < 10) {
                              return 'Enter attendance (10% - 100%)';
                            }
                            return null;
                          },
                          keyBoardType: TextInputType.number),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: CustomRoundButton(
        height: getProportionalHeight(55),
        width: double.infinity,
        buttonColor: kPrimaryColor,
        title: 'Next',
        onPress: () async {
          if (_formKey.currentState!.validate()) {
            final model = SubjectModel(
              subjectId: _subId,
              subjectName: subjectController.text.trim(),
              teacherId: 'teacherId',
              departmentName: departmentController.text.trim(),
              batchName: batchController.text.trim(),
              creditHour: cHourController.text.trim(),
              percentage: int.tryParse(percentageController.text.trim()),
            );

            Navigator.pushNamed(
              context,
              RouteName.addStudentPage,
              arguments: model,
            );
          }
        },
      ),
    );
  }
}
