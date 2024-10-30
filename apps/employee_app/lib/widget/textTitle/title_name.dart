import 'package:flutter/material.dart';

class EmpTitleName extends StatelessWidget {
  const EmpTitleName({
    super.key,
    required this.schoolName,
    required this.textSize,
    required this.paddingRight,
    required this.paddingTop,
  });
  final String schoolName;
  final double textSize;
  final double paddingRight;
  final double paddingTop;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: paddingRight, top: paddingTop),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          schoolName,
          style: TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xff546F66)),
        ),
      ),
    );
  }
}
