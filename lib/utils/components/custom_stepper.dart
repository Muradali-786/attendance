import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

import '../../constant/app_style/app_color.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper({super.key});

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int activeStep = 2;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        EasyStepper(
          activeStep: activeStep,
          stepShape: StepShape.circle,
          alignment: Alignment.center,
          lineStyle: LineStyle(
            lineType: LineType.normal,
            lineLength: w * 0.38,
            defaultLineColor: activeStep == 0 || activeStep == 2
                ?   kSubmarine
                :   kPrimaryColor,
            lineThickness: 2,
          ),
          borderThickness: 8,
          stepRadius: 12,
          activeStepBackgroundColor:   kTransparentColor,
          activeStepBorderColor:   kSubmarine,
          finishedStepBorderColor:
          activeStep == 1 ?   kPrimaryColor :   kSubmarine,
          finishedStepBackgroundColor: activeStep == 1
              ?   kPrimaryColor
              :   kTransparentColor,
          defaultStepBorderType: BorderType.normal,
          showLoadingAnimation: false,
          steps: [
            _classStep(),
            _studentsStep(),
          ],
          onStepReached: (index) => setState(() => activeStep = index),
        ),
      ],
    );
  }

  EasyStep _classStep() {
    return EasyStep(
        customStep: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Opacity(
            opacity: activeStep >= 0 ? 1 : 0.3,
            child: activeStep == 0 || activeStep == 2
                ? Container(
              height: 8,
              width: 8,
              decoration: const BoxDecoration(
                color:   kPrimaryColor,
                shape: BoxShape.circle,
              ),
            )
                : const Icon(
              Icons.check,
              size: 18,
              color:   kWhite,
            ),
          ),
        ),
        customTitle: _stepperTitle(title: 'Class'));
  }

  EasyStep _studentsStep() {
    return EasyStep(
        customStep: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: activeStep == 1
              ? Container(
            height: 8,
            width: 8,
            decoration: const BoxDecoration(
              color:   kPrimaryColor,
              shape: BoxShape.circle,
            ),
          )
              : null,
        ),
        customTitle: _stepperTitle(title: 'Students'));
  }

  Widget _stepperTitle({required String title}) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        height: 1.4,
        fontSize: 12,
        color: kTextGrey54Color,
      ),
    );
  }
}