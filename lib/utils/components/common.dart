import 'package:flutter/material.dart';
import '../../constant/app_style/app_color.dart';
import '../../size_config.dart';
import 'custom_round_button.dart';

class AddStudentButton extends StatelessWidget {
  final VoidCallback onTap;
  const AddStudentButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: getProportionalHeight(60),
        width: getProportionalHeight(60),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: kSecondaryColor,
        ),
        child: const Icon(
          Icons.add,
          size: 30,
          color: kWhite,
        ),
      ),
    );
  }
}

class ErrorImportStudentClass extends StatelessWidget {
  const ErrorImportStudentClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Icon(
            Icons.error,
            color: kAlertColor,
            size: 30,
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(33, 0, 33, 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "To import students, you need to have at least one existing class. Please create a class first.",
                  style: TextStyle(fontSize: 16, color: kTextGreyColor),
                  textAlign: TextAlign.center,
                ),
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
                    title: 'CLOSE',
                    height: 35,
                    onPress: () {
                      Navigator.pop(context);
                    },
                    buttonColor: kSecondaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EmptyStateText extends StatelessWidget {
  final String title;
  double h;
  EmptyStateText({super.key, required this.title, this.h = 0.0});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.screenHeight! * h),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(color: kTextGreyColor),
        ),
      ),
    );
  }
}

class CustomError extends StatelessWidget {
  const CustomError({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.25),
      child: const Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              color: kAlertColor,
              size: 45,
            ),
            Text('Oops..!',
                style: TextStyle(
                    fontSize: 23,
                    color: kTextBlackColor,
                    fontWeight: FontWeight.w400)),
            SizedBox(
              height: 8,
            ),
            Text('Sorry, Something went wrong',
                style: TextStyle(
                    fontSize: 16,
                    color: kTextBlackColor,
                    fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
  }
}
