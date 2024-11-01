import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class CardStorage extends StatelessWidget {
  const CardStorage({
    super.key,
    required this.name,
    required this.image,
    this.onTap,
    this.controller,
    this.onChanged,
    required this.activeText,
    required this.inactiveText,
    required this.sizeSwitch,
    required this.isAvailable,
  });

  final String name;

  final String image;
  final void Function()? onTap;
  final ValueNotifier<bool>? controller;
  final void Function(dynamic)? onChanged;
  final String activeText;
  final String inactiveText;
  final double sizeSwitch;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ListTile(
            leading: Image.asset(
              image,
            ),
            title: Text(
              name,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // subtitle: Text(
            //   'الكمية: $quantity',
            //   textAlign: TextAlign.right,
            //   style: const TextStyle(
            //     color: Colors.grey,
            //   ),
            // ),
            trailing: AdvancedSwitch(
              initialValue: isAvailable,
              controller: controller,
              activeColor: const Color(0xff6FBAE5),
              inactiveColor: const Color(0xffC8E5F5),
              activeChild: Text(activeText),
              inactiveChild: Text(inactiveText),
              width: 20.w,
              onChanged: onChanged,
            )),
      ),
    );
  }
}
