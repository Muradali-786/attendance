import 'package:flutter/material.dart';

import '../../constant/app_style/app_color.dart';
import '../../size_config.dart';

class CustomAttendanceList extends StatelessWidget {
  final String stdName, stdRollNo, attendanceStatus;
  final VoidCallback onTap;

  const CustomAttendanceList({
    super.key,
    required this.stdName,
    required this.stdRollNo,
    required this.attendanceStatus,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 0),
      child: Container(
        padding: const EdgeInsets.only(left: 12, right: 17),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: kBlack.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 1.5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stdName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:const TextStyle(fontSize: 22,color: kTextBlackColor)
                  ),
                  Text(
                    stdRollNo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 17,color: kTextGreyColor,height: 1.5)
                  ),
                ],
              ),),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: 53,
                    width: 65,
                    decoration: BoxDecoration(
                      color: getStatusColor(attendanceStatus),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Center(
                      child: Text(
                        attendanceStatus,
                        style:const TextStyle(fontSize: 32,color: kTextWhiteColor,fontWeight: FontWeight.w500)
                      ),
                    ),
                  ),
                ),
              ],
            ),)
          ],
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'A':
        return kSecondaryColor;
      case 'L':
        return kSecondary54Color;
      default:
        return kPrimaryTextColor;
    }
  }
}

class CustomAttendanceList2 extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool showDelete;
  final VoidCallback? onPressDelete;
  const CustomAttendanceList2(
      {super.key,
        required this.title,
        this.showDelete = false,
        required this.onTap,
        this.onPressDelete});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
        child: Container(
          height: getProportionalHeight(47),
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: kBlack.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 1.5,
                  offset: const Offset(
                    0,
                    1,
                  ), // controls the shadow position
                )
              ]),
          child: Row(
            children: [
              Container(
                height: 17,
                width: 17,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: SizeConfig.screenWidth! * 0.05),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: getProportionalWidth(18),color: kTextBlackColor)
                ),
              ),
              if (showDelete)
                IconButton(
                  onPressed: onPressDelete,
                  icon: const Icon(
                    Icons.delete,
                    color: kSecondaryColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAttendanceList3 extends StatelessWidget {
  final String dateTime, attendanceStatus;
  const CustomAttendanceList3(
      {super.key, required this.dateTime, required this.attendanceStatus});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
      child: Container(
        height: SizeConfig.screenHeight! * 0.08,
        width: double.infinity,
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: kBlack.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 1.5,
                offset: const Offset(
                  0,
                  1,
                ), // controls the shadow position
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dateTime,
              style: const TextStyle(fontSize: 12,color: kTextGreyColor)
            ),
            Text(
              getStatusValue(attendanceStatus),
              style: const TextStyle(fontSize: 16,color: kTextBlackColor,height: 1.5)
            ),
          ],
        ),
      ),
    );
  }

  String getStatusValue(String input) {
    switch (input) {
      case 'A':
        return 'ABSENT';
      case 'L':
        return 'LEAVE';
      default:
        return 'PRESENT';
    }
  }
}