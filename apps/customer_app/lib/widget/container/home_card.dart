import 'package:customer_app/widget/image/image_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class OldHomeCard extends StatelessWidget {
  final String imagePath, itemName, rate;
  final double price;
  final int cal;
  final Function()? onTap;
  final Function()? onRestriction;
  const OldHomeCard(
      {super.key,
      required this.imagePath,
      required this.itemName,
      required this.price,
      required this.cal,
      required this.rate,
      this.onTap,
      this.onRestriction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30.w,
        padding: EdgeInsets.symmetric(horizontal: 0.8.h, vertical: 0.8.h),
        margin: EdgeInsets.only(left: 3.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: kElevationToShadow[4],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onRestriction,
              child: Container(
                margin: EdgeInsets.only(bottom: 1.h),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.no_food_outlined, color: Colors.red),
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
                      color: const Color(0x50000000)),
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
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Text(
                  '$rate/5',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffFFE500)),
                ),
                const Icon(Icons.star_rate_rounded, color: Color(0xffFFE500)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final String productName, price, cal, imagePath;
  final Function()? onTap, onRestriction, onAdd;
  final bool isRestriction;
  const HomeCard({
    super.key,
    required this.productName,
    required this.price,
    required this.cal,
    this.onTap,
    this.onRestriction,
    this.onAdd,
    required this.imagePath, required this.isRestriction,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.w,
      width: 35.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              width: 35.w,
              height: 35.w,
              margin: EdgeInsets.symmetric(horizontal: 1.w),
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: kElevationToShadow[8]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    productName,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 1.w,
                  ),
                  Text(
                    '$price رس',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Text(
                        cal,
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0x50000000)),
                      ),
                      const Icon(LineAwesome.fire_alt_solid, color: Color(0xffEC8743))
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              left: 12.w,
              bottom: 28.w,
              child: CircleAvatar(
                backgroundColor: const Color(0x88C8E5F5),
                child:!isRestriction?ImageHandler(imagePath: imagePath) :ImageHandler(imagePath: imagePath,errorWidget: const Icon(Icons.no_food),),
              )),
          Positioned(
              left: 27.w,
              bottom: 32.w,
              child: InkWell(
                onTap: onRestriction,
                child: const Icon(Icons.no_food_outlined, color: Colors.red),
              )),
          Positioned(
            left: 3.w,
            bottom: 8.w,
            child: InkWell(
              onTap: onAdd,
              child: Container(
                width: 8.w,
                height: 7.w,
                decoration: BoxDecoration(
                    color: const Color(0xffC9E7E7),
                    borderRadius: BorderRadius.circular(6)),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
