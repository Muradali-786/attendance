
import 'package:attendance/constant/app_style/app_style.dart';
import 'package:flutter/material.dart';
import '../../constant/app_style/app_color.dart';

class CustomRoundButton extends StatelessWidget {
  final String title;
  final double height,textSize;
  final double width;
  final VoidCallback onPress;
  final Color buttonColor;
  final bool loading;

  const CustomRoundButton({
    Key? key,
    required this.title,
    required this.onPress,
    required this.buttonColor,
    this.width = double.infinity,
    this.height = 50,
    this.textSize = 14,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: loading
            ? const Center(
          child: CircularProgressIndicator(
            color: kWhite,
          ),
        )
            : Center(
          child: Text(
            title,
            style:const TextStyle(fontSize: 14,color: kWhite,fontWeight: FontWeight.w600)
          ),
        ),
      ),
    );
  }
}
