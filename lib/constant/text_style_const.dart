import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infyhms_flutter/constant/color_const.dart';

class TextStyleConst {
  static TextStyle mediumTextStyle(Color color) => GoogleFonts.nunitoSans(
        fontSize: 17,
        color: color,
        fontWeight: FontWeight.w600,
      );
  static TextStyle boldTextStyle = GoogleFonts.nunitoSans(
    fontSize: 25,
    fontWeight: FontWeight.w700,
  );
  static TextStyle hintTextStyle = GoogleFonts.nunitoSans(
    fontSize: 17,
    color: ColorConst.hintGreyColor,
    fontWeight: FontWeight.w600,
  );
  static TextStyle forgotTextStyle = GoogleFonts.nunitoSans(
    color: ColorConst.blueColor,
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );
}
