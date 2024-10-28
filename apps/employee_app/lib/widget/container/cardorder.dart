import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class CardOrder extends StatelessWidget {
  const CardOrder({
    super.key,
    required this.name,
    required this.quantity,
    required this.onAdd,
    required this.onMinus,
    required this.image,
    required this.isOpenDays,
  });
  final String name;
  final String quantity;
  final String image;
  final Function() onAdd, onMinus;
  final bool isOpenDays;
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
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(1.0.h),
              child: Image.asset(
                image,
                width: 10.w,
                height: 5.h,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            isOpenDays != false
                ? Row(
                    children: [
                      InkWell(
                        onTap: onAdd,
                        child: Container(
                          padding: EdgeInsets.all(1.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xffBA9773),
                          ),
                          child: const Icon(Iconsax.add_outline),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        quantity,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18.sp),
                      ),
                      SizedBox(width: 3.w),
                      InkWell(
                        onTap: onMinus,
                        child: Container(
                          padding: EdgeInsets.all(1.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xffB5C18E),
                          ),
                          child: const Icon(Iconsax.minus_outline),
                        ),
                      ),
                    ],
                  )
                : Text('الكمية $quantity'),
            SizedBox(width: 3.w),
          ],
        ),
      ),
    );
  }
}
