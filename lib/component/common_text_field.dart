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
  final bool readOnly;

  const CommonTextField({
    Key? key,
    this.maxLine,
    this.readOnly = false,
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
    final width = MediaQuery.of(context).size.width;
    return TextFormField(
      style: TextStyleConst.mediumTextStyle(
        ColorConst.blackColor,
        width * 0.04,
      ),
      readOnly: readOnly,
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
