import 'package:flutter/material.dart';

import '../constant/app_style/app_color.dart';


class Utils {
  static void onFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // static toastMessage(String message) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     backgroundColor: kBlack,
  //     textColor: kWhite,
  //     fontSize: 16,
  //   );
  // }
}
