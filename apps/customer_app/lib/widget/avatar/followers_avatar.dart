import 'package:customer_app/widget/coulmn/child_avatar.dart';
import 'package:flutter/material.dart';

class FollowersAvatar extends StatelessWidget {
  final String childName;
  final String childImage;
  final Function()? onTap;
  final Color? textColor;
  const FollowersAvatar(
      {super.key,
      required this.onTap,
      required this.childName,
      required this.childImage,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ChildAvatar(
        childName: childName,
        imagePath: childImage,
        textColor: textColor,
      ),
    );
  }
}
