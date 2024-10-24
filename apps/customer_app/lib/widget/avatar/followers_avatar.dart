import 'package:customer_app/widget/coulmn/child_avatar.dart';
import 'package:flutter/material.dart';

class FollowersAvatar extends StatelessWidget {
  final String childName;
  final String childImage;
  final Function()? onTap;
  const FollowersAvatar({
    super.key,
    required this.onTap,
    required this.childName,
    required this.childImage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ChildAvatar(
        childName: childName,
        imagePath: childImage,
      ),
    );
  }
}
