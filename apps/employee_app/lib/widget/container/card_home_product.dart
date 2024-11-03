import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class ProductCards extends StatelessWidget {
  const ProductCards({
    super.key,
    this.onTap,
    this.editButton,
    this.deleteButton,
    required this.image,
    required this.name,
    required this.rating,
    required this.calories,
    required this.price,
    required this.sizeBorder,
    required this.borderColor,
  });
  final void Function()? onTap;
  final void Function()? editButton;
  final void Function()? deleteButton;
  final String image;
  final String name;
  final String rating;
  final int calories;
  final int price;
  final double sizeBorder;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(0.8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: sizeBorder, color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: deleteButton,
                  child: Icon(Icons.disabled_by_default_outlined,
                      size: 20.sp, color: Colors.red),
                ),
                InkWell(
                  onTap: editButton,
                  child: Icon(Icons.edit, size: 20.sp, color: Colors.grey),
                ),
              ],
            ),
            Image.asset(
              image,
              height: 8.5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    Text(
                      rating,
                      style: TextStyle(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$calories سعرة',
                  style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                ),
                Text(
                  '$price رس',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
