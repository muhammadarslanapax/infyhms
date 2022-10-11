import 'package:flutter/material.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    required this.width,
    required this.height,
    required this.text,
    required this.color,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  final double width;
  final double height;
  final String text;
  final Color textColor;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: color,
        elevation: 0,
        fixedSize: Size(width, height),
      ),
      onPressed: onTap,
      child: Text(text, style: TextStyleConst.mediumTextStyle(textColor)),
    );
  }
}
