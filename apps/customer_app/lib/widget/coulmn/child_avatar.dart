import 'package:flutter/material.dart';

class ChildAvatar extends StatelessWidget {
  final String imagePath, childName;
  final Color? textColor;
  const ChildAvatar(
      {super.key,
      required this.imagePath,
      required this.childName,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        Text(
          childName,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: textColor),
        ),
      ],
    );
  }
}
