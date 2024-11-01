import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

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
    this.endPlan,
    this.startPlan,
  });

  final String? startPlan;
  final String? endPlan;

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
    
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
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
        ),
        startPlan != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "تاريخ البداية",
                        style: TextStyle(color: Colors.black, fontSize: 17.sp),
                      ),
                      Text(
                        startPlan ?? "",
                        style: TextStyle(color: Colors.black, fontSize: 17.sp),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "تاريخ النهاية",
                        style: TextStyle(color: Colors.black, fontSize: 17.sp),
                      ),
                      Text(
                        endPlan ?? "",
                        style: TextStyle(color: Colors.black, fontSize: 17.sp),
                      ),
                    ],
                  )
                ],
              )
            : SizedBox()
      ],
    );
  }
}
