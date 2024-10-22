import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class HomeCard extends StatelessWidget {
  final String imagePath, itemName, rate;
  final double price;
  final int cal;
  final Function()? onTap;

  const HomeCard({
    super.key,
    required this.imagePath,
    required this.itemName,
    required this.price,
    required this.cal,
    required this.rate,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        width: 30.w,
        //height: 22.h,
        padding: EdgeInsets.symmetric(horizontal: 0.8.h, vertical: 0.8.h),
        margin: EdgeInsets.only(left: 3.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: kElevationToShadow[4]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              //!Send restriction logic here
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(bottom: 1.h),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.no_food_outlined, color: Colors.red),
              ),
            ),

          ),
          //!Change it later to image network
          Center(child: Image.asset(imagePath)),
          Text(
            itemName,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Text(
                '$cal سعرة',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0x50000000)),
              ),
              const Spacer(),
              InkWell(
                //!Send add logic here
                onTap: () {},
                child: Container(
                  width: 8.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: kElevationToShadow[2],
                      color: const Color(0xffBA9773)),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            children: [
              Text(
                '$price ريال',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Text(
                '$rate/5',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffFFE500)),
              ),
              const Icon(Icons.star_rate_rounded, color: Color(0xffFFE500)),
            ],
          ),
        ],

      ),
    );
  }
}
