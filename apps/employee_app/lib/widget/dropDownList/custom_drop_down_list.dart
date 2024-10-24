import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class CustomDrop extends StatelessWidget {
  final String label, hintText;
  final String? selectedValue;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextDirection? textDirection;
  final double containerSize;
  final double paddingRightSide;
  final double paddingLeftSide;

  final List<String> items;
  final void Function(String?)? onChanged;

  const CustomDrop({
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
    required this.items,
    this.onChanged,
    this.selectedValue,
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
            child: DropdownButtonFormField<String>(
              value: selectedValue,
              validator: validator,
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.grey),
                hintText: '   $hintText',
                //prefixIcon: Icon(Icons.arrow_drop_down),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.5), width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.5), width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.5), width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: onChanged,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
