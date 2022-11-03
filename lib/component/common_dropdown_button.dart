import 'package:flutter/material.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';

class CommonDropDown extends StatelessWidget {
  const CommonDropDown({
    Key? key,
    this.hintText,
    this.dropButtonHeight,
    this.onChange,
    this.errorText,
    this.onTap,
    required this.dropdownItems,
  }) : super(key: key);

  final List<DropdownMenuItem<String>> dropdownItems;
  final String? hintText;
  final double? dropButtonHeight;
  final ValueChanged<String?>? onChange;
  final String? errorText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: DropdownButtonFormField(
        onTap: onTap,
        isExpanded: true,
        // validator: (value) => value == null ? 'Please select any code' : null,
        menuMaxHeight: dropButtonHeight,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        decoration: InputDecoration(
          errorText: errorText,
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE8EAF0), width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE8EAF0), width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyleConst.hintTextStyle(ColorConst.hintGreyColor),
          contentPadding: const EdgeInsets.fromLTRB(10, 30, 10, 8),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE8EAF0), width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE8EAF0), width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        items: dropdownItems,
        onChanged: onChange!,
      ),
    );
  }
}
