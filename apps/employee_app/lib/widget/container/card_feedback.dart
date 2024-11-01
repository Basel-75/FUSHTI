import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class CartFeedBack extends StatelessWidget {
  const CartFeedBack({
    super.key,
    required this.name,
    required this.description,
    required this.image,
    this.onTap,
  });

  final String name;
  final String description;
  final String image;
  final void Function()? onTap;

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
          leading: CircleAvatar(
            radius: 2.8.h,
            backgroundColor: const Color(0xffC8E5F5),
            child: Image.asset(image),
          ),
          title: Text(
            name,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            description,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          trailing: GestureDetector(
            onTap: onTap,
            child: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
