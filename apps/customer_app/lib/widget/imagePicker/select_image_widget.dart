import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class SelectImageWidget extends StatelessWidget {
  final Function()? onTapInCamera;
  final void Function()? onDelete;
  const SelectImageWidget({
    super.key,
    this.onTapInCamera,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2),
          color: Color.fromARGB(255, 235, 233, 228)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            onPressed: onTapInCamera,
            icon: Icon(
              Icons.add_a_photo_outlined,
              size: 10.h,
            ),
          ),
          Positioned(
            left: 19.w,
            top: 19.w,
            child: IconButton(
              onPressed: onDelete,
              icon: Icon(
                Icons.delete_outline_rounded,
                color: Colors.red,
                size: 3.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
