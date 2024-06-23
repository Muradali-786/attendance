import 'package:attendance/constant/app_style/app_style.dart';
import 'package:flutter/material.dart';
import '../../constant/app_style/app_color.dart';

class CustomInputTextField extends StatelessWidget {
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFieldSubmittedValue;

  final FormFieldValidator onValidator;
  final TextInputType keyBoardType;
  final bool obsecureText;
  final String labelText;
  final Color cursorColor;
  final Widget? suffixWidget;

  final bool enable, autoFocus, isPasswordField;
  const CustomInputTextField({
    Key? key,
    this.cursorColor = kSecondaryColor,
    required this.myController,
    required this.focusNode,
    required this.onFieldSubmittedValue,
    required this.labelText,
    required this.onValidator,
    required this.keyBoardType,
    this.isPasswordField = false,
    this.suffixWidget,
    this.obsecureText = false,
    this.enable = true,
    this.autoFocus = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextFormField(
        controller: myController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmittedValue,
        validator: onValidator,
        keyboardType: keyBoardType,
        cursorColor: cursorColor,
        obscureText: obsecureText,
        textCapitalization: TextCapitalization.sentences,
        enabled: enable,
        obscuringCharacter: 'x',
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        style: const TextStyle(fontSize: 16, color: kPrimaryTextColor),
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: kWhite,
          labelStyle: TextStyle(
            fontSize: 18,
            color: focusNode.hasFocus ? kSecondaryTextColor : kTextGreyColor,
          ),
          suffixIcon: isPasswordField ? suffixWidget : null,
          suffixIconColor: focusNode.hasFocus ? kPrimaryColor : kGrey,
          contentPadding: const EdgeInsets.all(18),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: kBorderColor,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: kFocusBorderColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: kAlertColor,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: kBorderColor,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }
}
