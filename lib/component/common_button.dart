import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    required this.width,
    required this.height,
    required this.text,
    required this.color,
    required this.onTap,
    this.isIcon,
    required this.textStyleConst,
  }) : super(key: key);

  final double width;
  final double height;
  final String text;
  final bool? isIcon;
  final Color color;
  final VoidCallback onTap;
  final TextStyle textStyleConst;

  @override
  Widget build(BuildContext context) {
    return isIcon == true
        ? ElevatedButton.icon(
            icon: const Icon(Icons.videocam_rounded),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: color,
              elevation: 0,
              fixedSize: Size(width, height),
            ),
            onPressed: onTap,
            label: Text(text, style: textStyleConst),
            // child: Text(text, style: textStyleConst),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: color,
              elevation: 0,
              fixedSize: Size(width, height),
            ),
            onPressed: onTap,
            child: Text(
              text,
              style: textStyleConst,
            ),
          );
  }
}
