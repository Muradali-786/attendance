import 'package:flutter/material.dart';

import '../../../../constant/app_style/app_color.dart';
import '../../../../size_config.dart';
import '../../../../utils/components/custom_round_button.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
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
          width: getProportionalWidth(190),
          title: 'EXPORT ATTENDANCE',
          onPress: () {},
          buttonColor: kSecondaryColor,
        ),
      ),
    );
  }
}