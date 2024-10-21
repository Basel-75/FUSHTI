import 'package:flutter/material.dart';

class TextWithTowDirection extends StatelessWidget {
  const TextWithTowDirection({
    super.key,
    required this.leftText,
    required this.rightText,
    required this.leftTextSize,
    required this.rightTextSize,
    required this.leftTextColor,
    required this.rightTextColor,
    this.leftFontFamily,
    this.rightFontFamily,
    required this.mainAxisAlignment,
    required this.isRightClickable,
    this.onPressed,
  });

  final String leftText;
  final String rightText;
  final double leftTextSize;
  final double rightTextSize;
  final Color leftTextColor;
  final Color rightTextColor;
  final String? leftFontFamily;
  final String? rightFontFamily;
  final MainAxisAlignment mainAxisAlignment;
  final bool isRightClickable;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(
          leftText,
          style: TextStyle(
              fontSize: leftTextSize,
              color: leftTextColor,
              fontFamily: leftFontFamily),
        ),
        isRightClickable
            ? TextButton(
                onPressed: onPressed,
                child: Text(
                  rightText,
                  style: TextStyle(
                      fontSize: rightTextSize,
                      color: rightTextColor,
                      fontFamily: rightFontFamily),
                ))
            : Text(
                rightText,
                style: TextStyle(
                    fontSize: rightTextSize,
                    color: rightTextColor,
                    fontFamily: rightFontFamily),
              )
      ],
    );
  }
}
