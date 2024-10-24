import 'package:flutter/material.dart';

class ChildAvatar extends StatelessWidget {
  final String imagePath, childName;
  const ChildAvatar({
    super.key,
    required this.imagePath,
    required this.childName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        Text(
          childName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
