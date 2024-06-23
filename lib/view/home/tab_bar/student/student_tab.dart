import 'package:flutter/material.dart';

import '../../../../constant/app_style/app_color.dart';
import '../../../../size_config.dart';
import '../../../../utils/components/custom_round_button.dart';

class StudentTab extends StatefulWidget {
  const StudentTab({super.key});

  @override
  State<StudentTab> createState() => _StudentTabState();
}

class _StudentTabState extends State<StudentTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('student')
        ],
      ),
      bottomSheet: Container(
        height: 36,
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.only(bottom: 16),
        child: CustomRoundButton(
          height: getProportionalHeight(36),
          width: getProportionalWidth(140),
          title: 'ADD STUDENT',
          onPress: () {},
          buttonColor: kSecondaryColor,
        ),
      ),
    );
  }
}
