import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class CustomTextArea extends StatelessWidget {
  final String label, hintText;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final String? Function(String?)? validator;
  final TextDirection? textDirection;
  final double containerSize;
  final double padding;

  const CustomTextArea({
    super.key,
    this.validator,
    required this.label,
    required this.hintText,
    this.controller,
    this.backgroundColor,
    required this.containerSize,
    required this.padding,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
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
          SizedBox(height: 1.h),
          Container(
            width: containerSize,
            decoration: BoxDecoration(
              color: backgroundColor ?? const Color(0xffF6FAFD),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.2,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              controller: controller,
              validator: validator,
              textDirection: textDirection ?? TextDirection.rtl,
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: null,
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Color(0xffB9B9B9)),
                hintText: hintText,
                hintTextDirection: TextDirection.rtl,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Colors.grey
                          .withOpacity(0.2)), // Border color when enabled
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
