import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class ContainerStatistics extends StatelessWidget {
  const ContainerStatistics({
    super.key,
    required this.statisticsName,
    required this.statisticsNumber,
    required this.statisticsIcon,
    required this.statisticsNameTxtSize,
    required this.statisticsNumberTxtSize,
    required this.txtColor,
    required this.containerColor,
    required this.containerWidth,
    required this.containerHeight,
  });

  final String statisticsName;
  final int statisticsNumber;
  final Icon statisticsIcon;
  final double statisticsNameTxtSize;
  final double statisticsNumberTxtSize;
  final Color txtColor;
  final Color containerColor;
  final double containerWidth;
  final double containerHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: containerColor,
        border: Border.all(width: 0.2, color: Colors.black26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              statisticsName,
              style:
                  TextStyle(fontSize: statisticsNameTxtSize, color: txtColor),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.money),
                Text(
                  '$statisticsNumber',
                  style: TextStyle(
                      color: txtColor, fontSize: statisticsNumberTxtSize),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}