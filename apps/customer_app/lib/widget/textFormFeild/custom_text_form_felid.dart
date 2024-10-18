import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class CustomTextFormFelid extends StatelessWidget {
  final String label, hintText;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final bool isPassword;
  final TextInputType? keyboardType;
  const CustomTextFormFelid({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.backgroundColor,
    required this.isPassword,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xff103C37)),
          ),
          SizedBox(
            height: 0.5.h,
          ),
          Container(
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
              obscureText: isPassword,
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
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