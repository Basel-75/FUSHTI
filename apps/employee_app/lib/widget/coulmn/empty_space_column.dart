import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class EmptySpaceColumn extends StatelessWidget {
  final String msg;
  final double? width, height;
  const EmptySpaceColumn({
    super.key,
    required this.msg,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width:width ?? 50.w,
          height:height ?? 20.h,
          child: Image.asset('assets/image/mainLogo.png'),
        ),
        Text(msg)
      ],
    );
  }
}
