import 'package:customer_app/widget/image/image_handler.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class HomeCard extends StatelessWidget {
  final String productName, price, cal, imagePath;
  final Function()? onTap, onRestriction, onAdd;
  final bool isRestriction;
  final bool withoutButton;
  const HomeCard({
    super.key,
    required this.productName,
    required this.price,
    required this.cal,
    this.onTap,
    this.onRestriction,
    this.onAdd,
    required this.imagePath,
    required this.isRestriction,
    required this.withoutButton,
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
            onTap: withoutButton ? null : onTap,
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
                      const Icon(LineAwesome.fire_alt_solid,
                          color: Color(0xffEC8743))
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
                child: !isRestriction
                    ? ImageHandler(imagePath: imagePath)
                    : ImageHandler(
                        imagePath: imagePath,
                        errorWidget: const Icon(Icons.no_food),
                      ),
              )),
          Positioned(
              left: 27.w,
              bottom: 32.w,
              child: withoutButton
                  ? const Text('')
                  : InkWell(
                      onTap: onRestriction,
                      child:
                          const Icon(Icons.no_food_outlined, color: Colors.red),
                    )),
          Positioned(
            left: 3.w,
            bottom: 8.w,
            child: withoutButton
                ? const Text('')
                : InkWell(
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
