import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    required this.width,
    required this.height,
    required this.text,
    required this.color,
    required this.onTap,
    required this.textStyleConst,
  }) : super(key: key);

  final double width;
  final double height;
  final String text;

  final Color color;
  final VoidCallback onTap;
  final TextStyle textStyleConst;

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
      child: Text(text, style: textStyleConst),
    );
  }
}
