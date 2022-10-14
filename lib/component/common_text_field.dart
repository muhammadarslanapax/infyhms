import 'package:flutter/material.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';

class CommonTextField extends StatelessWidget {
  final String? hintText;
  final Icon? suffixIcon;
  final VoidCallback? onTap;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final int? maxLine;
  final int? minLine;
  final TextInputType? keyBoardType;
  const CommonTextField({
    Key? key,
    this.maxLine,
    this.minLine,
    this.keyBoardType,
    this.hintText,
    required this.validator,
    this.suffixIcon,
    required this.controller,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyBoardType,
      maxLines: maxLine,
      minLines: minLine,
      onTap: onTap,
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
