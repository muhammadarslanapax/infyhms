import 'package:flutter/material.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';

class CommonTextField extends StatelessWidget {
  String? hintText;
  Icon? suffixIcon;
  String? Function(String?) validator;
  TextEditingController controller;
  CommonTextField({Key? key, this.hintText, required this.validator, this.suffixIcon, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        hintStyle: TextStyleConst.hintTextStyle(ColorConst.hintGreyColor),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
