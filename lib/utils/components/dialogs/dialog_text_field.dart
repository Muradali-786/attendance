import 'package:flutter/material.dart';
import '../../../constant/app_style/app_color.dart';

class DialogInputTextField extends StatelessWidget {
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFieldSubmittedValue;

  final FormFieldValidator onValidator;
  final TextInputType keyBoardType;
  final bool obsecureText;
  final String hint, labelText;
  final Color cursorColor;
  final bool enable, autoFocus;
  const DialogInputTextField({
    Key? key,
    this.cursorColor =  kSecondaryColor,
    required this.myController,
    required this.focusNode,
    required this.onFieldSubmittedValue,
    required this.hint,
    required this.labelText,
    required this.onValidator,
    required this.keyBoardType,
    this.obsecureText = false,
    this.enable = true,
    this.autoFocus = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmittedValue,
      textCapitalization: TextCapitalization.sentences,
      validator: onValidator,
      keyboardType: keyBoardType,
      cursorColor: cursorColor,
      enabled: enable,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      style:const TextStyle(fontSize: 18,color: kPrimaryTextColor),
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.all(16),
        hintStyle: const TextStyle(fontSize: 20,color: kTextGreyColor),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color:  kFocusBorderColor, width: 1.5),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color:  kAlertColor),
        ),
        labelText: labelText,
        labelStyle:  const TextStyle(fontSize: 14,color: kSecondaryTextColor)
      ),
    );
  }
}