import 'package:attendance/constant/app_style/app_style.dart';
import 'package:attendance/models/subject/subject_model.dart';
import 'package:attendance/utils/components/custom_stepper.dart';
import 'package:attendance/view_model/student/student_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../constant/app_style/app_color.dart';
import '../../../models/student/student_model.dart';
import '../../../size_config.dart';
import '../../../utils/components/common.dart';
import '../../../utils/components/custom_list_tile.dart';
import '../../../utils/components/custom_round_button.dart';
import '../../../utils/components/dialogs/add_student_dialog.dart';
import '../../../utils/routes/route_name.dart';
import '../../../view_model/boxes/boxes.dart';
import '../../../view_model/subject/subject_controller.dart';
import 'imports/import_dialog.dart';

class AddStudentPage extends StatefulWidget {
  SubjectModel? model;
  AddStudentPage({super.key, required this.model});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  late Future<void> _openBoxesFuture;

  @override
  void initState() {
    super.initState();
    _openBoxesFuture = _openHiveBoxes();
  }

  Future<void> _openHiveBoxes() async {
    await Hive.openBox<StudentModel>(
      "$STUDENT${widget.model!.subjectId}",
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: SizeConfig.screenHeight! * 0.03,
              right: 0,
              left: 0,
              child: const CustomStepper(),
            ),

            ValueListenableBuilder<Box<StudentModel>>(
              valueListenable:
                  Boxes.getStdData(widget.model!.subjectId.toString())
                      .listenable(),
              builder: (context, box, _) {
                var data = box.values.toList().cast<StudentModel>();

                if (box.isNotEmpty) {
                  return Positioned(
                    top: SizeConfig.screenHeight! * 0.1,
                    right: 0,
                    left: 0,
                    child: SizedBox(
                      height: SizeConfig.screenHeight! * 0.83,
                      child: ListView.builder(
                        itemCount: box.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CustomListTile(
                            title: data[index].studentName.toString(),
                            keyValue: data[index].studentId.toString(),
                            subtitle: data[index].studentRollNo.toString(),
                            trailingFirstText:
                                "${data[index].attendancePercentage.toString()}%",
                            trailingSecondText: 'Attendance',
                            onPress: () {},
                            onLongPress: () {},
                            onDismiss: () {
                              StudentController().deleteStudent(data[index]);
                            },
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return Stack(
                    children: [
                      Positioned(
                        top: SizeConfig.screenHeight! * 0.5,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 100.0),
                          child: CustomRoundButton(
                              title: 'IMPORT STUDENTS',
                              height: getProportionalHeight(40),
                              onPress: () {
                                showImportDialog(context, 'classId');
                              },
                              buttonColor: kSecondaryColor),
                        ),
                      ),
                      Positioned(
                        top: SizeConfig.screenHeight! * 0.56,
                        left: 0,
                        right: 0,
                        child: const Text(
                          'Click on the + button to add students in this class',
                          style: TextStyle(
                              fontSize: 13, color: kTextGreyColor, height: 2),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                width: double.infinity,
                height: getProportionalHeight(50),
                decoration: const BoxDecoration(color: kPrimaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: _text('PREVIOUS')),
                    TextButton(
                        onPressed: () {
                          SubjectController().addSubject(widget.model!);
                          Navigator.pushReplacementNamed(
                              context, RouteName.homePage);
                        },
                        child: _text('FINISH')),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: SizeConfig.screenHeight! * 0.03,
              right: 0,
              left: 0,
              child: AddStudentButton(
                onTap: () async {
                  await addStudentDialog(
                      context, widget.model!.subjectId.toString());
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _text(String title) {
    return Text(
      title,
      style: kWhiteMedium,
    );
  }
}
