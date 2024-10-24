import 'package:customer_app/widget/container/product_small_container.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class RestrictionCard extends StatelessWidget {
  final String productName, cal, imagePath, price;
  const RestrictionCard({
    super.key,
    required this.productName,
    required this.cal,
    required this.imagePath,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      margin: EdgeInsets.symmetric(vertical: 1.h),
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: kElevationToShadow[4],
        color: Colors.white,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
            child: Image.asset(
              imagePath,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                productName,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
              ),
              Text(
                '$cal سعرة ',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: const Color(0x50000000)),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  )),
              ProductSmallContainer(isForCal: false, amount: price,isCallWithText: false,)
            ],
          ),
        ],
      ),
    );
  }
}
