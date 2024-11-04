import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required this.sizeBoxHeight,
    required this.sizeBoxWidth,
    required this.image,
  });

  final double sizeBoxHeight;
  final double sizeBoxWidth;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: sizeBoxHeight,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: sizeBoxWidth,
            ),
            Image.asset(image),
          ],
        ),
      ],
    );
  }
}
