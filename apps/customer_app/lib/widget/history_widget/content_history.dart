import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class ContentHistory extends StatelessWidget {
  const ContentHistory({
    super.key,
    required this.image,
    required this.foodName,
    required this.numberOfCal,
    required this.quantity,
    required this.price,
    required this.isBill,
  });

  final String image;
  final String foodName;
  final int numberOfCal;
  final int quantity;
  final int price;
  final bool isBill;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isBill != true
            ? Image.asset(
                image,
                height: 8.h,
              )
            : const SizedBox(),
        SizedBox(
          width: 1.5.w,
        ),
        isBill != true
            ? Container(
                width: 1.w,
                height: 8.5.h,
                decoration: const BoxDecoration(
                    color: Color(0xffBA9773),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              )
            : const SizedBox(),
        SizedBox(
          width: 2.w,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                foodName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$numberOfCal سعرة',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.50),
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('x$quantity'),
            Text('رس $price'),
          ],
        ),
      ],
    );
  }
}
