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
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                 imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/image/mainLogo.png', fit: BoxFit.cover),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
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
