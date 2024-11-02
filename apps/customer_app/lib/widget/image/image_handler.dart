import 'package:flutter/material.dart';

class ImageHandler extends StatelessWidget {
  const ImageHandler({
    super.key,
    required this.imagePath,
    this.errorWidget,
  });

  final String imagePath;
  final Widget? errorWidget;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      fit: BoxFit.contain,
      imagePath,
      errorBuilder: (context, error, stackTrace) =>
          errorWidget ??
          const Icon(
            Icons.fastfood_rounded,
            color: Colors.orange,
          ),
      loadingBuilder: (context, child, loadingProgress) =>
          loadingProgress == null
              ? child
              : CircularProgressIndicator(
                  color: Colors.white,
                ),
    );
  }
}
