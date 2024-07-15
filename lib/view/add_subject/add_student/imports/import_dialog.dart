import 'package:flutter/material.dart';
import '../../../../constant/app_style/app_color.dart';
import '../../../../size_config.dart';
import '../../../../utils/components/custom_round_button.dart';

Future<void> showImportDialog(
    BuildContext context, String currentClassId) async {
  SizeConfig().init(context);
  await showDialog(
    context: context,
    builder: (BuildContext context) {
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
                  const Text('Import Students',
                      style: TextStyle(
                        fontSize: 22,
                        color: kTextWhiteColor,
                      ),),
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
            SizedBox(
              height: SizeConfig.screenHeight! * 0.020,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.14),
                  child: CustomRoundButton(
                      height: 35,
                      title: 'IMPORT FROM EXCEL',
                      onPress: () async {
                        Navigator.pop(context);
                        // await importExcelSheetDialog(context,currentClassId);
                      },
                      buttonColor: kSecondaryColor),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth! * 0.54,
                  child: const Divider(
                    color: kSecondaryColor,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.14),
                  child: CustomRoundButton(
                      height: 35,
                      title: 'IMPORT FROM CLASS',
                      onPress: () async {
                        Navigator.pop(context);
                        // importStudentFromClassesDialog(context, null,currentClassId);
                      },
                      buttonColor: kSecondaryColor),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.020,
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
