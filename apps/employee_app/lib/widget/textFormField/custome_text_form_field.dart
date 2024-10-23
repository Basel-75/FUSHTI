import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class CustomTextFormFelid extends StatelessWidget {
  final String label, hintText;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextDirection? textDirection;
  final double containerSize;
  final double paddingRightSide;
  final double paddingLeftSide;
  final bool hasIcon;
  final Icon iconText;
  const CustomTextFormFelid({
    this.validator,
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.backgroundColor,
    required this.isPassword,
    this.keyboardType,
    this.textDirection,
    required this.containerSize,
    required this.paddingRightSide,
    required this.paddingLeftSide,
    required this.hasIcon,
    required this.iconText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: paddingLeftSide, right: paddingRightSide),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xff103C37)),
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
            width: containerSize,
            decoration: BoxDecoration(
              color: backgroundColor ?? const Color(0xFFf5f6e1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              textDirection: textDirection ?? TextDirection.rtl,
              validator: validator,
              obscureText: isPassword,
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                  prefixIcon: hasIcon != false ? iconText : null,
                  hintStyle: const TextStyle(color: Color(0xffB9B9B9)),
                  hintText: hintText,
                  hintTextDirection: TextDirection.rtl,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
          )
        ],
      ),
    );
  }
}